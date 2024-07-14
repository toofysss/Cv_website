import i18n from "i18next";
import { initReactI18next } from "react-i18next";
const resources = {
  en: {
    translation: {
      // Navbar
      N1: "Home",
      N2: "About",
      N3: "Eduction",
      N4: "Experience",
      N5: "Skills",
      N6: "Projects",
      // Lang
      lang: "Language",
      Ar: "Arabic",
      En: "English",
      Name: "Mustafa Saad",
      About:
        "Developer with A Comprehensive knowledge To Doing Anything Related To Flutter & Dot Net Technologies With Interface Designing & Implementation. Key Skills Include Fast Learning, Self-Motivation, And Collaboration Skills To Achieve Organizational Objectives And A knack For Analytical Thinking That Helps For Problem-Solving With A Commitment To Staying Updated With Industry trends.",
      DownloadCv: "View CV",
      i: "I'm",
      allcatagory: "All Categories",
      Details: "Details",
    },
  },
  ar: {
    translation: {
      // Navbar
      N1: "الصفحة الرئيسية",
      N2: "نبذة عني",
      N3: "التعليم",
      N4: "الخبرة",
      N5: "المهارات",
      N6: "المشاريع",
      // Lang
      lang: "اللغة",
      Ar: "العربية",
      En: "الأنكليزية",
      Name: "مصطفى سعد",
      About:
        "مطور يتمتع بمعرفة شاملة للقيام بأي شيء يتعلق بتقنيات Flutter وDot Net مع تصميم الواجهة وتنفيذها. تشمل المهارات الأساسية التعلم السريع والتحفيز الذاتي ومهارات التعاون لتحقيق الأهداف التنظيمية وموهبة التفكير التحليلي الذي يساعد على حل المشكلات- حل المشكلة مع الالتزام بالبقاء على اطلاع بأحدث اتجاهات الصناعة.",
      DownloadCv: "مشاهدة السيرة الذاتية",
      i: "أنا",
      Details: "عرض التفاصيل",
      allcatagory: "جميع الاقسام",
    },
  },
};

i18n.use(initReactI18next).init({
  resources,
  lng: "en",
  interpolation: {
    escapeValue: false,
  },
  react: {
    useSuspense: false,
  },
});

export default i18n;
