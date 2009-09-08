Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88K0BGU005304
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 16:00:11 -0400
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n88K1UUf024870
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 20:01:30 GMT
Received: by ey-out-1920.google.com with SMTP id 3so1130568eyh.32
        for <selinux@tycho.nsa.gov>; Tue, 08 Sep 2009 13:00:09 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Sep 2009 22:00:08 +0200
Message-ID: <51af93b70909081300g582d6939g54540ca371095c2d@mail.gmail.com>
Subject: RHEL, RHCS, and Selinux : hype, reality or dream?
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e6d99fb9d5ad73047316693c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d99fb9d5ad73047316693c
Content-Type: text/plain; charset=ISO-8859-1

Hi. Sorry in advance for the polemical tone and the topic that is not
technical.



I have found really very interesting the recent indication of RHEL 5.4
cluster suite manual
http://www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/html/Cluster_Administration/index.html
*

2.7. Red Hat Cluster Suite and SELinux
*

Red Hat Cluster Suite for Red Hat Enterprise Linux 5 requires that SELinux
be disabled. Before

configuring a Red Hat cluster, make sure to disable SELinux. For example,
you can disable SELinux

upon installation of Red Hat Enterprise Linux 5 or you can specify
*SELINUX=disabled
*in the */etc/

selinux/config *file.

Yes disable not permissive.

Bearing in mind that most or perhaps all of the companies that use this
distribution implement forms of HA with thr cluster suite.This is a real
indication from a distribution to disable selinux anyway, just to have a
certified product. My concern is the company who makes these statements and
the fact that redhat cluster suite is really a company product, albeit open
source. So it should be not so hard to resolve selinux issue.

 Years of work on selinux thwarted by a statement that only a small change
to the selinux policy could have resolved and may have already solved. Not a
good thing for selinux.

regards

--0016e6d99fb9d5ad73047316693c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi. Sorry in advance for the polemical tone and the topic =
that is not technical. </div>
<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr"><br><br>I have found really very interesting the recent in=
dication of=A0RHEL 5.4 cluster suite manual </div>
<div dir=3D"ltr"><a href=3D"http://www.redhat.com/docs/en-US/Red_Hat_Enterp=
rise_Linux/5.4/html/Cluster_Administration/index.html">http://www.redhat.co=
m/docs/en-US/Red_Hat_Enterprise_Linux/5.4/html/Cluster_Administration/index=
.html</a></div>

<div dir=3D"ltr"><b><font color=3D"#a80000" size=3D"5" face=3D"LiberationSa=
ns-Bold"><font color=3D"#a80000" size=3D"5" face=3D"LiberationSans-Bold"><f=
ont color=3D"#a80000" size=3D"5" face=3D"LiberationSans-Bold">
<p align=3D"left">2.7. Red Hat Cluster Suite and SELinux</p></font></font><=
/font></b><font size=3D"2" face=3D"LiberationSans"><font size=3D"2" face=3D=
"LiberationSans">
<p align=3D"left">Red Hat Cluster Suite for Red Hat Enterprise Linux 5 requ=
ires that SELinux be disabled. Before</p>
<p align=3D"left">configuring a Red Hat cluster, make sure to disable SELin=
ux. For example, you can disable SELinux</p>
<p align=3D"left">upon installation of Red Hat Enterprise Linux 5 or you ca=
n specify </p></font></font><b><font size=3D"2" face=3D"LiberationMono-Bold=
"><font size=3D"2" face=3D"LiberationMono-Bold">SELINUX=3Ddisabled </font><=
/font></b><font size=3D"2" face=3D"LiberationSans"><font size=3D"2" face=3D=
"LiberationSans">in the </font></font><b><font size=3D"2" face=3D"Liberatio=
nMono-Bold"><font size=3D"2" face=3D"LiberationMono-Bold">/etc/
<p align=3D"left">selinux/config </p></font></font></b><font size=3D"2" fac=
e=3D"LiberationSans"><font size=3D"2" face=3D"LiberationSans">file.</font><=
/font></div>
<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr">Yes disable not permissive.</div>
<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr">Bearing in mind that most or perhaps all of the companies =
that use this distribution implement forms of HA with thr cluster=A0suite.T=
his is a real indication=A0from a=A0distribution to disable selinux anyway,=
 just to have a certified product. My concern is=A0the company who makes th=
ese statements and the fact that redhat cluster suite is really a company p=
roduct, albeit open source. So=A0it should be not so hard to resolve selinu=
x issue.=A0=A0</div>

<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr">
<div dir=3D"ltr" id=3D"result_box">Years of work on selinux thwarted by a s=
tatement that only a small change to the selinux policy could=A0have resolv=
ed and may have already solved. Not a good thing for selinux.</div>
<div dir=3D"ltr">=A0</div>
<div dir=3D"ltr">regards</div></div>

--0016e6d99fb9d5ad73047316693c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
