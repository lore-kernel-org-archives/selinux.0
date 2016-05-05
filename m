MIME-Version: 1.0
Date: Wed, 4 May 2016 23:32:59 -0700
Message-ID: <CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com>
Subject: Selinux Docker issues
From: Naina Emmanuel <nemmanuel1992@gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 jwcart2@tycho.nsa.gov, david.d.merritt@gmail.com, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113ffd646d60cf053212836e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ffd646d60cf053212836e
Content-Type: text/plain; charset=UTF-8

Good Morning,
I am working on docker and its securituy through SElinux, I am facing some
problems and have some Questions to ask...

Q1: If for the containers, we have MLS policy to be configured
SelinuxType=mls in /etc/selinux/config,  then on the host for other modules
we have targeted policy, how can take these two different types
simultaneously ?

Q2: Docker is running on my Centos7, still it is giving unconfined_t label
on docker process, (policy is configured as selinuxtype=mls and
selinux=permissive)

Q3: In targeted rpm package i have found namespace.te and cgroup.te, if
docker works on mls, then why these policy modules are given in targeted
rpm?

Q4: Where is mls policy is located? As we have .te policy for targeted


please guide me in these regard

Thanks in advance





*Engr. Naina Emmanuel*
*Linux Essential Certified (LEPDC)*
*Cisco Certified Network Associate (CCNA)*

*Computer Engineering Department, UET Taxila*

*Information Security, CS Department, CIIT Islamabad*

--001a113ffd646d60cf053212836e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div =
dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"=
ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Good Morning,</div><div>I am wo=
rking on docker and its securituy through SElinux, I am facing some problem=
s and have some Questions to ask...</div><div><br></div><div>Q1: If for the=
 containers, we have MLS policy to be configured SelinuxType=3Dmls in /etc/=
selinux/config, =C2=A0then on the host for other modules we have targeted p=
olicy, how can take these two different types simultaneously ?=C2=A0</div><=
div><br></div><div>Q2: Docker is running on my Centos7, still it is giving =
unconfined_t label on docker process, (policy is configured as selinuxtype=
=3Dmls and selinux=3Dpermissive)</div><div><br></div><div>Q3: In targeted r=
pm package i have found namespace.te and cgroup.te, if docker works on mls,=
 then why these policy modules are given in targeted rpm?</div><div><br></d=
iv><div>Q4: Where is mls policy is located? As we have .te policy for targe=
ted=C2=A0</div><div><br></div><div><br></div><div>please guide me in these =
regard</div><div><br></div><div>Thanks in advance</div><font size=3D"4"><di=
v><br></div><div style=3D"font-weight:bold"><font size=3D"4"><b><br></b></f=
ont></div><div style=3D"font-weight:bold"><font size=3D"4"><b><br></b></fon=
t></div><div style=3D"font-weight:bold"><font size=3D"4"><b><br></b></font>=
</div><div style=3D"font-weight:bold"><font size=3D"4"><b><br></b></font></=
div><font color=3D"#666666" style=3D"font-weight:bold"><i>Engr. Naina Emman=
uel</i></font></font><div><b style=3D"color:rgb(102,102,102);font-size:smal=
l">Linux Essential Certified (LEPDC)</b><font color=3D"#666666" size=3D"2">=
<b><br></b></font></div><div><font color=3D"#666666" size=3D"2"><b>Cisco Ce=
rtified Network Associate (CCNA)</b></font></div><div><b style=3D"color:rgb=
(102,102,102);font-size:small">Computer Engineering Department, UET Taxila<=
br></b></div><div><b style=3D"color:rgb(102,102,102);font-size:small">Infor=
mation Security, CS Department, CIIT Islamabad<br></b></div></div></div></d=
iv></div></div></div></div></div></div></div>
</div>

--001a113ffd646d60cf053212836e--
