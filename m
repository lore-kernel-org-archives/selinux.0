Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r7NF5pIw001974
	for <selinux@tycho.nsa.gov>; Fri, 23 Aug 2013 11:05:51 -0400
References: <51F6A808.5080204@tycho.nsa.gov> <1377189006.38963.YahooMailNeo@web87904.mail.ir2.yahoo.com> <521668CA.7040305@tycho.nsa.gov>
Message-ID: <1377270346.9016.YahooMailNeo@web87904.mail.ir2.yahoo.com>
Date: Fri, 23 Aug 2013 16:05:46 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Common Intermediate Language (CIL) Update
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <521668CA.7040305@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="2125412622-1474874653-1377270346=:9016"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--2125412622-1474874653-1377270346=:9016
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the bad news, anyway I've been trying the classmap / classmappin=
g and not sure if this is a bug or=0Aanother change. The sample I've been u=
sing is (I just modified the test policy):=0A=0A=A0=A0=A0 (classmap files_r=
w (read write))=0A=0A=A0=A0=A0 (classmapping files_rw read=0A=A0=A0=A0 =A0=
=A0=A0 (file (open read getattr)))=0A=0A=A0=A0=A0 (classmapping files_rw wr=
ite=0A=A0=A0=A0=A0=A0=A0=A0 (file (execute_no_trans entrypoint execmod open=
 audit_access))=0A=A0=A0=A0 =A0=A0=A0 (file (open write setattr)))=0A=0AHow=
ever the results vary between your version and the Tresys version as follow=
s:=0A=0Asecil from git clone http://oss.tresys.com/git/cil.git cil=0Aallow =
policy.console_t policy.t_1 : policy.file { write setattr execute_no_trans =
entrypoint execmod open audit_access } ;=0Aallow policy.console_t policy.t_=
2 : policy.file { read getattr open } ;=0A=0Asecil from git clone https://j=
wcarter@bitbucket.org/jwcarter/secilc.git=0Aallow policy.console_t policy.t=
_1 : policy.file { execute_no_trans entrypoint execmod open audit_access } =
;=0Aallow policy.console_t policy.t_2 : policy.file { read getattr open } ;=
=0A=0A=0AI think the Tresys version is correct (well I hope so)=0A=0ARichar=
d=0A=0A=0A=0A________________________________=0A From: James Carter <jwcart=
2@tycho.nsa.gov>=0ATo: Richard Haines <richard_c_haines@btinternet.com> =0A=
Cc: SELinux List <selinux@tycho.nsa.gov> =0ASent: Thursday, 22 August 2013,=
 20:38=0ASubject: Re: Common Intermediate Language (CIL) Update=0A =0A=0AOn=
 08/22/2013 12:30 PM, Richard Haines wrote:=0A> Thanks for the updated CIL =
that has many useful fixes, however I notice that you removed the "permissi=
onset" statement. Is this to be dropped altogether or just in your version =
(I've got lots in my test policy so thought I would ask before I change the=
m all).=0A>=0A=0AYes, it is. Permissions can no longer be referred to apart=
 from their class. Not =0Aonly was the permissionset statement removed, but=
 permissions can no longer be =0Apassed as an argument to a call.=0A=0AEith=
er classpermissionset or classmapping statements can be used to replace =0A=
them. I am sorry to say that this is a little bit more work up front, but I=
 =0Athink it makes sense for the overall policy.=0A=0A=0A> Richard=0A>=0A>=
=0A>=0A> ________________________________=0A>=A0  From: James Carter <jwcar=
t2@tycho.nsa.gov>=0A> To: SELinux List <selinux@tycho.nsa.gov>=0A> Cc: Stev=
e Lawrence <slawrence@tresys.com>=0A> Sent: Monday, 29 July 2013, 18:36=0A>=
 Subject: Common Intermediate Language (CIL) Update=0A>=0A>=0A> The CIL com=
piler, secilc, is now able to create MLS, MCS, and non-MLS binary policies =
from a slightly modified version of Refpolicy that has been converted to CI=
L.=0A>=0A> Anyone interested in trying CIL out can do the following:=0A>=0A=
> 1) Clone the CIL compiler and cilpolicy=0A> git clone https://jwcarter@bi=
tbucket.org/jwcarter/secilc.git=0A> git clone https://jwcarter@bitbucket.or=
g/jwcarter/cilpolicy.git=0A>=0A> 2) Build secilc=0A> cd secilc=0A> make=0A>=
 cd ..=0A>=0A> 3) Build cilpolicy=0A> ./secilc/secilc `cat cilpolicy/LISTIN=
G`=0A>=0A>=0A> To build an MLS policy:=0A>=0A> Edit "cilpolicy/mls_declarat=
ions" and change "(tunable enable_mls false)" to "(tunable enable_mls true)=
"=0A>=0A> Build the MLS policy: ./secilc/secilc -M `cat cilpolicy/LISTING`=
=0A>=0A> MCS is similar.=0A>=0A>=0A> Anyone interested in trying to create =
their own CIL policy from Refpolicy can clone the Flask Policy Parser (fpp)=
 from bitbucket and follow the instructions in the README. To clone fpp:=0A=
