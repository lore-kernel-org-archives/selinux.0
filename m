Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6BIeUJL014530
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2013 14:40:30 -0400
References: 
Message-ID: <1373567937.10428.YahooMailNeo@web163406.mail.gq1.yahoo.com>
Date: Thu, 11 Jul 2013 11:38:57 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: AVC for unlabeled_t on cgroup
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="-346883024-1210401202-1373567937=:10428"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---346883024-1210401202-1373567937=:10428
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,=0A=0AI'm implementing a restrictive policy for RHEL 6.3 based on CLI=
P. I've enabled the cgroup module but I'm still seeing the AVC below. This =
is just one of a dozen similar AVC's for different inodes. When I look at t=
he /cgroup after the system boots, everything has a cgroup_t label. Where w=
ould the unlabeled_t be coming from?=0A=0A=0A=0Atype=3DSYSCALL msg=3Daudit(=
07/11/2013 17:25:38.885:7) : arch=3Dx86_64 syscall=3Dmount success=3Dyes ex=
it=3D0 a0=3D7f57846ac4c1 a1=3D7f57848b03c0 a2=3D7f57846ac4c1 a3=3D0 items=
=3D0 ppid=3D1177 pid=3D1178 auid=3Dunset uid=3Droot gid=3Droot euid=3Droot =
suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none) =
ses=3Dunset comm=3Dcgconfigparser exe=3D/sbin/cgconfigparser subj=3Dsystem_=
u:system_r:cgconfig_t:s0 key=3D(null) =0A=0Atype=3DAVC msg=3Daudit(07/11/20=
13 17:25:38.885:7) : avc:=A0 denied=A0 { search } for=A0 pid=3D1178 comm=3D=
cgconfigparser name=3D/ dev=3Dcgroup ino=3D12518 scontext=3Dsystem_u:system=
_r:kernel_t:s0 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Ddir =0A=
=0A=0AThanks,=0AAndrew Ruch=0A
---346883024-1210401202-1373567937=:10428
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div id=3D"yiv4659585=
439"><div><div style=3D"color:#000;background-color:#fff;font-family:times =
new roman, new york, times, serif;font-size:12pt;"><div id=3D"yiv4659585439=
yui_3_7_2_41_1373556488332_39">Hello,</div><div id=3D"yiv4659585439yui_3_7_=
2_41_1373556488332_73"><br></div><div style=3D"color:rgb(0, 0, 0);font-size=
:16px;font-family:times new roman, new york, times, serif;background-color:=
transparent;font-style:normal;" id=3D"yiv4659585439yui_3_7_2_41_13735564883=
32_75">I'm implementing a restrictive policy for RHEL 6.3 based on CLIP. I'=
ve enabled the cgroup module but I'm still seeing the AVC below. This is ju=
st one of a dozen similar AVC's for different inodes. When I look at the /c=
group after the system boots, everything has a cgroup_t label. Where would =
the unlabeled_t be coming from?<br><br
 id=3D"yiv4659585439yui_3_7_2_41_1373556488332_67"></div><div id=3D"yiv4659=
585439yui_3_7_2_41_1373556488332_68" style=3D"color:rgb(0, 0, 0);font-size:=
16px;font-family:times new roman, new york, times, serif;background-color:t=
ransparent;font-style:normal;"><br>type=3DSYSCALL msg=3Daudit(07/11/2013 17=
:25:38.885:7) : arch=3Dx86_64 syscall=3Dmount success=3Dyes exit=3D0 a0=3D7=
f57846ac4c1 a1=3D7f57848b03c0 a2=3D7f57846ac4c1 a3=3D0 items=3D0 ppid=3D117=
7 pid=3D1178 auid=3Dunset uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsu=
id=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3D(none) ses=3Dunset com=
m=3Dcgconfigparser exe=3D/sbin/cgconfigparser subj=3Dsystem_u:system_r:cgco=
nfig_t:s0 key=3D(null) <br><br>type=3DAVC msg=3Daudit(07/11/2013 17:25:38.8=
85:7) : avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D1178 comm=3Dcgco=
nfigparser name=3D/ dev=3Dcgroup ino=3D12518 scontext=3Dsystem_u:system_r:k=
ernel_t:s0 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Ddir <br><br=
><br>Thanks,<br>Andrew Ruch<br></div></div></div></div></div></body></html>
---346883024-1210401202-1373567937=:10428--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
