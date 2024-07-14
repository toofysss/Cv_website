import "./footer.css";
function Footer() {
  const footer = [
    {
      id: "https://www.facebook.com/profile.php?id=100021865501901&mibextid=ZbWKwL",
      icon: "bx bxl-facebook-circle",
    },
    { id: "https://wa.me/9647737446118", icon: "bx bxl-whatsapp" },
    { id: "https://t.me/toofy_s", icon: "bx bxl-telegram" },
    {
      id: "https://www.instagram.com/toofy_.s?utm_source=qr&igsh=djNrb25lamUxaGEz",
      icon: "bx bxl-instagram",
    },
    {
      id: "https://www.linkedin.com/in/mustafa-saad-761488282?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
      icon: "bx bxl-linkedin",
    },
    {
      id: "https://github.com/toofysss/",
      icon: "bx bxl-github",
    },
  ];
  return (
    <footer className="site-footer">
      <div className="container">
        <div className="row">
          <div className="col-md-8 col-sm-6 col-xs-12">
            <p className="copyright-text">
              Copyright &copy; 2024 All Rights Reserved by <span>MS</span>
            </p>
          </div>

          <div className="col-md-4 col-sm-6 col-xs-12">
            <ul className="social-media">
              {footer.map((item) => (
                <a
                  rel="noopener noreferrer"
                  key={item.id}
                  target="_blank"
                  href={item.id}
                >
                  <i className={item.icon}></i>
                </a>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </footer>
  );
}

export default Footer;