> git clone https://jwcarter@bitbucket.org/jwcarter/fpp.git=0A>=0A> -- Jame=
s Carter <jwcart2@tycho.nsa.gov>=0A> National Security Agency=0A>=0A> --=0A=
> This message was distributed to subscribers of the selinux mailing list.=
=0A> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.g=
ov with=0A> the words "unsubscribe selinux" without quotes as the message.=
=0A>=0A=0A=0A-- =0AJames Carter <jwcart2@tycho.nsa.gov>=0ANational Security=
 Agency=0A=0A--=0AThis message was distributed to subscribers of the selinu=
x mailing list.=0AIf you no longer wish to subscribe, send mail to majordom=
o@tycho.nsa.gov with=0Athe words "unsubscribe selinux" without quotes as th=
e message.
--2125412622-1474874653-1377270346=:9016
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt">Thanks for the bad ne=
ws, anyway I've been trying the classmap / classmapping and not sure if thi=
s is a bug or<br>another change. The sample I've been using is (I just modi=
fied the test policy):<br><br>&nbsp;&nbsp;&nbsp; (classmap files_rw (read w=
rite))<br><br>&nbsp;&nbsp;&nbsp; (classmapping files_rw read<br>&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; (file (open read getattr)))<br><br>&nbsp;&nbsp;&=
nbsp; (classmapping files_rw write<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; (file (execute_no_trans entrypoint execmod open audit_access))<br>&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (file (open write setattr)))<br><br>Howe=
ver the results vary between your version and the Tresys version as follows=
:<br><br>secil from git clone http://oss.tresys.com/git/cil.git cil<br>allo=
w policy.console_t policy.t_1 : policy.file { write setattr
 execute_no_trans entrypoint execmod open audit_access } ;<br>allow policy.=
console_t policy.t_2 : policy.file { read getattr open } ;<br><br>secil fro=
m git clone https://jwcarter@bitbucket.org/jwcarter/secilc.git<br>allow pol=
icy.console_t policy.t_1 : policy.file { execute_no_trans entrypoint execmo=
d open audit_access } ;<br>allow policy.console_t policy.t_2 : policy.file =
{ read getattr open } ;<br><br><div><span>I think the Tresys version is cor=
rect (well I hope so)</span></div><div style=3D"color: rgb(0, 0, 0); font-s=
ize: 16px; font-family: times new roman,new york,times,serif; background-co=
lor: transparent; font-style: normal;"><br><span></span></div><div style=3D=
"color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new yor=
k,times,serif; background-color: transparent; font-style: normal;"><span>Ri=
chard<br></span></div><div><br></div>  <div style=3D"font-family: times new=
 roman, new york, times, serif; font-size: 12pt;"> <div
 style=3D"font-family: times new roman, new york, times, serif; font-size: =
12pt;"> <div dir=3D"ltr"> <hr size=3D"1">  <font face=3D"Arial" size=3D"2">=
 <b><span style=3D"font-weight:bold;">From:</span></b> James Carter &lt;jwc=
art2@tycho.nsa.gov&gt;<br> <b><span style=3D"font-weight: bold;">To:</span>=
</b> Richard Haines &lt;richard_c_haines@btinternet.com&gt; <br><b><span st=
yle=3D"font-weight: bold;">Cc:</span></b> SELinux List &lt;selinux@tycho.ns=
a.gov&gt; <br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Thurs=
day, 22 August 2013, 20:38<br> <b><span style=3D"font-weight: bold;">Subjec=
t:</span></b> Re: Common Intermediate Language (CIL) Update<br> </font> </d=
iv> <div class=3D"y_msg_container"><br>On 08/22/2013 12:30 PM, Richard Hain=
es wrote:<br>&gt; Thanks for the updated CIL that has many useful fixes, ho=
wever I notice that you removed the "permissionset" statement. Is this to b=
e dropped altogether or just in your version (I've got lots in my test poli=
cy so thought I
 would ask before I change them all).<br>&gt;<br><br>Yes, it is. Permission=
s can no longer be referred to apart from their class. Not <br>only was the=
 permissionset statement removed, but permissions can no longer be <br>pass=
