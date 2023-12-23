--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.channels (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(500),
    avatar_url character varying(250),
    subscribers_count integer DEFAULT 0 NOT NULL,
    created_at date NOT NULL,
    creator_uid integer NOT NULL
);


--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.channels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: creators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creators (
    user_id integer NOT NULL,
    channel_count integer DEFAULT 0 NOT NULL,
    country character varying(4) DEFAULT 'KSA'::character varying NOT NULL
);


--
-- Name: impressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions (
    video_id integer NOT NULL,
    viewer_uid integer NOT NULL,
    date_time date NOT NULL,
    liked boolean DEFAULT false NOT NULL,
    disliked boolean DEFAULT false NOT NULL,
    comment character varying(500)
);


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscriptions (
    channel_id integer NOT NULL,
    viewer_uid integer NOT NULL
);


--
-- Name: temp; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp (
    url character varying(255),
    title character varying(255),
    channel character varying(255),
    genre character varying(255)
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    password character varying(250) NOT NULL,
    created_at date NOT NULL,
    email character varying(250) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 250
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.videos (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    title character varying(250) NOT NULL,
    description character varying(500),
    genre character varying(255),
    published_at date NOT NULL,
    channel_id integer NOT NULL,
    thumbnail_url character varying(1000),
    duration_sec integer
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: viewers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.viewers (
    user_id integer NOT NULL,
    date_of_birth date NOT NULL
);


--
-- Name: views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.views (
    video_id integer NOT NULL,
    viewer_uid integer NOT NULL
);


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.channels (id, name, description, avatar_url, subscribers_count, created_at, creator_uid) FROM stdin;
132	ByteByteGo	\N	https://yt3.googleusercontent.com/efrVnDJbJOQ5XcXrrFhA9V2wTXh6gP_i0KycoYjqhN3nEh6VbCgqMQakAcFqEsguw7wxhHEjnA=s176-c-k-c0x00ffffff-no-rj	234421	2023-12-12	71
141	Fireship	\N	https://yt3.googleusercontent.com/ytc/AIf8zZTUVa5AeFd3m5-4fdY2hEaKof3Byp8VruZ0f0FNEA=s176-c-k-c0x00ffffff-no-rj	2386472	2018-02-02	9
140	Code with Mosh	\N	https://yt3.googleusercontent.com/ebu9ZksIXw0tUWBZd6rtk-It8VGSk8AdfSI_eGR-fl6WGet9LnVPngNQCmjdLJeGXpuylwYInQ=s176-c-k-c0x00ffffff-no-rj	98726543	2015-02-04	98
130	Power Cert Animated Videos	\N	https://yt3.googleusercontent.com/ytc/APkrFKbtrt0vdlHIAHBPzdRUlVhQeW3AXqUnP-aS8k3_1A=s176-c-k-c0x00ffffff-no-rj	23454	2023-12-12	13
131	Deep Learning Ai	\N	https://yt3.googleusercontent.com/ytc/APkrFKYl7uF0qKfiyg4EisLU2KMul91_Vmu7MtTko4OL_w=s176-c-k-c0x00ffffff-no-rj	293484	2000-04-04	70
133	Branch Education	\N	https://yt3.googleusercontent.com/4toKBJKPsAfwxy2xfr_EQJ7CuHpLvZa4eux6T2TAf8EU25uH_G9gbUA9djqaCrTjkIESnPjzww=s176-c-k-c0x00ffffff-no-rj	232145	2023-12-12	12
134	Shark Tank Global	\N	https://yt3.googleusercontent.com/irP3d4enfv6XoXaod6eLr_4mBrdb1y0eUsVzxj9QIlOmny7mY8HIzalNxqn1nAzVrZfM_cW8Opk=s176-c-k-c0x00ffffff-no-rj	22349983	2023-12-12	7
135	Sebastian Lague	\N	https://yt3.googleusercontent.com/ytc/APkrFKbO_KZM4q6NGNcfydgwLYvJnx1z0uuvUXsBTEC02g=s176-c-k-c0x00ffffff-no-rj	21334	2023-12-12	6
136	Ben Eater	\N	https://yt3.googleusercontent.com/ytc/APkrFKbIiGCQQnTUIYjCaFE_OaKJQfXMPrk-5ApvKvXv=s176-c-k-c0x00ffffff-no-rj	3344221	1999-01-05	11
137	Two Minute Papers	\N	https://yt3.googleusercontent.com/ytc/AIf8zZRSjvqlgXsH4V7x94Jjm8v1DJPoyiwl17pAEDBilg=s176-c-k-c0x00ffffff-no-rj	234521	2023-12-12	39
138	Free Code Camp	\N	https://yt3.googleusercontent.com/ytc/APkrFKaqca-xQcJtp1Pqv-APucCa0nToHYGPVT00YBGOSw=s176-c-k-c0x00ffffff-no-rj	4986734	2023-12-12	50
139	NetworkChunk	\N	https://yt3.googleusercontent.com/ytc/AIf8zZSl28jRYkl3A4FVYO7T-bzQVXrEC9tft0v_DEUyMQ=s176-c-k-c0x00ffffff-no-rj	99847632	2014-09-07	4
\.


--
-- Data for Name: creators; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.creators (user_id, channel_count, country) FROM stdin;
25	1	SA
79	1	SA
86	1	SA
71	1	SA
70	1	SA
36	1	SA
8	1	SA
7	1	SA
12	1	SA
95	1	SA
30	1	SA
19	1	SA
64	1	SA
78	1	SA
72	1	SA
83	1	SA
13	1	SA
47	1	SA
99	1	SA
6	1	SA
11	1	SA
39	1	SA
15	1	SA
27	1	SA
28	1	SA
4	1	SA
50	1	SA
52	1	SA
55	1	SA
54	1	SA
96	1	SA
32	1	SA
98	1	SA
9	1	SA
92	1	SA
67	1	SA
38	1	SA
10	1	SA
85	1	SA
56	1	SA
68	1	SA
89	1	SA
88	1	SA
5	1	SA
58	1	SA
65	1	SA
74	1	SA
90	1	SA
60	1	SA
94	1	SA
35	1	SA
44	1	SA
75	1	SA
33	1	SA
3	1	SA
59	1	SA
69	1	SA
77	1	SA
62	1	SA
37	1	SA
20	1	SA
40	1	SA
45	1	SA
80	1	SA
100	1	SA
105	1	SA
110	1	SA
115	1	SA
120	1	SA
125	1	SA
130	1	SA
135	1	SA
140	1	SA
145	1	SA
150	1	SA
155	1	SA
160	1	SA
165	1	SA
170	1	SA
175	1	SA
180	1	SA
185	1	SA
190	1	SA
195	1	SA
200	1	SA
16	1	SA
24	1	SA
48	1	SA
76	1	SA
84	1	SA
104	1	SA
108	1	SA
112	1	SA
116	1	SA
124	1	SA
128	1	SA
132	1	SA
136	1	SA
144	1	SA
148	1	SA
152	1	SA
156	1	SA
164	1	SA
168	1	SA
172	1	SA
176	1	SA
184	1	SA
188	1	SA
192	1	SA
196	1	SA
212	0	Sau
217	0	SA
218	0	SA
219	0	SA
220	0	SA
221	0	SA
228	0	SA
230	0	SA
\.


--
-- Data for Name: impressions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.impressions (video_id, viewer_uid, date_time, liked, disliked, comment) FROM stdin;
264	16	2023-12-12	f	f	test
264	16	2023-12-12	f	f	test
264	16	2023-12-12	f	f	test
253	13	2023-12-12	f	f	test
253	13	2023-12-12	f	f	test
253	13	2023-12-12	f	f	his
351	13	2023-12-12	f	f	hi
343	228	2023-12-12	f	f	test
315	16	2023-12-12	f	f	Test Comment
313	16	2023-12-12	f	f	The Best Video
313	228	2023-12-12	f	f	Hi 
313	16	2023-12-12	f	f	Awesome
254	228	2023-12-12	f	t	\N
350	220	2023-12-13	t	f	\N
350	220	2023-12-13	t	f	\N
327	220	2023-12-13	f	f	cool vid
349	12	2023-12-13	t	f	\N
256	13	2023-12-13	f	f	Test 2
337	229	2023-12-13	f	f	hi
338	16	2023-12-14	f	t	\N
338	16	2023-12-14	f	f	test
338	16	2023-12-14	f	f	jj
306	16	2023-12-18	f	f	test
306	16	2023-12-18	f	t	\N
353	13	2023-12-21	f	f	Good Video
353	231	2023-12-21	f	f	Awesome
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.subscriptions (channel_id, viewer_uid) FROM stdin;
139	228
136	16
130	228
130	13
140	12
135	13
138	229
135	16
140	231
\.


--
-- Data for Name: temp; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.temp (url, title, channel, genre) FROM stdin;
bdNS0K4Bt8U	Layer 2 vs Layer 3 Switches	PowerCertAnimatedVideos	Networks
R1qJ87Fo5_k	What is a Guest Network?	PowerCertAnimatedVideos	Networks
Jfq_BYhxvy0	Windows Command Line Tools	PowerCertAnimatedVideos	Networks
FfQui0mk85Q	What is a Patch Panel?  (cable management)	PowerCertAnimatedVideos	Networks
qBJnZIk6WPM	Power over Ethernet (PoE) - Explained	PowerCertAnimatedVideos	Networks
RXXRguaHZs0	Proxy vs Reverse Proxy Explained	PowerCertAnimatedVideos	Networks
2eLe7uz-7CM	CompTIA A+ Certification Video Course	PowerCertAnimatedVideos	Networks
H_8ZVRRtiIA	AI for Good Specialization by DeepLearning.AI	DeepLearningAi	AI
AmlhNK9_I4o	DeepLearning.AI Courses	DeepLearningAi	AI
vStJoetOxJg	Machine Learning Specialization by Andrew Ng	DeepLearningAi	Machine Learning
NgWujOrCZFo	Machine Learning Engineering for Production (MLOps)	DeepLearningAi	Machine Learning
NJaVkJDrBCc	#BeADeepLearner	DeepLearningAi	Deep Learning
H343JRrncfc	Heroes of NLP	DeepLearningAi	Deep Learning
1-8W6z4wBJU	NLP Learner Community Events	DeepLearningAi	Deep Learning
az7Og6k_-3o	AI4M Learner Community Event	DeepLearningAi	Deep Learning
JvAJiU28Zfw	Deep Learner Spotlights	DeepLearningAi	Deep Learning
LWI3b5GtwVc	Conversations with Andrew Ng	DeepLearningAi	Tech Talks
XpFsMB6FoOs	How Does Linux Boot Process Work?	ByteByteGo	Linux
P2CPd9ynFLg	Why is JWT popular?	ByteByteGo	Web Dev
e9lnsKot_SQ	How Git Works: Explained in 4 Minutes	ByteByteGo	Web Dev
P6SZLcGE4us	Top 8 Most Popular Network Protocols Explained	ByteByteGo	Networks
xSPA2yBgDgA	How Big Tech Ships Code to Production	ByteByteGo	Coding
wAMc7NyL4tQ	Our Recommended Materials For Cracking Your Next Tech Interview	ByteByteGo	Tech Talks
UNUz1-msbOM	System Design: Why is Kafka fast?	ByteByteGo	System Design
4vLxWqE94l4	Top 6 Most Popular API Architecture Styles	ByteByteGo	Web Dev
a-sBfyiXysI	HTTP/1 to HTTP/2 to HTTP/3	ByteByteGo	Web Dev
TlHvYWVUZyc	Kubernetes Explained in 6 Minutes | k8s Architecture	ByteByteGo	Microservices
9DnnxvS6BBQ	How do Electron Microscopes Work? Taking Pictures of Atoms	BranchEducation	Physics
h-NM1xSSzHQ	How do Computer Keyboards Work?	BranchEducation	Hardware
d86ws7mQYIg	How does Computer Hardware Work?  [3D Animated Teardown]	BranchEducation	Hardware
wtdnatmVdIg	How do Hard Disk Drives Work?	BranchEducation	Hardware
7J7X7aZvMXQ	How does Computer Memory Work?	BranchEducation	Hardware
X6wJE-4BLM0	Why are Smoke Detectors Radioactive?  And How do Smoke Detectors Work?	BranchEducation	Physics
1I1vxu5qIUM	How does Bluetooth Work?	BranchEducation	Hardware
5Mh3o886qpg	How do SSDs Work? | How does your Smartphone store data? |  Insanely Complex Nanoscopic Structures!	BranchEducation	Hardware
SAaESb4wTCM	How does a Mouse know when you move it?  ||  How Does a Computer Mouse Work?	BranchEducation	Hardware
qs2QcycggWU	How does Starlink Satellite Internet Work?	BranchEducation	Networks
VnvkARDxulU	Shark Tank Pitches To Get You Ready For Christmas | Shark Tank US | Shark Tank Global	SharkTankGlobal	Shark Tank
nQWtyQ9-Y2o	Shark Tank Australia - New Series	SharkTankGlobal	Shark Tank
b7FqS4VNLRI	Technology | Season 5 | Shark Tank Australia	SharkTankGlobal	Shark Tank
59poU9EGi18	Beauty & Fashion | Season 5 | Shark Tank Australia	SharkTankGlobal	Shark Tank
2L9z6jL7TQ4	Mark Cuban Gives An ULTIMATUM To Hiccaway | Shark Tank US | Shark Tank Global	SharkTankGlobal	Shark Tank
IQUTG0CxKXk	Christmas Dinner Cake | Dragons' Den #shorts	SharkTankGlobal	Shark Tank
EN_7U8MninY	Mallow & Marsh Went On To Become A Leading Brand | Dragons' Den | Shark Tank Global	SharkTankGlobal	Shark Tank
KRZvjjaFQ4k	Will The Sharks Secure The Bag With Cincha Travel? | Shark Tank US | Shark Tank Global	SharkTankGlobal	Shark Tank
yfl0oDIaFcY	Steve Calls Bull on Science Behind KLite | Shark Tank AUS| Shark Tank US | Shark Tank Global	SharkTankGlobal	Shark Tank
GqpSxECpxGw	The Sharks Are Impressed with Parting Stone's Service | Shark Tank US | Shark Tank Global	SharkTankGlobal	Shark Tank
rSKMYc1CQHE	Coding Adventure: Simulating Fluids	SebastianLague	Coding
iScy18pVR58	Coding Challenge Announcement: Tiny Chess Bots	SebastianLague	Coding
_vqlIPDR2TU	Coding Adventure: Making a Better Chess Bot	SebastianLague	Coding
kIMHRQWorkE	Answering Your Questions	SebastianLague	Tech Talks
Qz0KTGYJtUk	Coding Adventure: Ray Tracing	SebastianLague	Coding
_3cNcmli6xQ	Experimenting with Buses and Three-State Logic	SebastianLague	Digital Logic
sLqXFF8mlEU	I Tried Creating a Game Using Real-World Geographic Data	SebastianLague	Game Dev
I0-izyq6q5s	How Do Computers Remember?	SebastianLague	Hardware
UXD97l7ZT0w	Trying to Improve My Geography Game with More Real-World Data	SebastianLague	Game Dev
U4ogK0MIzqk	Coding Adventure: Chess	SebastianLague	Coding
LnzuMJLZRdU	Hello, world from scratch on a 6502 Part 1	BenEater	BenEater
yl8vPW5hydQ	How do CPUs read machine code? 6502 part 2	BenEater	BenEater
oO8_2JJV0B4	Assembly language vs. machine code 6502 part 3	BenEater	BenEater
FY3zTUaykVo	Connecting an LCD to our computer 6502 part 4	BenEater	BenEater
xBjQVxVxOxc	What is a stack and how does it work? 6502 part 5	BenEater	BenEater
i_wrxBdXTgM	RAM and bus timing 6502 part 6	BenEater	BenEater
HyznrdDSSGM	8-bit computer update	BenEater	BenEater
kRlSFm519Bo	Astable 555 timer - 8-bit computer clock - part 1	BenEater	BenEater
81BgFhm2vz8	Monostable 555 timer - 8-bit computer clock - part 2	BenEater	BenEater
WCwJNnx36Rk	Bistable 555 - 8-bit computer clock - part 3	BenEater	BenEater
_AnovXOJOaw	New AI: 6,000,000,000 Steps In 24 Hours!	TwoMinutePapers	AI
ex1GeX0IhJQ	Gemini: ChatGPT-Like AI From Google DeepMind!	TwoMinutePapers	AI
7rvjZQy_RQs	Text To Image AIs Just Got Supercharged!	TwoMinutePapers	AI
XwDaQKOxgFY	Stable Video AI Watched 600,000,000 Videos!	TwoMinutePapers	AI
5_E5HNk3UN4	Blender 4.0 Is Here: A Revolution For Free!	TwoMinutePapers	AI
_3zbfgHmcJ4	10,000 Of These Train ChatGPT In 4 Minutes!	TwoMinutePapers	AI
Lu56xVlZ40M	OpenAI Plays Hide and Seek and Breaks The Game!	TwoMinutePapers	AI
SsJ_AusntiU	This AI Learned Boxing With Serious Knockout Power!	TwoMinutePapers	AI
54YvCE8_7lM	Is Simulating Soft and Bouncy Jelly Possible?	TwoMinutePapers	Physics
7SM816P5G9s	Is a Realistic Honey Simulation Possible?	TwoMinutePapers	Physics
5iHejdqYIa8	Build a Virtual World Filled with Self-Driving Cars JavaScript Tutorial	FreeCodeCamp	AI
JEBDfGqrAUA	Vector Search RAG Tutorial Combine Your Data with LLMs with Advanced Search	FreeCodeCamp	AI
uyhzCBEGaBY	Beginner JavaScript Project Snake Game Tutorial	FreeCodeCamp	Coding
NhDYbskXRgc	AWS Certified Cloud Practitioner Certification Course (CLF-C02) - Pass the Exam!	FreeCodeCamp	Courses
RMScMwY2B6Q	Build and Deploy an Instagram Clone with React and Firebase Tutorial	FreeCodeCamp	Courses
8mAITcNt710	Harvard CS50 Full Computer Science University Course	FreeCodeCamp	Courses
8jLOx1hD3_o	C++ Programming Course - Beginner to Advanced	FreeCodeCamp	Courses
zJSY8tbf_ys	Frontend Web Development Bootcamp Course (JavaScript, HTML, CSS)	FreeCodeCamp	Courses
WXsD0ZgxjRw	APIs for Beginners 2023 - How to use an API (Full Course / Tutorial)	FreeCodeCamp	Courses
VbEx7B_PTOE	Linux for Hackers (and everyone) // FREE Course for Beginners	NetworkChunk	Linux
SvO_FDa8AIs	Hacker Skills // OSINT (Information Gathering)	NetworkChunk	Networks
yFC8pb2TPdc	Learn Ethical Hacking (CEH Journey)	NetworkChunk	Networks
wX75Z-4MEoM	you need to learn Virtual Machines RIGHT NOW!! (Kali Linux VM, Ubuntu, Windows)	NetworkChunk	Networks
z4_oqTZJqCo	how to HACK a password // password cracking with Kali Linux and HashCat	NetworkChunk	Networks
lUzSsX4T4WQ	your home router SUCKS!! (use pfSense instead)	NetworkChunk	Networks
eZYtnzODpW4	i bought a DDoS attack on the DARK WEB (don't do this)	NetworkChunk	Networks
6CnDdXVTxhU	find info on phone numbers with PhoneInfoga	NetworkChunk	Networks
KdZvxxLsN3E	find social media accounts with Sherlock (in 5 MIN)	NetworkChunk	Networks
S7MNX_UD7vY	FREE CCNA // What is a Network? // Day 0	NetworkChunk	Networks
_uQrJ0TkZlc	Python Tutorial - Python Full Course for Beginners	CodeWithMosh	Coding
kqtD5dpn9C8	Python for Beginners - Learn Python in 1 Hour	CodeWithMosh	Coding
W6NZfCO5SIk	JavaScript Tutorial for Beginners: Learn JavaScript in 1 Hour	CodeWithMosh	Coding
7S_tz1z_5bA	MySQL Tutorial for Beginners [Full Course]	CodeWithMosh	Coding
eIrMbAQSU34	Java Tutorial for Beginners	CodeWithMosh	Coding
qz0aGYrrlhU	HTML Tutorial for Beginners: HTML Crash Course	CodeWithMosh	Coding
r16Rn4_jDfk	How to Learn to Code and Make $60k+ a Year	CodeWithMosh	Coding
bjFvcFjJpE0	Top Programming Languages in 2020	CodeWithMosh	Coding
pEbIhUySqbk	React vs Angular vs Vue: What to Learn to Get a Front-end Job	CodeWithMosh	Coding
Y8Tko2YC5hA	What is Python? Why Python is So Popular?	CodeWithMosh	Coding
gVzHNGyA_a4	Google's Epic Fail... the shocking result of Epic Games vs Google	Fireship	Tech Talks
CgruI1RjH_c	Elon "based" Grok AI has entered the chat	Fireship	Tech Talks
90CYYfl9ntM	The Gemini Lie	Fireship	Tech Talks
q5qAVmXSecQ	Google's Gemini just made GPT-4 look like a baby toy?	Fireship	Tech Talks
vyQv563Y-fk	You probably won't survive 2024... Top 10 Tech Trends	Fireship	Tech Talks
ekPbZqPvCRA	5 crazy new AWS services just launched	Fireship	Tech Talks
hdHjjBS4cs8	Brainf**k in 100 Seconds	Fireship	Tech Talks
pEfrdAtAmqk	God-Tier Developer Roadmap	Fireship	Tech Talks
ky5ZB-mqZKM	AI influencers are getting filthy rich... let's build one	Fireship	Tech Talks
_k-F-MMvQV4	10 Programmer Stereotypes	Fireship	Tech Talks
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, password, created_at, email) FROM stdin;
16	Arlyn Zanini	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-14	azaninif@foxnews.com
17	Rob Joysey	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-22	rjoyseyg@harvard.edu
18	Benetta Dymond	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-11	bdymondh@tinypic.com
19	Harriott Voisey	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-09	hvoiseyi@cafepress.com
20	Giordano Capron	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-16	gcapronj@npr.org
21	Maximo Folonin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-21	mfolonink@google.cn
22	Christian Cersey	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-26	ccerseyl@blinklist.com
23	Roch Upston	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-24	rupstonm@nhs.uk
24	Rosabelle Yewdell	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-10	ryewdelln@ycombinator.com
25	Aluino Normansell	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-30	anormansello@newyorker.com
26	Franciska MacNess	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-16	fmacnessp@qq.com
27	Wylma Powelee	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-20	wpoweleeq@google.cn
28	Hulda Yakebowitch	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-01	hyakebowitchr@ftc.gov
29	Caleb Baffin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-20	cbaffins@goo.ne.jp
30	Farrell Lamminam	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-14	flamminamt@themeforest.net
31	Deloria Watters	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-26	dwattersu@mozilla.org
32	Willi Ewert	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-08	wewertv@wix.com
33	Darill Kreuzer	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-18	dkreuzerw@netscape.com
34	Melina Westphal	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-09	mwestphalx@symantec.com
35	Tito Penfold	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-14	tpenfoldy@google.co.jp
36	Claudetta Mifflin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-03	cmifflinz@earthlink.net
37	Athene Ridgedell	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-26	aridgedell10@xinhuanet.com
38	Marsha Buttrick	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-03	mbuttrick11@pen.io
39	Abel Feldmesser	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-11-17	afeldmesser12@google.nl
40	Delly Dri	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-09	ddri13@bbc.co.uk
41	Aggy Glancey	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-20	aglancey14@telegraph.co.uk
42	Mada Jiroutka	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-30	mjiroutka15@ning.com
43	Elvira Kydd	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-10	ekydd16@sciencedirect.com
44	Debra Rignoldes	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-23	drignoldes17@cisco.com
45	Jacinda Such	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-16	jsuch18@microsoft.com
46	Sarena Lettley	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-25	slettley19@blogger.com
47	Bren Bedder	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-11	bbedder1a@yolasite.com
48	Adelheid Brimley	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-11-02	abrimley1b@bbb.org
49	Izak Philippe	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-19	iphilippe1c@google.com
50	Leta MacTurlough	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-26	lmacturlough1d@pcworld.com
51	Niel Treen	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-07	ntreen1e@ow.ly
52	Persis Bolderson	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-10	pbolderson1f@comsenz.com
53	Vladamir McMaster	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-07	vmcmaster1g@wiley.com
54	Marta Wetwood	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-25	mwetwood1h@360.cn
55	Shawn Brake	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-09-27	sbrake1i@jiathis.com
56	Randall Scarf	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-08	rscarf1j@reverbnation.com
57	Ailee Ledekker	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-10	aledekker1k@europa.eu
58	Amye Kach	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-23	akach1l@uol.com.br
59	Kayle Nerval	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-12	knerval1m@free.fr
60	Montgomery Gemlett	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-17	mgemlett1n@blogger.com
61	Sutton Kovacs	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-27	skovacs1o@hugedomains.com
62	Angeline Rubra	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-23	arubra1p@slashdot.org
63	Rozanne Bellamy	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-08	rbellamy1q@hhs.gov
64	Terencio Overthrow	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-09	toverthrow1r@oaic.gov.au
65	Vincenz Huskisson	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-09	vhuskisson1s@xinhuanet.com
66	Julius Preshous	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-16	jpreshous1t@eepurl.com
67	Urbanus Belfit	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-18	ubelfit1u@soup.io
68	Vinson Springer	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-27	vspringer1v@wikia.com
69	Malvina Wyke	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-29	mwyke1w@1688.com
70	Correna Ord	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-26	cord1x@utexas.edu
71	Pauli Yo	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-09	pyo1y@sogou.com
72	Toby Element	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-16	telement1z@linkedin.com
73	Jacintha Spridgeon	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-18	jspridgeon20@google.nl
74	Evonne Nevins	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-23	enevins21@constantcontact.com
75	Blayne Roskelley	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-29	broskelley22@wikimedia.org
76	Nappie Bathurst	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-31	nbathurst23@bandcamp.com
77	Stephenie Guys	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-07	sguys24@jalbum.net
78	Deb Durnall	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-09-12	ddurnall25@nifty.com
79	Sherm Casali	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-24	scasali26@va.gov
80	Selestina Ockleshaw	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-25	sockleshaw27@epa.gov
81	Carlyle Stranger	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-14	cstranger28@jigsy.com
82	Brandice Jery	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-10	bjery29@wsj.com
83	Shay Sanders	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-22	ssanders2a@usgs.gov
84	Oliy Brattan	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-17	obrattan2b@eventbrite.com
85	Mellie Gabbetis	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-28	mgabbetis2c@yale.edu
86	Rusty Tarte	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-19	rtarte2d@jigsy.com
87	Rossie Hambribe	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-18	rhambribe2e@usa.gov
88	Megan Hargrove	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-14	mhargrove2f@wired.com
89	Joycelin Axworthy	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-17	jaxworthy2g@nydailynews.com
90	Malcolm Izzatt	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-08	mizzatt2h@washingtonpost.com
91	Jerrie Leftridge	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-22	jleftridge2i@slate.com
92	Alfons Owthwaite	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-27	aowthwaite2j@salon.com
93	Niccolo Bateman	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-19	nbateman2k@sphinn.com
94	Hartwell Wadsworth	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-15	hwadsworth2l@un.org
95	Pru Bazely	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-05	pbazely2m@google.co.uk
96	Robby Dowman	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-01	rdowman2n@cafepress.com
97	Dallon Quiddington	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-30	dquiddington2o@census.gov
98	Romonda Boost	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-19	rboost2p@mayoclinic.com
99	Blanca Llorens	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-23	bllorens2q@cornell.edu
100	Dotti D'Onise	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-16	ddonise2r@rakuten.co.jp
101	Derry Tucknott	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-01	dtucknott2s@livejournal.com
102	Wallache Ramalhete	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-07	wramalhete2t@noaa.gov
103	Rutherford Pudsey	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-13	rpudsey2u@deliciousdays.com
104	Tierney Tofts	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-18	ttofts2v@ehow.com
105	Kris Blurton	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-19	kblurton2w@live.com
106	Doug Wall	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-22	dwall2x@studiopress.com
107	Darla Stinchcombe	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-20	dstinchcombe2y@google.ca
108	Analise Ible	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-05	aible2z@vinaora.com
109	Ward Carlet	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-07	wcarlet30@example.com
110	Renee Yeude	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-03	ryeude31@360.cn
111	Kristine Guillard	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-20	kguillard32@intel.com
112	Harley Dallemore	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-18	hdallemore33@domainmarket.com
113	Ysabel Whitty	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-20	ywhitty34@wikispaces.com
114	Cory Pascall	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-16	cpascall35@seattletimes.com
115	Cosette McAmish	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-30	cmcamish36@reference.com
116	Aloisia Dragge	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-01	adragge37@hugedomains.com
117	Adriane Quinn	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-28	aquinn38@alibaba.com
118	Rustin Hunt	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-22	rhunt39@theglobeandmail.com
119	Deloria Lafontaine	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-17	dlafontaine3a@yahoo.co.jp
120	Fremont Bottoner	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-15	fbottoner3b@github.com
121	Hansiain Vernon	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-24	hvernon3c@earthlink.net
122	Verge Baitman	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-17	vbaitman3d@usda.gov
123	Elberta Duferie	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-19	eduferie3e@g.co
124	Cory Simnor	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-12	csimnor3f@lycos.com
125	Hilarius Halfhyde	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-13	hhalfhyde3g@boston.com
126	Catharine Stoffels	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-09-04	cstoffels3h@cafepress.com
127	Morgan Morecombe	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-11	mmorecombe3i@example.com
128	Mireille Hoyer	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-20	mhoyer3j@npr.org
1	Davida Van Hove	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-02	dvan0@go.com
2	Walden Seldon	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-17	wseldon1@yolasite.com
3	Roana Hukin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-06	rhukin2@mysql.com
4	Odilia Pinnell	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-07	opinnell3@alibaba.com
5	Briano Lansdowne	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-30	blansdowne4@blogger.com
6	Yankee Whistan	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-03	ywhistan5@linkedin.com
7	Gilburt Hayle	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-30	ghayle6@weebly.com
8	Cindra Iveans	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-02	civeans7@abc.net.au
9	Mandie Channer	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-11-17	mchanner8@macromedia.com
10	Corabel Petrolli	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-23	cpetrolli9@webs.com
11	Emeline Olsson	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-09	eolssona@aol.com
12	Janot Buddell	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-08	jbuddellb@devhub.com
13	Michaeline Ruddom	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-18	mruddomc@sciencedaily.com
14	Marline Jane	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-05	mjaned@mit.edu
15	Emmit Jerok	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-20	ejeroke@deliciousdays.com
204	test2	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-10	test2@test.com
208	Khaled	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-10	khaledhany@gmail.com
216	Khaled	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-10	test@tests.com
220	test3	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-10	test123@test.com
225	Mohammed Ahmed	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-12	M@gmail.com
229	ro	13098fcf5fb48bc4dfda3ef8cb2abd4ce127cc14c8336b7e3f4814113f15c398	2023-12-13	arwa.selsabil@gmail.com
205	Khaled Almansour	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-10	Khaledhany88@gmail.com
210	Khaled	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-10	khaledhany1@gmail.com
212	Khaled	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-10	khaledhany12@gmail.com
213	khaled	1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014	2023-12-10	khaled@gmail.com
217	Mouad	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	2023-12-10	mouad@gmail.com
221	testChannel	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-10	testChannel@test.com
226	TestLoading	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-12	load@gmail.com
230	Test	1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014	2023-12-13	Test@test4.com
206	Khaled Almansour	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-10	khaledhany88@gmail.com
214	KhaledTest	1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014	2023-12-10	Khaled@gmails.com
218	Mouad2	477e6e09f183ed2f55c0a491beb78a8f2cfcaf1cbb78de753c4a93008fd5d3c8	2023-12-10	mouad12@gmail.com
222	Khaled	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-11	khaled@m.com
223	Khaled	ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae	2023-12-11	Khaledd@gmail.com
227	test	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-12	test@gmail.com,
231	Test	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-21	Tests@gmail.com
129	Winnie Robelow	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-16	wrobelow3k@infoseek.co.jp
130	Georgia Bartolozzi	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-31	gbartolozzi3l@cdc.gov
131	Suellen Sandifer	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-26	ssandifer3m@buzzfeed.com
132	Gabbie Foakes	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-21	gfoakes3n@virginia.edu
133	Micky Canti	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-30	mcanti3o@arizona.edu
134	Brittni Carlin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-11	bcarlin3p@hexun.com
135	Lin O'Griffin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-14	logriffin3q@newsvine.com
136	Drusie Lemmens	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-12	dlemmens3r@omniture.com
137	Zack Banham	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-09	zbanham3s@nytimes.com
138	Goran Wackett	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-29	gwackett3t@hatena.ne.jp
139	Konstance Nobriga	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-25	knobriga3u@livejournal.com
140	Padraig Whitmell	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-06	pwhitmell3v@cornell.edu
141	Wilton Lesmonde	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-04	wlesmonde3w@whitehouse.gov
142	Theda Sciacovelli	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-09	tsciacovelli3x@cdc.gov
143	Dru Albinson	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-07	dalbinson3y@vkontakte.ru
144	Delcine Coulthart	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-08	dcoulthart3z@shinystat.com
145	Diahann MacAllaster	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-15	dmacallaster40@hc360.com
146	Darci Worsnup	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-01	dworsnup41@delicious.com
147	Reeva Bunclark	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-26	rbunclark42@who.int
148	Maxine Camps	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-27	mcamps43@typepad.com
149	Ysabel Hembery	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-19	yhembery44@t.co
150	Cornelle Antyukhin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-20	cantyukhin45@fc2.com
151	Ignaz Nazer	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-08	inazer46@flickr.com
152	Filip Thompstone	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-09-11	fthompstone47@msn.com
153	Chadd Ericsson	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-01	cericsson48@flickr.com
154	Clementia Corsar	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-17	ccorsar49@bandcamp.com
155	Harwilll Lowder	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-19	hlowder4a@amazon.com
156	Leroi Gutcher	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-02	lgutcher4b@nature.com
157	Licha Kingswoode	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-28	lkingswoode4c@xing.com
158	Althea Tumilson	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-07	atumilson4d@hibu.com
159	Sallie Kinnock	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-09-27	skinnock4e@barnesandnoble.com
160	Francyne Nequest	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-12	fnequest4f@wix.com
161	Emelia Frangleton	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-11	efrangleton4g@soundcloud.com
162	Jacquenetta Holtham	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-19	jholtham4h@hhs.gov
163	Jonas Jedrasik	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-24	jjedrasik4i@paginegialle.it
164	Amata Eynald	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-11	aeynald4j@seesaa.net
165	Vilma Cowsby	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-17	vcowsby4k@ftc.gov
166	Galven Steffens	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-28	gsteffens4l@edublogs.org
167	Darice Androletti	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-11-11	dandroletti4m@icq.com
168	Conrado Aasaf	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-30	caasaf4n@csmonitor.com
169	Walther Bawme	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-08-02	wbawme4o@usatoday.com
170	Lonnard Hoggan	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-08	lhoggan4p@yelp.com
171	Panchito Raulston	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-04-06	praulston4q@nytimes.com
172	Annora Aleksankin	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-09	aaleksankin4r@com.com
173	Herbie Surgenor	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-01-25	hsurgenor4s@g.co
174	Bartholemy Melmore	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-13	bmelmore4t@aboutads.info
175	Glyn Dosdill	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-04	gdosdill4u@thetimes.co.uk
176	Jereme Lemmens	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-03	jlemmens4v@aboutads.info
177	Ann Carn	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-18	acarn4w@smh.com.au
178	Randene Goad	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-29	rgoad4x@geocities.jp
179	Krisha Nulty	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-12	knulty4y@census.gov
180	Winnie Loges	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-22	wloges4z@thetimes.co.uk
181	Enriqueta Montacute	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-12	emontacute50@howstuffworks.com
182	Port Bounde	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-23	pbounde51@nbcnews.com
183	Chloris Guildford	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-13	cguildford52@google.co.jp
184	Cheri Batterbee	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-09-02	cbatterbee53@state.gov
185	Charlton Gogay	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-03	cgogay54@moonfruit.com
186	Carmen Kingerby	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-27	ckingerby55@ihg.com
187	Gennie McMurraya	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-27	gmcmurraya56@simplemachines.org
188	Nathalia Phippard	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-09-09	nphippard57@time.com
189	Demeter Key	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-08-24	dkey58@nbcnews.com
190	Enos Strank	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-06-25	estrank59@php.net
191	Sallie Danilowicz	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-11-22	sdanilowicz5a@last.fm
192	Nicola Brocklesby	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-11	nbrocklesby5b@indiatimes.com
193	Julienne Krause	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-22	jkrause5c@sourceforge.net
194	Aldwin Sherrington	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-10-06	asherrington5d@livejournal.com
195	Adaline Maymond	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-05-26	amaymond5e@nature.com
196	Milo Sparham	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-07-11	msparham5f@tiny.cc
197	June Ridesdale	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2022-12-30	jridesdale5g@gravatar.com
198	Sidonia Reckus	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-02-07	sreckus5h@ehow.com
199	Bridie Jemmison	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-03-05	bjemmison5i@trellian.com
200	Ravid O'Crotty	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-10-22	rocrotty5j@exblog.jp
203	test	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-10	test@test.com
215	Khaled Almansour	1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014	2023-12-10	k@k.com
219	Moe	ebdf8cc00bc4d9ceee633c56c63b49955769a92ca060825c9b08e4af61326e2b	2023-12-10	mouad@test.com
224	Khaled	9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08	2023-12-12	t@t.com
228	Osama Azab	b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342	2023-12-12	gosamab@gmail.com
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.videos (id, url, title, description, genre, published_at, channel_id, thumbnail_url, duration_sec) FROM stdin;
253	bdNS0K4Bt8U	Layer 2 vs Layer 3 Switches	Video by PowerCertAnimatedVideos Layer 2 vs Layer 3 Switches	Networks	2001-05-01	130	\N	\N
254	R1qJ87Fo5_k	What is a Guest Network?	Video by PowerCertAnimatedVideos What is a Guest Network?	Networks	2013-06-21	130	\N	\N
255	Jfq_BYhxvy0	Windows Command Line Tools	Video by PowerCertAnimatedVideos Windows Command Line Tools	Networks	2002-07-05	130	\N	\N
256	FfQui0mk85Q	What is a Patch Panel?  (cable management)	Video by PowerCertAnimatedVideos What is a Patch Panel?  (cable management)	Networks	2006-09-10	130	\N	\N
257	qBJnZIk6WPM	Power over Ethernet (PoE) - Explained	Video by PowerCertAnimatedVideos Power over Ethernet (PoE) - Explained	Networks	2010-12-22	130	\N	\N
258	RXXRguaHZs0	Proxy vs Reverse Proxy Explained	Video by PowerCertAnimatedVideos Proxy vs Reverse Proxy Explained	Networks	2010-09-06	130	\N	\N
259	2eLe7uz-7CM	CompTIA A+ Certification Video Course	Video by PowerCertAnimatedVideos CompTIA A+ Certification Video Course	Networks	2012-08-24	130	\N	\N
260	H_8ZVRRtiIA	AI for Good Specialization by DeepLearning.AI	Video by DeepLearningAi AI for Good Specialization by DeepLearning.AI	AI	2010-03-03	131	\N	\N
261	AmlhNK9_I4o	DeepLearning.AI Courses	Video by DeepLearningAi DeepLearning.AI Courses	AI	2016-06-19	131	\N	\N
262	vStJoetOxJg	Machine Learning Specialization by Andrew Ng	Video by DeepLearningAi Machine Learning Specialization by Andrew Ng	Machine Learning	2001-07-05	131	\N	\N
263	NgWujOrCZFo	Machine Learning Engineering for Production (MLOps)	Video by DeepLearningAi Machine Learning Engineering for Production (MLOps)	Machine Learning	2004-03-03	131	\N	\N
264	NJaVkJDrBCc	#BeADeepLearner	Video by DeepLearningAi #BeADeepLearner	Deep Learning	2010-02-16	131	\N	\N
265	H343JRrncfc	Heroes of NLP	Video by DeepLearningAi Heroes of NLP	Deep Learning	2012-03-25	131	\N	\N
266	1-8W6z4wBJU	NLP Learner Community Events	Video by DeepLearningAi NLP Learner Community Events	Deep Learning	2004-11-11	131	\N	\N
267	az7Og6k_-3o	AI4M Learner Community Event	Video by DeepLearningAi AI4M Learner Community Event	Deep Learning	2009-09-24	131	\N	\N
268	JvAJiU28Zfw	Deep Learner Spotlights	Video by DeepLearningAi Deep Learner Spotlights	Deep Learning	2012-12-18	131	\N	\N
269	LWI3b5GtwVc	Conversations with Andrew Ng	Video by DeepLearningAi Conversations with Andrew Ng	Tech Talks	2010-06-30	131	\N	\N
270	XpFsMB6FoOs	How Does Linux Boot Process Work?	Video by ByteByteGo How Does Linux Boot Process Work?	Linux	2009-10-02	132	\N	\N
271	P2CPd9ynFLg	Why is JWT popular?	Video by ByteByteGo Why is JWT popular?	Web Dev	2023-04-07	132	\N	\N
272	e9lnsKot_SQ	How Git Works: Explained in 4 Minutes	Video by ByteByteGo How Git Works: Explained in 4 Minutes	Web Dev	2007-03-12	132	\N	\N
273	P6SZLcGE4us	Top 8 Most Popular Network Protocols Explained	Video by ByteByteGo Top 8 Most Popular Network Protocols Explained	Networks	2017-10-09	132	\N	\N
274	xSPA2yBgDgA	How Big Tech Ships Code to Production	Video by ByteByteGo How Big Tech Ships Code to Production	Coding	2015-08-05	132	\N	\N
275	wAMc7NyL4tQ	Our Recommended Materials For Cracking Your Next Tech Interview	Video by ByteByteGo Our Recommended Materials For Cracking Your Next Tech Interview	Tech Talks	2004-06-26	132	\N	\N
276	UNUz1-msbOM	System Design: Why is Kafka fast?	Video by ByteByteGo System Design: Why is Kafka fast?	System Design	2020-03-03	132	\N	\N
277	4vLxWqE94l4	Top 6 Most Popular API Architecture Styles	Video by ByteByteGo Top 6 Most Popular API Architecture Styles	Web Dev	2003-09-03	132	\N	\N
278	a-sBfyiXysI	HTTP/1 to HTTP/2 to HTTP/3	Video by ByteByteGo HTTP/1 to HTTP/2 to HTTP/3	Web Dev	2019-07-03	132	\N	\N
279	TlHvYWVUZyc	Kubernetes Explained in 6 Minutes | k8s Architecture	Video by ByteByteGo Kubernetes Explained in 6 Minutes | k8s Architecture	Microservices	2008-04-17	132	\N	\N
280	9DnnxvS6BBQ	How do Electron Microscopes Work? Taking Pictures of Atoms	Video by BranchEducation How do Electron Microscopes Work? Taking Pictures of Atoms	Physics	2011-11-13	133	\N	\N
281	h-NM1xSSzHQ	How do Computer Keyboards Work?	Video by BranchEducation How do Computer Keyboards Work?	Hardware	2002-11-14	133	\N	\N
282	d86ws7mQYIg	How does Computer Hardware Work?  [3D Animated Teardown]	Video by BranchEducation How does Computer Hardware Work?  [3D Animated Teardown]	Hardware	2003-04-13	133	\N	\N
283	wtdnatmVdIg	How do Hard Disk Drives Work?	Video by BranchEducation How do Hard Disk Drives Work?	Hardware	2019-08-14	133	\N	\N
284	7J7X7aZvMXQ	How does Computer Memory Work?	Video by BranchEducation How does Computer Memory Work?	Hardware	2015-08-28	133	\N	\N
285	X6wJE-4BLM0	Why are Smoke Detectors Radioactive?  And How do Smoke Detectors Work?	Video by BranchEducation Why are Smoke Detectors Radioactive?  And How do Smoke Detectors Work?	Physics	2007-05-24	133	\N	\N
286	1I1vxu5qIUM	How does Bluetooth Work?	Video by BranchEducation How does Bluetooth Work?	Hardware	2021-11-22	133	\N	\N
287	5Mh3o886qpg	How do SSDs Work? | How does your Smartphone store data? |  Insanely Complex Nanoscopic Structures!	Video by BranchEducation How do SSDs Work? | How does your Smartphone store data? |  Insanely Complex Nanoscopic Structures!	Hardware	2017-04-12	133	\N	\N
288	SAaESb4wTCM	How does a Mouse know when you move it?  ||  How Does a Computer Mouse Work?	Video by BranchEducation How does a Mouse know when you move it?  ||  How Does a Computer Mouse Work?	Hardware	2007-01-26	133	\N	\N
289	qs2QcycggWU	How does Starlink Satellite Internet Work?	Video by BranchEducation How does Starlink Satellite Internet Work?	Networks	2004-07-07	133	\N	\N
290	VnvkARDxulU	Shark Tank Pitches To Get You Ready For Christmas | Shark Tank US | Shark Tank Global	Video by SharkTankGlobal Shark Tank Pitches To Get You Ready For Christmas | Shark Tank US | Shark Tank Global	Shark Tank	2000-02-14	134	\N	\N
291	nQWtyQ9-Y2o	Shark Tank Australia - New Series	Video by SharkTankGlobal Shark Tank Australia - New Series	Shark Tank	2013-12-30	134	\N	\N
292	b7FqS4VNLRI	Technology | Season 5 | Shark Tank Australia	Video by SharkTankGlobal Technology | Season 5 | Shark Tank Australia	Shark Tank	2008-05-30	134	\N	\N
293	59poU9EGi18	Beauty & Fashion | Season 5 | Shark Tank Australia	Video by SharkTankGlobal Beauty & Fashion | Season 5 | Shark Tank Australia	Shark Tank	2009-11-11	134	\N	\N
294	2L9z6jL7TQ4	Mark Cuban Gives An ULTIMATUM To Hiccaway | Shark Tank US | Shark Tank Global	Video by SharkTankGlobal Mark Cuban Gives An ULTIMATUM To Hiccaway | Shark Tank US | Shark Tank Global	Shark Tank	2008-10-06	134	\N	\N
295	IQUTG0CxKXk	Christmas Dinner Cake | Dragons' Den #shorts	Video by SharkTankGlobal Christmas Dinner Cake | Dragons' Den #shorts	Shark Tank	2013-03-25	134	\N	\N
296	EN_7U8MninY	Mallow & Marsh Went On To Become A Leading Brand | Dragons' Den | Shark Tank Global	Video by SharkTankGlobal Mallow & Marsh Went On To Become A Leading Brand | Dragons' Den | Shark Tank Global	Shark Tank	2011-03-08	134	\N	\N
297	KRZvjjaFQ4k	Will The Sharks Secure The Bag With Cincha Travel? | Shark Tank US | Shark Tank Global	Video by SharkTankGlobal Will The Sharks Secure The Bag With Cincha Travel? | Shark Tank US | Shark Tank Global	Shark Tank	2000-01-26	134	\N	\N
298	yfl0oDIaFcY	Steve Calls Bull on Science Behind KLite | Shark Tank AUS| Shark Tank US | Shark Tank Global	Video by SharkTankGlobal Steve Calls Bull on Science Behind KLite | Shark Tank AUS| Shark Tank US | Shark Tank Global	Shark Tank	2018-01-26	134	\N	\N
299	GqpSxECpxGw	The Sharks Are Impressed with Parting Stone's Service | Shark Tank US | Shark Tank Global	Video by SharkTankGlobal The Sharks Are Impressed with Parting Stone's Service | Shark Tank US | Shark Tank Global	Shark Tank	2005-04-03	134	\N	\N
300	rSKMYc1CQHE	Coding Adventure: Simulating Fluids	Video by SebastianLague Coding Adventure: Simulating Fluids	Coding	2018-04-12	135	\N	\N
301	iScy18pVR58	Coding Challenge Announcement: Tiny Chess Bots	Video by SebastianLague Coding Challenge Announcement: Tiny Chess Bots	Coding	2010-07-03	135	\N	\N
302	_vqlIPDR2TU	Coding Adventure: Making a Better Chess Bot	Video by SebastianLague Coding Adventure: Making a Better Chess Bot	Coding	2014-09-27	135	\N	\N
303	kIMHRQWorkE	Answering Your Questions	Video by SebastianLague Answering Your Questions	Tech Talks	2001-10-21	135	\N	\N
304	Qz0KTGYJtUk	Coding Adventure: Ray Tracing	Video by SebastianLague Coding Adventure: Ray Tracing	Coding	2010-04-29	135	\N	\N
305	_3cNcmli6xQ	Experimenting with Buses and Three-State Logic	Video by SebastianLague Experimenting with Buses and Three-State Logic	Digital Logic	2017-08-02	135	\N	\N
306	sLqXFF8mlEU	I Tried Creating a Game Using Real-World Geographic Data	Video by SebastianLague I Tried Creating a Game Using Real-World Geographic Data	Game Dev	2009-10-26	135	\N	\N
307	I0-izyq6q5s	How Do Computers Remember?	Video by SebastianLague How Do Computers Remember?	Hardware	2019-05-18	135	\N	\N
308	UXD97l7ZT0w	Trying to Improve My Geography Game with More Real-World Data	Video by SebastianLague Trying to Improve My Geography Game with More Real-World Data	Game Dev	2003-06-23	135	\N	\N
309	U4ogK0MIzqk	Coding Adventure: Chess	Video by SebastianLague Coding Adventure: Chess	Coding	2023-10-03	135	\N	\N
310	LnzuMJLZRdU	Hello, world from scratch on a 6502 Part 1	Video by BenEater Hello, world from scratch on a 6502 Part 1	BenEater	2008-11-17	136	\N	\N
311	yl8vPW5hydQ	How do CPUs read machine code? 6502 part 2	Video by BenEater How do CPUs read machine code? 6502 part 2	BenEater	2019-10-21	136	\N	\N
312	oO8_2JJV0B4	Assembly language vs. machine code 6502 part 3	Video by BenEater Assembly language vs. machine code 6502 part 3	BenEater	2022-06-08	136	\N	\N
313	FY3zTUaykVo	Connecting an LCD to our computer 6502 part 4	Video by BenEater Connecting an LCD to our computer 6502 part 4	BenEater	2009-12-06	136	\N	\N
314	xBjQVxVxOxc	What is a stack and how does it work? 6502 part 5	Video by BenEater What is a stack and how does it work? 6502 part 5	BenEater	2020-10-18	136	\N	\N
315	i_wrxBdXTgM	RAM and bus timing 6502 part 6	Video by BenEater RAM and bus timing 6502 part 6	BenEater	2013-08-09	136	\N	\N
316	HyznrdDSSGM	8-bit computer update	Video by BenEater 8-bit computer update	BenEater	2016-06-20	136	\N	\N
317	kRlSFm519Bo	Astable 555 timer - 8-bit computer clock - part 1	Video by BenEater Astable 555 timer - 8-bit computer clock - part 1	BenEater	2014-01-29	136	\N	\N
318	81BgFhm2vz8	Monostable 555 timer - 8-bit computer clock - part 2	Video by BenEater Monostable 555 timer - 8-bit computer clock - part 2	BenEater	2010-06-14	136	\N	\N
319	WCwJNnx36Rk	Bistable 555 - 8-bit computer clock - part 3	Video by BenEater Bistable 555 - 8-bit computer clock - part 3	BenEater	2011-09-11	136	\N	\N
320	_AnovXOJOaw	New AI: 6,000,000,000 Steps In 24 Hours!	Video by TwoMinutePapers New AI: 6,000,000,000 Steps In 24 Hours!	AI	2000-11-09	137	\N	\N
321	ex1GeX0IhJQ	Gemini: ChatGPT-Like AI From Google DeepMind!	Video by TwoMinutePapers Gemini: ChatGPT-Like AI From Google DeepMind!	AI	2000-07-22	137	\N	\N
322	7rvjZQy_RQs	Text To Image AIs Just Got Supercharged!	Video by TwoMinutePapers Text To Image AIs Just Got Supercharged!	AI	2018-01-25	137	\N	\N
323	XwDaQKOxgFY	Stable Video AI Watched 600,000,000 Videos!	Video by TwoMinutePapers Stable Video AI Watched 600,000,000 Videos!	AI	2018-12-15	137	\N	\N
324	5_E5HNk3UN4	Blender 4.0 Is Here: A Revolution For Free!	Video by TwoMinutePapers Blender 4.0 Is Here: A Revolution For Free!	AI	2007-01-28	137	\N	\N
325	_3zbfgHmcJ4	10,000 Of These Train ChatGPT In 4 Minutes!	Video by TwoMinutePapers 10,000 Of These Train ChatGPT In 4 Minutes!	AI	2002-06-01	137	\N	\N
326	Lu56xVlZ40M	OpenAI Plays Hide and Seek and Breaks The Game!	Video by TwoMinutePapers OpenAI Plays Hide and Seek and Breaks The Game!	AI	2007-12-03	137	\N	\N
327	SsJ_AusntiU	This AI Learned Boxing With Serious Knockout Power!	Video by TwoMinutePapers This AI Learned Boxing With Serious Knockout Power!	AI	2011-09-20	137	\N	\N
328	54YvCE8_7lM	Is Simulating Soft and Bouncy Jelly Possible?	Video by TwoMinutePapers Is Simulating Soft and Bouncy Jelly Possible?	Physics	2021-03-15	137	\N	\N
329	7SM816P5G9s	Is a Realistic Honey Simulation Possible?	Video by TwoMinutePapers Is a Realistic Honey Simulation Possible?	Physics	2010-09-23	137	\N	\N
330	5iHejdqYIa8	Build a Virtual World Filled with Self-Driving Cars JavaScript Tutorial	Video by FreeCodeCamp Build a Virtual World Filled with Self-Driving Cars JavaScript Tutorial	AI	2013-11-06	138	\N	\N
331	JEBDfGqrAUA	Vector Search RAG Tutorial Combine Your Data with LLMs with Advanced Search	Video by FreeCodeCamp Vector Search RAG Tutorial Combine Your Data with LLMs with Advanced Search	AI	2016-10-13	138	\N	\N
332	uyhzCBEGaBY	Beginner JavaScript Project Snake Game Tutorial	Video by FreeCodeCamp Beginner JavaScript Project Snake Game Tutorial	Coding	2022-10-13	138	\N	\N
333	NhDYbskXRgc	AWS Certified Cloud Practitioner Certification Course (CLF-C02) - Pass the Exam!	Video by FreeCodeCamp AWS Certified Cloud Practitioner Certification Course (CLF-C02) - Pass the Exam!	Courses	2014-07-26	138	\N	\N
334	RMScMwY2B6Q	Build and Deploy an Instagram Clone with React and Firebase Tutorial	Video by FreeCodeCamp Build and Deploy an Instagram Clone with React and Firebase Tutorial	Courses	2022-08-01	138	\N	\N
335	8mAITcNt710	Harvard CS50 Full Computer Science University Course	Video by FreeCodeCamp Harvard CS50 Full Computer Science University Course	Courses	2002-10-03	138	\N	\N
336	8jLOx1hD3_o	C++ Programming Course - Beginner to Advanced	Video by FreeCodeCamp C++ Programming Course - Beginner to Advanced	Courses	2020-09-25	138	\N	\N
337	zJSY8tbf_ys	Frontend Web Development Bootcamp Course (JavaScript, HTML, CSS)	Video by FreeCodeCamp Frontend Web Development Bootcamp Course (JavaScript, HTML, CSS)	Courses	2017-03-30	138	\N	\N
338	WXsD0ZgxjRw	APIs for Beginners 2023 - How to use an API (Full Course / Tutorial)	Video by FreeCodeCamp APIs for Beginners 2023 - How to use an API (Full Course / Tutorial)	Courses	2011-05-30	138	\N	\N
339	VbEx7B_PTOE	Linux for Hackers (and everyone) // FREE Course for Beginners	Video by NetworkChunk Linux for Hackers (and everyone) // FREE Course for Beginners	Linux	2020-02-27	139	\N	\N
340	SvO_FDa8AIs	Hacker Skills // OSINT (Information Gathering)	Video by NetworkChunk Hacker Skills // OSINT (Information Gathering)	Networks	2015-01-27	139	\N	\N
341	yFC8pb2TPdc	Learn Ethical Hacking (CEH Journey)	Video by NetworkChunk Learn Ethical Hacking (CEH Journey)	Networks	2005-09-19	139	\N	\N
342	wX75Z-4MEoM	you need to learn Virtual Machines RIGHT NOW!! (Kali Linux VM, Ubuntu, Windows)	Video by NetworkChunk you need to learn Virtual Machines RIGHT NOW!! (Kali Linux VM, Ubuntu, Windows)	Networks	2018-12-28	139	\N	\N
343	z4_oqTZJqCo	how to HACK a password // password cracking with Kali Linux and HashCat	Video by NetworkChunk how to HACK a password // password cracking with Kali Linux and HashCat	Networks	2018-02-01	139	\N	\N
344	lUzSsX4T4WQ	your home router SUCKS!! (use pfSense instead)	Video by NetworkChunk your home router SUCKS!! (use pfSense instead)	Networks	2003-05-14	139	\N	\N
345	eZYtnzODpW4	i bought a DDoS attack on the DARK WEB (don't do this)	Video by NetworkChunk i bought a DDoS attack on the DARK WEB (don't do this)	Networks	2015-10-11	139	\N	\N
346	6CnDdXVTxhU	find info on phone numbers with PhoneInfoga	Video by NetworkChunk find info on phone numbers with PhoneInfoga	Networks	2008-12-26	139	\N	\N
347	KdZvxxLsN3E	find social media accounts with Sherlock (in 5 MIN)	Video by NetworkChunk find social media accounts with Sherlock (in 5 MIN)	Networks	2003-08-27	139	\N	\N
348	S7MNX_UD7vY	FREE CCNA // What is a Network? // Day 0	Video by NetworkChunk FREE CCNA // What is a Network? // Day 0	Networks	2020-01-29	139	\N	\N
349	_uQrJ0TkZlc	Python Tutorial - Python Full Course for Beginners	Video by CodeWithMosh Python Tutorial - Python Full Course for Beginners	Coding	2019-06-17	140	\N	\N
350	kqtD5dpn9C8	Python for Beginners - Learn Python in 1 Hour	Video by CodeWithMosh Python for Beginners - Learn Python in 1 Hour	Coding	2019-08-22	140	\N	\N
351	W6NZfCO5SIk	JavaScript Tutorial for Beginners: Learn JavaScript in 1 Hour	Video by CodeWithMosh JavaScript Tutorial for Beginners: Learn JavaScript in 1 Hour	Coding	2022-01-16	140	\N	\N
352	7S_tz1z_5bA	MySQL Tutorial for Beginners [Full Course]	Video by CodeWithMosh MySQL Tutorial for Beginners [Full Course]	Coding	2005-10-23	140	\N	\N
353	eIrMbAQSU34	Java Tutorial for Beginners	Video by CodeWithMosh Java Tutorial for Beginners	Coding	2005-08-28	140	\N	\N
354	qz0aGYrrlhU	HTML Tutorial for Beginners: HTML Crash Course	Video by CodeWithMosh HTML Tutorial for Beginners: HTML Crash Course	Coding	2020-07-16	140	\N	\N
355	r16Rn4_jDfk	How to Learn to Code and Make $60k+ a Year	Video by CodeWithMosh How to Learn to Code and Make $60k+ a Year	Coding	2022-02-26	140	\N	\N
356	bjFvcFjJpE0	Top Programming Languages in 2020	Video by CodeWithMosh Top Programming Languages in 2020	Coding	2017-06-10	140	\N	\N
357	pEbIhUySqbk	React vs Angular vs Vue: What to Learn to Get a Front-end Job	Video by CodeWithMosh React vs Angular vs Vue: What to Learn to Get a Front-end Job	Coding	2008-03-13	140	\N	\N
358	Y8Tko2YC5hA	What is Python? Why Python is So Popular?	Video by CodeWithMosh What is Python? Why Python is So Popular?	Coding	2006-04-07	140	\N	\N
359	gVzHNGyA_a4	Google's Epic Fail... the shocking result of Epic Games vs Google	Video by Fireship Google's Epic Fail... the shocking result of Epic Games vs Google	Tech Talks	2006-09-09	141	\N	\N
360	CgruI1RjH_c	Elon "based" Grok AI has entered the chat	Video by Fireship Elon "based" Grok AI has entered the chat	Tech Talks	2014-11-24	141	\N	\N
361	90CYYfl9ntM	The Gemini Lie	Video by Fireship The Gemini Lie	Tech Talks	2006-01-20	141	\N	\N
362	q5qAVmXSecQ	Google's Gemini just made GPT-4 look like a baby toy?	Video by Fireship Google's Gemini just made GPT-4 look like a baby toy?	Tech Talks	2003-08-14	141	\N	\N
363	vyQv563Y-fk	You probably won't survive 2024... Top 10 Tech Trends	Video by Fireship You probably won't survive 2024... Top 10 Tech Trends	Tech Talks	2018-11-01	141	\N	\N
364	ekPbZqPvCRA	5 crazy new AWS services just launched	Video by Fireship 5 crazy new AWS services just launched	Tech Talks	2013-05-02	141	\N	\N
365	hdHjjBS4cs8	Brainf**k in 100 Seconds	Video by Fireship Brainf**k in 100 Seconds	Tech Talks	2018-09-16	141	\N	\N
366	pEfrdAtAmqk	God-Tier Developer Roadmap	Video by Fireship God-Tier Developer Roadmap	Tech Talks	2005-02-03	141	\N	\N
367	ky5ZB-mqZKM	AI influencers are getting filthy rich... let's build one	Video by Fireship AI influencers are getting filthy rich... let's build one	Tech Talks	2010-09-17	141	\N	\N
368	_k-F-MMvQV4	10 Programmer Stereotypes	Video by Fireship 10 Programmer Stereotypes	Tech Talks	2016-05-23	141	\N	\N
\.


--
-- Data for Name: viewers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.viewers (user_id, date_of_birth) FROM stdin;
2	2002-03-29
4	2000-11-24
6	1980-05-12
8	1989-12-13
10	1995-06-17
12	1981-06-24
14	1986-04-18
16	1993-08-30
18	2002-02-21
20	1989-04-29
22	1977-11-23
24	1991-03-25
26	1992-12-10
28	2002-12-13
30	1983-03-30
32	1999-04-07
34	1975-10-04
36	1992-10-03
38	1996-08-24
40	1979-03-31
42	1976-02-17
44	1995-03-06
46	1998-03-22
48	1993-08-11
50	1991-04-18
52	1979-09-15
54	1978-09-19
56	1981-12-16
58	1998-03-23
60	1984-12-05
62	1999-02-06
64	1993-03-12
66	1975-08-26
68	1997-01-18
70	1975-04-30
72	1989-06-07
74	1974-02-09
76	1984-06-26
78	1989-10-23
80	1986-09-04
82	1988-07-10
84	1995-08-30
86	1986-08-30
88	2002-07-26
90	1980-11-20
92	1976-03-31
94	2002-02-19
96	1983-02-06
98	1973-06-10
100	1985-01-21
102	1976-08-30
104	1974-10-11
106	1999-02-20
108	1986-01-21
110	1979-05-23
112	1998-09-28
114	1987-03-14
116	1982-12-08
118	1976-05-01
120	1985-10-31
122	2003-02-20
124	1974-03-24
126	1993-01-04
128	1986-09-08
130	1981-08-05
132	1976-03-06
134	1978-06-08
136	1985-07-28
138	1997-07-18
140	1997-06-03
142	1988-01-17
144	1987-10-06
146	1985-03-16
148	1978-01-05
150	1979-08-02
152	1982-11-28
154	2000-09-02
156	2002-08-06
158	1989-09-28
160	1976-08-26
162	1997-09-22
164	1997-08-10
166	1982-12-04
168	1986-12-10
170	1974-08-21
172	1989-03-03
174	1992-04-19
176	1999-10-14
178	1994-06-28
180	1986-05-12
182	1992-07-13
184	2003-12-26
186	1983-01-06
188	1993-12-29
190	1989-12-09
192	1991-10-01
194	1993-09-10
196	2002-10-20
198	1979-10-15
200	1990-05-18
1	1977-08-21
17	1986-01-04
21	1980-07-12
23	1992-12-06
29	2000-11-27
31	1986-06-18
41	1978-02-28
43	1974-04-11
49	1973-01-11
51	2002-07-01
53	2001-04-13
57	1990-03-29
61	2003-12-09
63	1993-06-08
73	1974-03-05
81	1974-01-02
87	1980-02-04
91	1989-03-24
93	1985-09-11
97	1998-11-07
101	1988-11-08
103	1982-02-09
107	1985-09-14
109	1999-09-23
111	2001-08-06
113	2000-01-20
117	2003-05-08
119	2000-04-17
121	1974-04-26
123	1980-03-19
127	1973-01-27
129	1985-10-26
131	1996-02-02
133	1984-04-23
137	1978-04-08
139	1975-02-01
141	1995-09-19
143	1983-07-15
147	1974-07-18
149	1993-01-25
151	1980-06-21
153	1990-01-22
157	2001-09-17
159	1993-02-23
161	1987-07-17
163	2003-03-27
167	1982-10-15
169	1993-12-21
171	1983-03-07
173	1994-01-19
177	1995-11-20
179	1980-03-27
181	1975-05-13
183	1994-02-26
187	1991-02-02
189	1984-03-06
191	1989-10-24
193	1974-03-24
197	1978-11-27
199	1974-07-14
203	2011-11-11
204	2000-02-01
205	2000-02-11
206	2000-02-11
208	2000-02-11
210	2000-02-11
212	2000-02-11
213	2000-02-01
214	2000-02-11
215	2000-12-14
216	2000-08-03
217	2023-12-15
218	2023-12-30
219	2008-01-16
220	2023-12-10
221	2000-02-11
222	2000-08-08
223	2000-08-08
224	2000-12-02
225	2000-01-18
226	2000-12-20
19	2023-12-12
25	2023-12-12
27	2023-12-12
33	2023-12-12
35	2023-12-12
37	2023-12-12
39	2023-12-12
45	2023-12-12
47	2023-12-12
55	2023-12-12
59	2023-12-12
65	2023-12-12
67	2023-12-12
69	2023-12-12
71	2023-12-12
75	2023-12-12
77	2023-12-12
79	2023-12-12
83	2023-12-12
85	2023-12-12
89	2023-12-12
95	2023-12-12
99	2023-12-12
105	2023-12-12
115	2023-12-12
125	2023-12-12
3	2023-12-12
5	2023-12-12
7	2023-12-12
9	2023-12-12
11	2023-12-12
13	2023-12-12
15	2023-12-12
135	2023-12-12
145	2023-12-12
155	2023-12-12
165	2023-12-12
175	2023-12-12
185	2023-12-12
195	2023-12-12
227	2023-11-11
228	2003-06-01
229	1999-12-07
230	2001-12-31
231	2000-12-01
\.


--
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.views (video_id, viewer_uid) FROM stdin;
338	16
343	228
309	16
257	13
264	16
339	228
334	228
253	13
309	228
365	228
315	16
313	16
271	16
327	228
313	228
254	220
256	13
311	220
351	13
254	228
349	13
337	220
309	13
271	13
306	16
332	13
300	16
267	16
350	220
349	220
326	220
327	220
353	231
320	220
349	12
327	12
255	13
345	13
343	13
355	13
353	13
334	13
300	13
337	229
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.channels_id_seq', 141, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 231, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.videos_id_seq', 368, true);


--
-- Name: channels channels_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_name_key UNIQUE (name);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: creators creators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creators
    ADD CONSTRAINT creators_pkey PRIMARY KEY (user_id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (channel_id, viewer_uid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: videos videos_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_url_key UNIQUE (url);


--
-- Name: viewers viewers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viewers
    ADD CONSTRAINT viewers_pkey PRIMARY KEY (user_id);


--
-- Name: views views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_pkey PRIMARY KEY (video_id, viewer_uid);


--
-- Name: user_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_email_index ON public.users USING btree (email);


--
-- Name: channels channels_creator_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_creator_uid_fkey FOREIGN KEY (creator_uid) REFERENCES public.creators(user_id);


--
-- Name: creators creators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creators
    ADD CONSTRAINT creators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: impressions impressions_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions
    ADD CONSTRAINT impressions_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.videos(id) ON DELETE CASCADE;


--
-- Name: impressions impressions_viewer_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions
    ADD CONSTRAINT impressions_viewer_uid_fkey FOREIGN KEY (viewer_uid) REFERENCES public.viewers(user_id);


--
-- Name: subscriptions subscriptions_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id);


--
-- Name: subscriptions subscriptions_viewer_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_viewer_uid_fkey FOREIGN KEY (viewer_uid) REFERENCES public.viewers(user_id);


--
-- Name: videos videos_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id);


--
-- Name: viewers viewers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viewers
    ADD CONSTRAINT viewers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: views views_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.videos(id) ON DELETE CASCADE;


--
-- Name: views views_viewer_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_viewer_uid_fkey FOREIGN KEY (viewer_uid) REFERENCES public.viewers(user_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_advance(text, pg_lsn); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_advance(text, pg_lsn) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_create(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_create(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_drop(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_drop(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_oid(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_oid(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_progress(text, boolean); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_progress(text, boolean) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_is_setup(); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_is_setup() TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_progress(boolean); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_progress(boolean) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_reset(); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_reset() TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_session_setup(text); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_session_setup(text) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_xact_reset(); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_reset() TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_replication_origin_xact_setup(pg_lsn, timestamp with time zone) TO cloudsqlsuperuser;


--
-- Name: FUNCTION pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn); Type: ACL; Schema: pg_catalog; Owner: -
--

GRANT ALL ON FUNCTION pg_catalog.pg_show_replication_origin_status(OUT local_id oid, OUT external_id text, OUT remote_lsn pg_lsn, OUT local_lsn pg_lsn) TO cloudsqlsuperuser;


--
-- PostgreSQL database dump complete
--

