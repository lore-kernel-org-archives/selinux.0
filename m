Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r7MGUBM6023370
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2013 12:30:12 -0400
References: <51F6A808.5080204@tycho.nsa.gov>
Message-ID: <1377189006.38963.YahooMailNeo@web87904.mail.ir2.yahoo.com>
Date: Thu, 22 Aug 2013 17:30:06 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Common Intermediate Language (CIL) Update
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <51F6A808.5080204@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="2125412622-1831948351-1377189006=:38963"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--2125412622-1831948351-1377189006=:38963
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the updated CIL that has many useful fixes, however I notice tha=
t you removed the "permissionset" statement. Is this to be dropped altogeth=
er or just in your version (I've got lots in my test policy so thought I wo=
uld ask before I change them all).=0A=0ARichard=0A=0A=0A=0A________________=
________________=0A From: James Carter <jwcart2@tycho.nsa.gov>=0ATo: SELinu=
x List <selinux@tycho.nsa.gov> =0ACc: Steve Lawrence <slawrence@tresys.com>=
 =0ASent: Monday, 29 July 2013, 18:36=0ASubject: Common Intermediate Langua=
ge (CIL) Update=0A =0A=0AThe CIL compiler, secilc, is now able to create ML=
S, MCS, and non-MLS binary policies from a slightly modified version of Ref=
policy that has been converted to CIL.=0A=0AAnyone interested in trying CIL=
 out can do the following:=0A=0A1) Clone the CIL compiler and cilpolicy=0Ag=
it clone https://jwcarter@bitbucket.org/jwcarter/secilc.git=0Agit clone htt=
ps://jwcarter@bitbucket.org/jwcarter/cilpolicy.git=0A=0A2) Build secilc=0Ac=
d secilc=0Amake=0Acd ..=0A=0A3) Build cilpolicy=0A./secilc/secilc `cat cilp=
olicy/LISTING`=0A=0A=0ATo build an MLS policy:=0A=0AEdit "cilpolicy/mls_dec=
larations" and change "(tunable enable_mls false)" to "(tunable enable_mls =
true)"=0A=0ABuild the MLS policy: ./secilc/secilc -M `cat cilpolicy/LISTING=
`=0A=0AMCS is similar.=0A=0A=0AAnyone interested in trying to create their =
own CIL policy from Refpolicy can clone the Flask Policy Parser (fpp) from =
bitbucket and follow the instructions in the README. To clone fpp:=0Agit cl=
one https://jwcarter@bitbucket.org/jwcarter/fpp.git=0A=0A-- James Carter <j=
wcart2@tycho.nsa.gov>=0ANational Security Agency=0A=0A--=0AThis message was=
 distributed to subscribers of the selinux mailing list.=0AIf you no longer=
 wish to subscribe, send mail to majordomo@tycho.nsa.gov with=0Athe words "=
unsubscribe selinux" without quotes as the message.
--2125412622-1831948351-1377189006=:38963
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span>Thanks for=
 the updated CIL that has many useful fixes, however I notice that you remo=
ved the "permissionset" statement. Is this to be dropped altogether or just=
 in your version (I've got lots in my test policy so thought I would ask be=
fore I change them all).</span></div><div style=3D"color: rgb(0, 0, 0); fon=
t-size: 16px; font-family: times new roman,new york,times,serif; background=
-color: transparent; font-style: normal;"><br><span></span></div><div style=
=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new =
york,times,serif; background-color: transparent; font-style: normal;"><span=
>Richard<br></span></div><div><br></div>  <div style=3D"font-family: times =
new roman, new york, times, serif; font-size: 12pt;"> <div style=3D"font-fa=
mily: times new roman, new york, times, serif; font-size: 12pt;"> <div
 dir=3D"ltr"> <hr size=3D"1">  <font face=3D"Arial" size=3D"2"> <b><span st=
yle=3D"font-weight:bold;">From:</span></b> James Carter &lt;jwcart2@tycho.n=
sa.gov&gt;<br> <b><span style=3D"font-weight: bold;">To:</span></b> SELinux=
 List &lt;selinux@tycho.nsa.gov&gt; <br><b><span style=3D"font-weight: bold=
;">Cc:</span></b> Steve Lawrence &lt;slawrence@tresys.com&gt; <br> <b><span=
 style=3D"font-weight: bold;">Sent:</span></b> Monday, 29 July 2013, 18:36<=
br> <b><span style=3D"font-weight: bold;">Subject:</span></b> Common Interm=
ediate Language (CIL) Update<br> </font> </div> <div class=3D"y_msg_contain=
er"><br>The CIL compiler, secilc, is now able to create MLS, MCS, and non-M=
LS binary policies from a slightly modified version of Refpolicy that has b=
een converted to CIL.<br><br>Anyone interested in trying CIL out can do the=
 following:<br><br>1) Clone the CIL compiler and cilpolicy<br>git clone <a =
href=3D"https://jwcarter@bitbucket.org/jwcarter/secilc.git"
 target=3D"_blank">https://jwcarter@bitbucket.org/jwcarter/secilc.git</a><b=
r>git clone <a href=3D"https://jwcarter@bitbucket.org/jwcarter/cilpolicy.gi=
t" target=3D"_blank">https://jwcarter@bitbucket.org/jwcarter/cilpolicy.git<=
/a><br><br>2) Build secilc<br>cd secilc<br>make<br>cd ..<br><br>3) Build ci=
lpolicy<br>./secilc/secilc `cat cilpolicy/LISTING`<br><br><br>To build an M=
LS policy:<br><br>Edit "cilpolicy/mls_declarations" and change "(tunable en=
able_mls false)" to "(tunable enable_mls true)"<br><br>Build the MLS policy=
: ./secilc/secilc -M `cat cilpolicy/LISTING`<br><br>MCS is similar.<br><br>=
<br>Anyone interested in trying to create their own CIL policy from Refpoli=
cy can clone the Flask Policy Parser (fpp) from bitbucket and follow the in=
structions in the README. To clone fpp:<br>git clone <a href=3D"https://jwc=
arter@bitbucket.org/jwcarter/fpp.git" target=3D"_blank">https://jwcarter@bi=
tbucket.org/jwcarter/fpp.git</a><br><br>-- James Carter &lt;<a
 ymailto=3D"mailto:jwcart2@tycho.nsa.gov" href=3D"mailto:jwcart2@tycho.nsa.=
gov">jwcart2@tycho.nsa.gov</a>&gt;<br>National Security Agency<br><br>--<br=
>This message was distributed to subscribers of the selinux mailing list.<b=
r>If you no longer wish to subscribe, send mail to <a ymailto=3D"mailto:maj=
ordomo@tycho.nsa.gov" href=3D"mailto:majordomo@tycho.nsa.gov">majordomo@tyc=
ho.nsa.gov</a> with<br>the words "unsubscribe selinux" without quotes as th=
e message.<br><br><br></div> </div> </div>  </div></body></html>
--2125412622-1831948351-1377189006=:38963--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
