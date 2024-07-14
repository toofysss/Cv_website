import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import app from "../../api";
import "./skills.css";
import Loading from "../loading/loading";
import { collection, query, getDocs, getFirestore } from "firebase/firestore";

function Skills() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [t, il8n] = useTranslation();
  useEffect(() => {
    const fetchData = async () => {
      const db = getFirestore(app);
      const colRef = collection(db, "Skills");
      const snapshot = await getDocs(colRef);
      const SkillssData = await Promise.all(
        snapshot.docs.map(async (doc) => {
          const SkillsData = doc.data();
          const SkillsId = doc.id;
          const SkillsQuery = query(collection(doc.ref, "Skills"));
          const SkillsSnapshot = await getDocs(SkillsQuery);
          const Skillss = SkillsSnapshot.docs.map((SkillsDoc) => ({
            id: SkillsDoc.id,
            ...SkillsDoc.data(),
            active: false,
          }));
          return { id: SkillsId, ...SkillsData, Skillss };
        })
      );

      setData(SkillssData);
      setLoading(false);
    };

    fetchData();
  }, []);
  return (
    <section className="Skills" id="Skills">
      <h2 className="heading">
        <span>{t("N5")}</span>
      </h2>
      {loading && <Loading />}
      {!loading && (
        <>
          <div className="Skills-row">
            {data.length > 0 &&
              data.map((item, index) => (
                <div className="Skills-column" key={index}>
                  <h2
                    className="title"
                    dir={il8n.language == "en" ? "ltr" : "rtl"}
                  >
                    {il8n.language == "en" ? item.Title : item.TitleA}
                  </h2>
                  <div className="Skills-box">
                    <div className="Skills-content">
                      {item.Skillss.map((item, index) => (
                        <div className="progress_bar" key={index}>
                          <ul>
                            <li>{item.lang}</li>
                          </ul>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              ))}
          </div>
        </>
      )}
    </section>
  );
}

export default Skills;
