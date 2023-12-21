"use client";
import Image from "next/image";
import logo from "@/public/images/Logo.svg";
import { useEffect, useState } from "react";
import { BarLoader } from "react-spinners";

function LogIn(props) {
  const [doNotHaveAnAccount, setDoNotHaveAnAccount] = useState(false);
  const [isChecked, setIsChecked] = useState(false);
  const [userInfo, setUserInfo] = useState({
    email: "",
    password: "",
  });
  const [signUpInfo, setSignUpInfo] = useState({
    name: "",
    email: "",
    password: "",
    dateOfBirth: "",
    country: "",
  });

  const [error, setError] = useState(false);
  // const [sendData, setSendData] = useState(false);
  const [requestCount, setRequestCount] = useState(0);
  const [successSignUp, setSuccessSignUp] = useState(false);
  const [invalidCredentials, setInvalidCredentials] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const handleChange = (e) => {
    setIsChecked(e.target.checked);
  };

  const handleError = () => {
    setIsLoading(true);
    if (userInfo.email === "" || userInfo.password === "") {
      setError(true);
      setIsLoading(false);
    } else {
      setError(false);
      setRequestCount((prev) => prev + 1);
    }
  };

  const handleSignUpError = () => {
    setIsLoading(true);
    if (
      signUpInfo.email === "" ||
      signUpInfo.password === "" ||
      signUpInfo.name === "" ||
      signUpInfo.dateOfBirth === ""
    ) {
      setError(true);
      setIsLoading(false);
    } else if (isChecked && signUpInfo.country === "") {
      setError(true);
      setIsLoading(false);
    } else {
      setError(false);
      setRequestCount((prev) => prev + 1);
    }
  };

  useEffect(() => {
    if (requestCount === 0 || doNotHaveAnAccount) return;
    setInvalidCredentials(false);
    fetch("https://localhost:7001/api/Authentication/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(userInfo),
    })
      .then((res) => {
        if (!res.ok) {
          setInvalidCredentials(true);
        } else if (res.ok) {
          setUserInfo({
            email: "",
            password: "",
          });
        }
        setIsLoading(false);
        return res.json();
      })
      .then((data) => {
        localStorage.setItem("token", data.token);
        props.setShowLogin(false);
        window.location.reload();
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [requestCount]);

  useEffect(() => {
    if (requestCount === 0 || !doNotHaveAnAccount) return;
    fetch("https://localhost:7001/api/Authentication/signup", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        ...signUpInfo,
        isCreator: isChecked,
      }),
    })
      .then((res) => {
        if (res.ok) {
          setSuccessSignUp(true);
          setDoNotHaveAnAccount(false);
          setSignUpInfo({
            name: "",
            email: "",
            password: "",
            dateOfBirth: "",
            country: "",
          });
        }
        setIsLoading(false);
        return res.json();
      })
      .catch((err) => {
        console.log("err", err);
      });
  }, [requestCount]);

  return (
    <div className="fixed top-0 left-0 w-screen h-screen bg-primaryBlack z-10 ">
      <div className="flex flex-col justify-center items-center h-full w-fit center">
        {(successSignUp || invalidCredentials) && (
          <div
            className={`${
              invalidCredentials ? "bg-red-700" : "bg-primaryRed"
            } w-rem34 h-12 rounded-3xl flex flex-col mb-4 justify-center items-center`}
          >
            <p className="text-primaryBlack text-sm font-youtubeSansDarkMedium">
              {invalidCredentials
                ? !doNotHaveAnAccount
                  ? "incorrect Email Or Password"
                  : "Something Went Wrong"
                : "You have successfully signed up"}
            </p>
          </div>
        )}
        <div className="mb-16 ">
          <Image src={logo} alt="Logo" className="w-40" />
        </div>
        {!doNotHaveAnAccount || successSignUp ? (
          <>
            <input
              type="email"
              onChange={(e) => {
                setUserInfo({ ...userInfo, email: e.target.value });
              }}
              placeholder="Email Address"
              className="focus:outline-none mb-4 bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="password"
              placeholder="Password"
              onChange={(e) => {
                setUserInfo({ ...userInfo, password: e.target.value });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
          </>
        ) : (
          <>
            <input
              type="text"
              placeholder="Name"
              onChange={(e) => {
                setSignUpInfo({ ...signUpInfo, name: e.target.value });
              }}
              className="focus:outline-none mb-4 bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="email"
              placeholder="Email Address"
              onChange={(e) => {
                setSignUpInfo({ ...signUpInfo, email: e.target.value });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="date"
              placeholder="Date of Birth"
              onChange={(e) => {
                setSignUpInfo({ ...signUpInfo, dateOfBirth: e.target.value });
              }}
              className="focus:outline-none mb-4 bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <input
              type="password"
              placeholder="Password"
              onChange={(e) => {
                setSignUpInfo({ ...signUpInfo, password: e.target.value });
              }}
              className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
            />
            <div className="flex items-center justify-between mb-5  bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm">
              <p className="">Do you want to open a Channel?</p>
              <input
                type="checkbox"
                name="isChanel"
                value="Channel"
                checked={isChecked}
                onChange={handleChange}
                className="w-36"
              />
            </div>
            {isChecked && (
              <input
                type="text"
                placeholder="Country Name"
                onChange={(e) => {
                  setSignUpInfo({ ...signUpInfo, country: e.target.value });
                }}
                className="focus:outline-none mb-5  bg-transparent rounded-3xl border-2 border-secondaryBlack text-textColor w-rem26 h-12 pl-5 pr-5 pt-2 pb-2 text-sm"
              />
            )}
          </>
        )}

        <button
          className="cursor-pointer text-xs"
          onClick={() => {
            setDoNotHaveAnAccount(!doNotHaveAnAccount);
            setSuccessSignUp(false);
          }}
        >
          {!doNotHaveAnAccount
            ? "Don't have an Account?"
            : "Already have an Account?"}
        </button>
        <button
          onClick={() => {
            if (doNotHaveAnAccount) {
              handleSignUpError();
            } else {
              handleError();
            }
          }}
          className="bg-primaryRed w-64 h-12 rounded-3xl mt-16 border-2 border-primaryRed hover:bg-transparent transition-all hover:scale-105 active:scale-95"
        >
          {isLoading ? (
            <div className="w-full h-full flex justify-center items-center">
              <BarLoader
                color="#fff"
                loading={isLoading}
                size={150}
                aria-label="Loading Spinner"
                data-testid="loader"
              />
            </div>
          ) : !doNotHaveAnAccount || successSignUp ? (
            "Log In"
          ) : (
            "Sign Up"
          )}
        </button>
        {error && (
          <p className="text-red-500 text-sm mt-2">Please fill all fields</p>
        )}
      </div>
    </div>
  );
}

export default LogIn;
