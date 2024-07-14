import React from "react";
import { Routes, Route } from "react-router-dom";
import Layout from "./layout";
import Experience from "./Page/Experince/Experience";
import Homes from "./Page/Home/home";
import Navbar from "./Page/Navbar/Navbar";
import Eduction from "./Page/Eduction/Eduction";
import Project from "./Page/Project/Project";
import Skills from "./Page/Skills/Skills";
import Footer from "./Page/Footer/Footer";
import Details from "./Page/Project/Details";

function App() {
  return (
    <div className="App">
      {
        <>
          <Navbar />
          <Layout>
            <Routes>
              <Route path="*" element={<Homes />} />
              <Route path="/eduction" element={<Eduction />} />
              <Route path="/experience" element={<Experience />} />
              <Route path="/skills" element={<Skills />} />
              <Route path="/project" element={<Project />} />
              <Route path="/project/details" element={<Details />} />
            </Routes>
          </Layout>
          <Footer />
        </>
      }
    </div>
  );
}

export default App;
