import React, { useState, useEffect } from "react";
import { Typewriter } from "react-simple-typewriter";
import { useTranslation } from "react-i18next";
import logo from "../../Asset/logo.jpg";
import app from "../../api";
import "./home.css";
import { collection, getDocs, getFirestore } from "firebase/firestore";
import Loading from "../loading/loading";
function Home() {
  const [data, setData] = useState([]);
  const [aboutdata, setaboutData] = useState([]);
  const [loading, setIsLoading] = useState(true);

  const [t, il8n] = useTranslation();
  useEffect(() => {
    const fetchData = async () => {
      const db = getFirestore(app);

      const colRef = collection(db, "Home");
      const snapshot = await getDocs(colRef);
      const newData = snapshot.docs.map((doc) => ({
        ...doc.data(),
        active: false,
      }));
      setData(newData);

      const colaboutRef = collection(db, "About");
      const aboutsnapshot = await getDocs(colaboutRef);
      const aboutsnapshotnewData = aboutsnapshot.docs.map((doc) => ({
        ...doc.data(),
        active: false,
      }));
      setaboutData(aboutsnapshotnewData);
      setIsLoading(false);
    };

    fetchData();
  }, []);
  return (
    <div>
      {loading && (
        <section>
          <Loading />
        </section>
      )}
      {!loading && (
        <>
          <section
            dir={il8n.language == "en" ? "ltr" : "rtl"}
            className="home"
            id="home"
          >
            <div className="home-content">
              <div className="text-animate">
                <h1>
                  <span>{t("Name")} </span>
                </h1>

                <h3>
                  <span style={{ color: "white" }}>{t("i")} </span>
                  {data && data.length > 0 && data[0].lang && (
                    <Typewriter
                      words={data.map((item) => item.lang)}
                      loop={Infinity}
                      cursor
                      cursorStyle="|"
                      typeSpeed={100}
                      deleteSpeed={50}
                      delaySpeed={1000}
                    />
                  )}
                </h3>
                <p>{t("About")} </p>
                {aboutdata && aboutdata.length > 0 && aboutdata[0].linkCv && (
                  <a href={aboutdata[0].linkCv} className="btn">
                    {t("DownloadCv")}
                  </a>
                )}
              </div>
            </div>
            <div className="home-img">
              <img src={logo} alt="My Logo"></img>
              <span className="circle-spin"></span>
            </div>
          </section>
        </>
      )}
    </div>
  );
}

export default Home;
