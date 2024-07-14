// Layout.js
import React, { useEffect } from "react";
import { useLocation } from "react-router-dom";
import { gsap } from "gsap";

const Layout = ({ children }) => {
  const location = useLocation();

  useEffect(() => {
    const handlePageTransition = () => {
      const tl = gsap.timeline();
      tl.fromTo(".content", { opacity: 0 }, { opacity: 1, duration: 0.5 });
    };

    handlePageTransition();
  }, [location.pathname]);

  return <div className="content">{children}</div>;
};

export default Layout;
