import applestore from "../../Asset/apple-app-store.svg";
import googlePlay from "../../Asset/google-play.svg";
import website from "../../Asset/website.png";
import mega from "../../Asset/mega.png";
import { useTranslation } from "react-i18next";
import { useLocation } from "react-router-dom";
import Loading from "../loading/loading";
import "./details.css";
function Details() {
  const [il8n] = useTranslation();

  const location = useLocation();
  const { program } = location.state || {};

  if (!program) {
    return <Loading />;
  }
  return (
    <section className="popup">
      <div className="popup-content">
        <div className="details-content">
          <img className="ProjectImg" src={program.ImgProfile} alt=""></img>
          <div className="details-text">
            <h3>{program.Name}</h3>
            <h4>{program.Dscrp}</h4>
            <div className="app-icons">
              {program.Links && (
                <div>
                  {program.Links.Appstore && (
                    <a
                      href={program.Links.Appstore}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <img src={applestore} alt="Apple Store" />
                    </a>
                  )}

                  {program.Links.GooglePlay && (
                    <a
                      href={program.Links.GooglePlay}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <img src={googlePlay} alt="Apple Store" />
                    </a>
                  )}
                  {program.Links.Website && (
                    <a
                      href={program.Links.Website}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <img
                        style={{
                          filter:
                            "grayscale(100%) brightness(50%) sepia(100%) saturate(10000%)hue-rotate(184deg)",
                        }}
                        src={website}
                        alt="Apple Store"
                      />
                    </a>
                  )}

                  {program.Links.Mega && (
                    <a
                      rel="noopener noreferrer"
                      href={program.Links.Mega}
                      target="_blank"
                    >
                      <img src={mega} alt="Apple Store" />
                    </a>
                  )}
                </div>
              )}
            </div>
          </div>
        </div>
        <div className="listimage">
          {program.ImgList &&
            program.ImgList.map((img, index) => (
              <img key={index} src={img} alt=""></img>
            ))}
        </div>
      </div>
    </section>
  );
}

export default Details;
