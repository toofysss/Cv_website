import { useTranslation } from "react-i18next";
import logo from '../../Asset/logo.jpg';
function About({ data }) {
  const { aboutData } = data;
  const [t, il8n] = useTranslation();

  return (
    <section className="about" id="about">
      <h2 className="heading">
        <span>{t("N2")}</span>
      </h2>
      <div className="about-img">
        <img src={logo} alt=""></img>
        <span className="circle-spin"></span>
      </div>
      <div className="about-content">
        <p>{t("About")} </p>
      </div>
    </section>
  );
}

export default About;
