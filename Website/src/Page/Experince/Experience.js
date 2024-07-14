import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import "./experience.css";
import app from "../../api";

import Loading from "../loading/loading";
import { collection, getDocs, getFirestore } from "firebase/firestore";
function Experience() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [t, il8n] = useTranslation();

  const midpointIndex = Math.ceil(data.length / 2);
  const firstHalfData = data.slice(0, midpointIndex);
  const secondHalfData = data.slice(midpointIndex);
  useEffect(() => {
    const fetchData = async () => {
      const db = getFirestore(app);

      const colRef = collection(db, "Experience");
      const snapshot = await getDocs(colRef);
      const newData = snapshot.docs.map((doc) => ({
        ...doc.data(),
        active: false,
      }));
      setData(newData);
      setLoading(false);
    };

    fetchData();
  }, []);
  return (
    <section className="experience" id="experience">
      <h2 className="heading">
        <span>{t("N4")}</span>
      </h2>
      {loading && <Loading />}

      {!loading && (
        <>
          <div
            dir={il8n.language == "en" ? "ltr" : "rtl"}
            className="experience-row"
          >
            <div className="experience-column">
              {firstHalfData.length > 0 && (
                <div
                  dir={il8n.language == "en" ? "ltr" : "rtl"}
                  className="experience-box"
                >
                  {firstHalfData.map((item, index) => (
                    <div className="experience-content" key={index}>
                      <div className="content">
                        <div className="year">
                          <i className="bx bxs-calendar"></i> {item.Year}
                        </div>
                        <h3>
                          {il8n.language == "en" ? item.Title : item.TitleA}
                        </h3>
                        <p>
                          {il8n.language == "en" ? item.Dscrp : item.DscrpA}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
            <div className="experience-column">
              {secondHalfData.length > 0 && (
                <div
                  dir={il8n.language == "en" ? "ltr" : "rtl"}
                  className="experience-box"
                >
                  {secondHalfData.map((item, index) => (
                    <div className="experience-content" key={index}>
                      <div className="content">
                        <div className="year">
                          <i className="bx bxs-calendar"></i> {item.Year}
                        </div>
                        <h3>
                          {il8n.language == "en" ? item.Title : item.TitleA}
                        </h3>
                        <p>
                          {il8n.language == "en" ? item.Dscrp : item.DscrpA}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
        </>
      )}
    </section>
  );
}

export default Experience;
