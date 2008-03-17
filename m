MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8887B.99D08A2A"
Subject: RE: First Attempt at root login on console always FAILS ??
Date: Mon, 17 Mar 2008 18:09:43 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0472B4EF@de01exm68.ds.mot.com>
In-Reply-To: <1205756531.22912.128.camel@moss-spartans.epoch.ncsc.mil>
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com> <47D9BBEE.5090105@redhat.com> <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil> <47DA9A3C.3080802@redhat.com>  <47DAD18F.5000309@tycho.nsa.gov> <1205525125.22912.96.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0472B132@de01exm68.ds.mot.com> <1205756531.22912.128.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8887B.99D08A2A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Stephen & Dan,

>From the /var/log/ files, I am not sure what pam module is having
problems ?!?  All I get, is a "System error" in the /var/log/secure file
!

So I reset the card, when I try to login the first time on the console
as root, I get "Login incorrect", and the second time, the login is
successful. This is 100% reproducible.  Selinux is running in
"Permissive" mode.


unknown_host login: root
Password:

Login incorrect
Unknown_host login: root
Password:

Last login: Mon Mar 17 21:45:52 GMT 2008 on ttyS0
root@hapWibbSc3:/root>=20


Here are excerpts from the necessary files:

/var/log/secure
----------------------

