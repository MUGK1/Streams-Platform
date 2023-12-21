"use client";
import "./globals.css";
import Image from "next/image";
import logo from "../public/images/Logo.svg";
import search from "../public/images/Search.svg";
import logout from "../public/images/Logout.svg";
import userAvatar from "../public/images/User_Avatar.svg";
import Video from "./Components/Video/Video";
import ChannelButton from "@/app/Components/channelCom/ChannelButton";
import { useEffect, useState } from "react";
import Link from "next/link";
import UserProfileImage from "@/app/Components/User/UserProfileImage";

export default function RootLayout({ children }) {
  const [userChannels, setUserChannels] = useState([]);
  const [mainState, setMainState] = useState("");
  const [inputValue, setInputValue] = useState("");
  const [userName, setUserName] = useState("");

  const handleLogOut = () => {
    localStorage.removeItem("token");
    window.location.reload();
  };

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch("https://localhost:7001/api/User/get-user-channels", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setUserChannels(data))
      .catch((err) => console.log(err));
  }, []);

  useEffect(() => {
    if (!localStorage.getItem("token")) return;
    fetch("https://localhost:7001/api/User/get-user-info", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setUserName(data.name))
      .catch((err) => console.log(err));
  }, []);

  //Username 2 Litter Initials
  const initials = () => {
    let initials = userName.match(/\b\w/g) || [];
    initials = (
      (initials.shift() || "") + (initials.pop() || "")
    ).toUpperCase();
    return initials;
  };

  //Move the values of the Search to the Home page
  const handleInputChange = (event) => {
    setInputValue(event.target.value);
  };
  const handleButtonClick = () => {
    setMainState(inputValue);
  };
  useEffect(() => {
    console.log("main: " + mainState);
  }, [mainState]);

  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <title>Streams Platform</title>
      </head>
      <body className="relative bg-primaryBlack">
        <header className="h-16">
          <div className="flex justify-between w-11/12 h-16 items-center text-center center">
            <a className="" href="/">
              <Image src={logo} alt="Logo" className="" />
            </a>
            <search className="relative">
              <input
                value={inputValue}
                onChange={handleInputChange}
                type="text"
                placeholder="Search"
                className="focus:outline-none bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 pl-5 pr-5 pt-2 pb-2 text-xs"
              />
              <div className="absolute w-10 h-full bg-secondaryBlack top-0 right-0 rounded-r-3xl cursor-pointer">
                <Link
                  href={{
                    pathname: "/",
                    query: {
                      search: mainState,
                    },
                  }}
                >
                  <div
                    onClick={handleButtonClick}
                    className="flex justify-center items-center h-full"
                  >
                    <Image src={search} alt="search" className="w-4 h-4" />
                  </div>
                </Link>
              </div>
            </search>
            <div className="flex justify-between items-center w-32">
              <div className="cursor-pointer flex justify-center items-center">
                {userChannels.map((channel, index) => (
                  <ChannelButton key={index} id={channel.id}>
                    <Image
                      src={channel.avatarUrl}
                      alt="Channel Avatar"
                      className="rounded-full mr-3"
                      height="36"
                      width="36"
                    />
                  </ChannelButton>
                ))}
              </div>
              <div onClick={handleLogOut} className="cursor-pointer">
                <a href="/">
                  <Image src={logout} alt="logout" className="" />
                </a>
              </div>
              <div className="cursor-default">
                <UserProfileImage initials={initials()} />
              </div>
            </div>
          </div>
        </header>
        {children}
      </body>
    </html>
  );
}