ed as an argument to a call.<br><br>Either classpermissionset or classmappi=
ng statements can be used to replace <br>them. I am sorry to say that this =
is a little bit more work up front, but I <br>think it makes sense for the =
overall policy.<br><br><br>&gt; Richard<br>&gt;<br>&gt;<br>&gt;<br>&gt; ___=
_____________________________<br>&gt;&nbsp;  From: James Carter &lt;<a ymai=
lto=3D"mailto:jwcart2@tycho.nsa.gov" href=3D"mailto:jwcart2@tycho.nsa.gov">=
jwcart2@tycho.nsa.gov</a>&gt;<br>&gt; To: SELinux List &lt;<a ymailto=3D"ma=
ilto:selinux@tycho.nsa.gov" href=3D"mailto:selinux@tycho.nsa.gov">selinux@t=
ycho.nsa.gov</a>&gt;<br>&gt; Cc: Steve Lawrence &lt;<a ymailto=3D"mailto:sl=
awrence@tresys.com"
 href=3D"mailto:slawrence@tresys.com">slawrence@tresys.com</a>&gt;<br>&gt; =
Sent: Monday, 29 July 2013, 18:36<br>&gt; Subject: Common Intermediate Lang=
uage (CIL) Update<br>&gt;<br>&gt;<br>&gt; The CIL compiler, secilc, is now =
able to create MLS, MCS, and non-MLS binary policies from a slightly modifi=
ed version of Refpolicy that has been converted to CIL.<br>&gt;<br>&gt; Any=
one interested in trying CIL out can do the following:<br>&gt;<br>&gt; 1) C=
lone the CIL compiler and cilpolicy<br>&gt; git clone <a href=3D"https://jw=
carter@bitbucket.org/jwcarter/secilc.git" target=3D"_blank">https://jwcarte=
r@bitbucket.org/jwcarter/secilc.git</a><br>&gt; git clone <a href=3D"https:=
//jwcarter@bitbucket.org/jwcarter/cilpolicy.git" target=3D"_blank">https://=
jwcarter@bitbucket.org/jwcarter/cilpolicy.git</a><br>&gt;<br>&gt; 2) Build =
secilc<br>&gt; cd secilc<br>&gt; make<br>&gt; cd ..<br>&gt;<br>&gt; 3) Buil=
d cilpolicy<br>&gt; ./secilc/secilc `cat
 cilpolicy/LISTING`<br>&gt;<br>&gt;<br>&gt; To build an MLS policy:<br>&gt;=
<br>&gt; Edit "cilpolicy/mls_declarations" and change "(tunable enable_mls =
false)" to "(tunable enable_mls true)"<br>&gt;<br>&gt; Build the MLS policy=
: ./secilc/secilc -M `cat cilpolicy/LISTING`<br>&gt;<br>&gt; MCS is similar=
.<br>&gt;<br>&gt;<br>&gt; Anyone interested in trying to create their own C=
IL policy from Refpolicy can clone the Flask Policy Parser (fpp) from bitbu=
cket and follow the instructions in the README. To clone fpp:<br>&gt; git c=
lone <a href=3D"https://jwcarter@bitbucket.org/jwcarter/fpp.git" target=3D"=
_blank">https://jwcarter@bitbucket.org/jwcarter/fpp.git</a><br>&gt;<br>&gt;=
 -- James Carter &lt;<a ymailto=3D"mailto:jwcart2@tycho.nsa.gov" href=3D"ma=
ilto:jwcart2@tycho.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt;<br>&gt; National =
Security Agency<br>&gt;<br>&gt; --<br>&gt; This message was distributed to =
subscribers of the selinux mailing list.<br>&gt; If you no longer wish to
 subscribe, send mail to <a ymailto=3D"mailto:majordomo@tycho.nsa.gov" href=
=3D"mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>&gt=
; the words "unsubscribe selinux" without quotes as the message.<br>&gt;<br=
><br><br>-- <br>James Carter &lt;<a ymailto=3D"mailto:jwcart2@tycho.nsa.gov=
" href=3D"mailto:jwcart2@tycho.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt;<br>Na=
tional Security Agency<br><br>--<br>This message was distributed to subscri=
bers of the selinux mailing list.<br>If you no longer wish to subscribe, se=
nd mail to <a ymailto=3D"mailto:majordomo@tycho.nsa.gov" href=3D"mailto:maj=
ordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>the words "unsubs=
cribe selinux" without quotes as the message.<br><br><br></div> </div> </di=
v>  </div></body></html>
--2125412622-1474874653-1377270346=:9016--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
