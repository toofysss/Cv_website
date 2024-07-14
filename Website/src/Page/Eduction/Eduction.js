import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import app from "../../api";
import "./eduction.css";
import Loading from "../loading/loading";
import { collection, getDocs, getFirestore } from "firebase/firestore";
function Eduction() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [t, il8n] = useTranslation();
  const midpointIndex = Math.ceil(data.length / 2);
  const firstHalfData = data.slice(0, midpointIndex);
  const secondHalfData = data.slice(midpointIndex);

  useEffect(() => {
    const fetchData = async () => {
      const db = getFirestore(app);

      const colRef = collection(db, "Eduction");
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
    <section className="eduction" id="eduction">
      <h2 className="heading">
        <span>{t("N3")}</span>
      </h2>
      {loading && <Loading />}

      {!loading && (
        <>
          <div
            dir={il8n.language == "en" ? "ltr" : "rtl"}
            className="eduction-row"
          >
            <div className="eduction-column">
              {firstHalfData.length > 0 && (
                <div
                  dir={il8n.language == "en" ? "ltr" : "rtl"}
                  className="eduction-box"
                >
                  {firstHalfData.map((item, index) => (
                    <div className="eduction-content" key={index}>
                      <div className="content">
                        <div className="year">
                          <i className="bx bxs-calendar"></i> {item.year}
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
            <div className="eduction-column">
              {secondHalfData.length > 0 && (
                <div
                  dir={il8n.language == "en" ? "ltr" : "rtl"}
                  className="eduction-box"
                >
                  {secondHalfData.map((item, index) => (
                    <div className="eduction-content" key={index}>
                      <div className="content">
                        <div className="year">
                          <i className="bx bxs-calendar"></i> {item.year}
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

export default Eduction;
