import React, { useState, useEffect, useRef } from "react";
import logo from "../../Asset/logo.png";
import { useTranslation } from "react-i18next";
import { Link, useLocation } from "react-router-dom";

import "./Navbar.css";
function Navbar() {
  const [isMenuOpen, setMenuOpen] = useState(false);
  const location = useLocation();

  const [selectedLink, setSelectedLink] = useState(null);
  const [t, il8n] = useTranslation();
  const dropdownRef = useRef(null);

  const handleMenuClick = (event) => {
    event.stopPropagation();
    setMenuOpen(!isMenuOpen);
    window.scrollTo(0, 0);
  };

  const handleDropdownChange = (e) => {
    il8n.changeLanguage(e.target.value);
    setMenuOpen(false);
  };

  const links = [
    { id: "home", label: t("N1") },
    { id: "eduction", label: t("N3") },
    { id: "experience", label: t("N4") },
    { id: "skills", label: t("N5") },
    { id: "project", label: t("N6") },
  ];

  useEffect(() => {
    const currentPath = location.pathname;
    if (currentPath === "/") {
      setSelectedLink(links[0].id);
    } else {
      const linkId = currentPath.split("/")[1];
      setSelectedLink(linkId);
    }
  }, [location.pathname]);

  return (
    <header dir={il8n.language == "en" ? "ltr" : "rtl"} className="header">
      <h1 href="#" className="logo">
        <img src={logo} alt=""></img>
      </h1>
      <i className="bx bx-menu" id="menu-icon" onClick={handleMenuClick}></i>
      <nav className={`navbar ${isMenuOpen ? "open" : ""}`}>
        {links.map((link) => (
          <Link
            key={link.id}
            onClick={handleMenuClick}
            to={`/${link.id.toLowerCase()}`}
            className={`navbtn ${selectedLink === link.id ? "active" : ""}`}
          >
            {link.label}
          </Link>
        ))}

        <div ref={dropdownRef}>
          <select className="dropdown-select" onChange={handleDropdownChange}>
            <option hidden>{t("lang")}</option>
            <option className={`navbartext `} value="en">
              {t("En")}
            </option>
            <option className={`navbartext  `} value="ar">
              {t("Ar")}
            </option>
          </select>
        </div>
      </nav>
    </header>
  );
}

export default Navbar;