Mar 17 21:45:45 unknown sshd[1087]: Server listening on 0.0.0.0 port 22.
Mar 17 21:45:49 unknown login[2103]: FAILED LOGIN (1) on 'ttyS0' FOR
`root', System error
Mar 17 21:45:52 unknown login[2103]: pam_unix(login:session): session
opened for user root by LOGIN(uid=3D0)
Mar 17 21:45:52 unknown login[2951]: ROOT LOGIN  on 'ttyS0'



/var/log/messages/
----------------------------

Mar 17 21:45:49 unknown kernel: SELinux: initialized (dev dm-5, type
ext3), uses xattr
Mar 17 21:45:49 unknown kernel: SELinux: initialized (dev tmpfs, type
tmpfs), uses transition SIDs
Mar 17 21:45:49 unknown kernel: SELinux: initialized (dev tmpfs, type
tmpfs), uses transition SIDs
Mar 17 21:45:49 unknown kernel: audit(1205790341.507:8): avc:  denied  {
read } for  pid=3D743 comm=3D"pam_console_app" name=3D"mnt" dev=3Ddm-3 =
ino=3D47105
scontext=3Dsystem_u:system_r:pam_console_t:s0
tcontext=3Dsystem_u:object_r:file_t:s0 tclass=3Ddir


/var/log/dmesg
----------------------

audit(1205790341.507:8): avc:  denied  { read } for  pid=3D743
comm=3D"pam_console_app" name=3D"mnt" dev=3Ddm-3 ino=3D47105
scontext=3Dsystem_u:system_r:pam_console_t:s0
tcontext=3Dsystem_u:object_r:file_t:s0 tclass=3Ddir=20



-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
Sent: Monday, March 17, 2008 7:22 AM
To: Hasan Rezaul-CHR010
Cc: SE Linux
Subject: Re: First Attempt at root login on console always FAILS ??


On Fri, 2008-03-14 at 18:15 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
>=20
> I am getting an irritating problem on my Linux card (running selinux=20
> in permissive mode), that I didn't use to see before, and am not sure=20
> whats causing it :
>=20
> When I reset my Linux Card, once it boots up, and I get the login=20
> prompt, my first attempt at logging in as root on the console, ALWAYS=20
> fails ! My second attempt and afterwards ALWAYS succeeds !
>=20
> unknown host login: root
> password: root
> Login Failure
> unknown host login: root
> Password: root
> root@unknown host#
>=20
>=20
>=20
> This didn't used to happen before, and I am not sure what's causing=20
> it. I do know that if I disable selinux, the problem goes away !  I am

> guessing the problem is somewhere in between PAM and SELinux. Any=20
> suggestions on what may be causing it ?  I have versions:
>=20
> checkpolicy     1.34.1=20
> libselinux         1.34.7=20
> libsemanage     1.10.3=20
> libsepol            1.16.1=20
> policycoreutils  1.34.6
>=20
>=20
> Contents of  /etc/pam.d/login file
> ------------------------------------------------
>=20
> # Begin /etc/pam.d/login=20
> auth        required       pam_tally.so onerr=3Dfail deny=3D3
> unlock_time=3D300=20
> auth        requisite      pam_securetty.so=20
> auth        requisite      pam_nologin.so=20
> auth        required       pam_env.so=20
> auth        required       pam_unix.so=20
> account     required       pam_tally.so onerr=3Dfail=20
> account     required       pam_access.so=20
> account     required       pam_unix.so=20
> # pam_selinux.so close should be the first session rule=20
> session     required       pam_selinux.so close=20
> session     required       pam_loginuid.so=20
> session     required       pam_motd.so=20
> session     required       pam_limits.so=20
> session     optional       pam_mail.so     dir=3D/var/mail standard=20
> session     optional       pam_lastlog.so=20
> session     required       pam_unix.so=20
> # pam_selinux.so open should only be followed by sessions to be=20
> executed in the user context
> session     required       pam_selinux.so open=20
> # End /etc/pam.d/login

The pam_selinux entries look ok, assuming the version of pam_selinux you
are using actually supports the close/open arguments.  The rest of your
pam config though is rather different from the stock Fedora one.

Do you get any output in /var/log/secure or elsewhere that identifies
what pam module is encountering an error?

If not, can you comment out or make optional some of the pam modules to
help identify where the failure is occurring, e.g. pam_tally and
pam_access?=20

--
Stephen Smalley
National Security Agency


------_=_NextPart_001_01C8887B.99D08A2A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: First Attempt at root login on console always FAILS =
??</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi Stephen &amp; =
Dan,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">From the /var/log/ =
files, I am not sure what pam module is having problems ?!?&nbsp; All I =
get, is a &quot;System error&quot; in the /var/log/<B>secure</B> file =
!</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">So I reset the =
card, when I try to login the first time on the console as root, I get =
&quot;Login incorrect&quot;, and the second time, the login is =
successful. This is 100% reproducible.&nbsp; Selinux is running in =
&quot;Permissive&quot; mode.</FONT></SPAN></P>
<BR>

<P><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 FACE=3D"Arial">unknown_host =
login: root</FONT></B></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 =
FACE=3D"Arial">Password:</FONT></B></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 FACE=3D"Arial">Login =
incorrect</FONT></B></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 FACE=3D"Arial">Unknown_host =
login: root</FONT></B></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 =
FACE=3D"Arial">Password:</FONT></B></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 FACE=3D"Arial">Last login: Mon =
Mar 17 21:45:52 GMT 2008 on ttyS0</FONT></B></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc3:/root&gt; </FONT></B></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Here are excerpts =
from the necessary files:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">/var/log/secure<U></U></FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">----------------------</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:45 =
unknown sshd[1087]: Server listening on 0.0.0.0 port 22.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:49 =
unknown login[2103]: FAILED LOGIN (1) on 'ttyS0' FOR `root', System =
error</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:52 =
unknown login[2103]: pam_unix(login:session): session opened for user =
root by LOGIN(uid=3D0)</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:52 =
unknown login[2951]: ROOT LOGIN&nbsp; on 'ttyS0'</FONT></SPAN>
</P>
<BR>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">/var/log/messages/</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">----------------------------</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:49 =
unknown kernel: SELinux: initialized (dev dm-5, type ext3), uses =
xattr</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:49 =
unknown kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses =
transition SIDs</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:49 =
unknown kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses =
transition SIDs</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Mar 17 21:45:49 =
unknown kernel: audit(1205790341.507:8): avc:&nbsp; denied&nbsp; { read =
} for&nbsp; pid=3D743 comm=3D&quot;pam_console_app&quot; =
name=3D&quot;mnt&quot; dev=3Ddm-3 ino=3D47105 =
scontext=3Dsystem_u:system_r:pam_console_t:s0 =
tcontext=3Dsystem_u:object_r:file_t:s0 tclass=3Ddir</FONT></SPAN></P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">/var/log/dmesg</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">----------------------</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">audit(1205790341.507:8): avc:&nbsp; denied&nbsp; { read } =
for&nbsp; pid=3D743 comm=3D&quot;pam_console_app&quot; =
name=3D&quot;mnt&quot; dev=3Ddm-3 ino=3D47105 =
scontext=3Dsystem_u:system_r:pam_console_t:s0 =
tcontext=3Dsystem_u:object_r:file_t:s0 tclass=3Ddir </FONT></SPAN></P>
<BR>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">-----Original =
Message-----</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">From: Stephen =
Smalley [</FONT></SPAN><A HREF=3D"mailto:sds@tycho.nsa.gov"><SPAN =
LANG=3D"en-us"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">mailto:sds@tycho.nsa.gov</FONT></U></SPAN></A><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">] </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Sent: Monday, =
March 17, 2008 7:22 AM</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">To: Hasan =
Rezaul-CHR010</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Cc: SE =
Linux</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Subject: Re: =
First Attempt at root login on console always FAILS ??</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">On Fri, 2008-03-14 =
at 18:15 -0400, Hasan Rezaul-CHR010 wrote:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Hi =
All,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; I am getting =
an irritating problem on my Linux card (running selinux </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; in =
permissive mode), that I didn&#8217;t use to see before, and am not sure =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; whats =
causing it :</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; When I reset =
my Linux Card, once it boots up, and I get the login </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; prompt, my =
first attempt at logging in as root on the console, ALWAYS =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; fails ! My =
second attempt and afterwards ALWAYS succeeds !</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; unknown host =
login: root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; password: =
root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Login =
Failure</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; unknown host =
login: root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Password: =
root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; root@unknown =
host#</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; This =
didn&#8217;t used to happen before, and I am not sure what's causing =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; it. I do =
know that if I disable selinux, the problem goes away !&nbsp; I am =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; guessing the =
problem is somewhere in between PAM and SELinux. Any </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; suggestions =
on what may be causing it ?&nbsp; I have versions:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
checkpolicy&nbsp;&nbsp;&nbsp;&nbsp; 1.34.1 </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
libselinux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.34.7 =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
libsemanage&nbsp;&nbsp;&nbsp;&nbsp; 1.10.3 </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
libsepol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 1.16.1 </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
policycoreutils&nbsp; 1.34.6</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Contents =
of&nbsp; /etc/pam.d/login file</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
------------------------------------------------</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; # Begin =
/etc/pam.d/login </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_tally.so onerr=3Dfail =
deny=3D3</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
unlock_time=3D300 </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
requisite&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_securetty.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
requisite&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_nologin.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_env.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_unix.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
account&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_tally.so onerr=3Dfail =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
account&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_access.so =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
account&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_unix.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; # =
pam_selinux.so close should be the first session rule </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_selinux.so close =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_loginuid.so =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_motd.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_limits.so =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
optional&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pam_mail.so&nbsp;&nbsp;&nbsp;&nbsp; dir=3D/var/mail standard =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
optional&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_lastlog.so =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_unix.so </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; # =
pam_selinux.so open should only be followed by sessions to be =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; executed in =
the user context</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_selinux.so open =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; # End =
/etc/pam.d/login</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">The pam_selinux =
entries look ok, assuming the version of pam_selinux you are using =
actually supports the close/open arguments.&nbsp; The rest of your pam =
config though is rather different from the stock Fedora =
one.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Do you get any =
output in /var/log/secure or elsewhere that identifies what pam module =
is encountering an error?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">If not, can you =
comment out or make optional some of the pam modules to help identify =
where the failure is occurring, e.g. pam_tally and pam_access? =
</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">--</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Stephen =
Smalley</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">National Security =
Agency</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8887B.99D08A2A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
