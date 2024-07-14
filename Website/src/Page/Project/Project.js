import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import app from "../../api";
import "./project.css";
import Loading from "../loading/loading";
import { collection, query, getDocs, getFirestore } from "firebase/firestore";
import { useNavigate } from "react-router-dom";
import placeimg from "../../Asset/logo.png";

function Project() {
  const [currentFilter, setCurrentFilter] = useState("*");
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [t, il8n] = useTranslation();
  const navigate = useNavigate();
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      const db = getFirestore(app);
      const colRef = collection(db, "Project");
      const snapshot = await getDocs(colRef);
      const ProjectsData = await Promise.all(
        snapshot.docs.map(async (doc) => {
          const ProgramData = doc.data();
          const ProgramId = doc.id;
          const ProgramQuery = query(collection(doc.ref, "Program"));
          const ProgramSnapshot = await getDocs(ProgramQuery);
          const Programs = ProgramSnapshot.docs.map((ProgramDoc) => ({
            id: ProgramDoc.id,
            ...ProgramDoc.data(),
            active: false,
          }));
          return { id: ProgramId, ...ProgramData, Programs };
        })
      );

      setData(ProjectsData);
      setLoading(false);
    };

    fetchData();
  }, []);

  const handleFilterClick = (filter) => {
    setCurrentFilter(filter);
  };

  const handleCardClick = (program) => {
    navigate("/project/details", { state: { program: program } });
  };

  return (
    <section className="project" id="project">
      {loading && <Loading />}

      {!loading && (
        <>
          <div>
            <div className="project-nav" id="filter-button">
              <ul>
                <li
                  onClick={() => handleFilterClick("*")}
                  className={currentFilter === "*" ? "current" : ""}
                >
                  <span>{t("allcatagory")}</span>
                </li>
                {data.length > 0 &&
                  data.map((item, index) => (
                    <li
                      onClick={() => handleFilterClick(item.Title)}
                      className={currentFilter === item.Title ? "current" : ""}
                      key={index}
                    >
                      <span>
                        {il8n.language === "en" ? item.Title : item.TitleA}
                      </span>
                    </li>
                  ))}
              </ul>
            </div>
            <div className="portfoliocontainer">
              {data
                .filter(
                  (project) =>
                    currentFilter === "*" || project.Title === currentFilter
                )
                .map((project, index) => (
                  <div key={index}>
                    {project.Programs.map((programItem, programIndex) => (
                      <div key={programIndex}>
                        <div
                          className="card__projects"
                          dir={il8n.language === "en" ? "ltr" : "ltr"}
                        >
                          <div className="card__img">
                            <img
                              className={` ${isLoading ? "loading" : ""}`}
                              src={
                                isLoading ? placeimg : programItem.ImgProfile
                              }
                              alt=""
                              onLoad={() => setIsLoading(false)}
                            ></img>
                          </div>
                          <div className="card__info">
                            <h2 className="card__title">{programItem.Name}</h2>
                            <p className="card-text">{programItem.Dscrp}</p>
                            <button
                              className="bt__card"
                              onClick={() => handleCardClick(programItem)}
                            >
                              {t("Details")}
                            </button>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                ))}
            </div>
          </div>
        </>
      )}
    </section>
  );
}

export default Project;
