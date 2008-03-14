MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88620.EF282B6A"
Subject: First Attempt at root login on console always FAILS ??
Date: Fri, 14 Mar 2008 18:15:38 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0472B132@de01exm68.ds.mot.com>
In-Reply-To: <1205525125.22912.96.camel@moss-spartans.epoch.ncsc.mil>
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com> <47D9BBEE.5090105@redhat.com> <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil> <47DA9A3C.3080802@redhat.com>  <47DAD18F.5000309@tycho.nsa.gov> <1205525125.22912.96.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C88620.EF282B6A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am getting an irritating problem on my Linux card (running selinux in
permissive mode), that I didn't use to see before, and am not sure whats
causing it :

When I reset my Linux Card, once it boots up, and I get the login
prompt, my first attempt at logging in as root on the console, ALWAYS
fails ! My second attempt and afterwards ALWAYS succeeds !

unknown host login: root
password: root
Login Failure
unknown host login: root
Password: root
root@unknown host#



This didn't used to happen before, and I am not sure what's causing it.
I do know that if I disable selinux, the problem goes away !  I am
guessing the problem is somewhere in between PAM and SELinux. Any
suggestions on what may be causing it ?  I have versions:

checkpolicy     1.34.1
libselinux         1.34.7
libsemanage     1.10.3
libsepol            1.16.1
policycoreutils  1.34.6


Contents of  /etc/pam.d/login file
------------------------------------------------

# Begin /etc/pam.d/login
auth        required       pam_tally.so onerr=3Dfail deny=3D3
unlock_time=3D300
auth        requisite      pam_securetty.so
auth        requisite      pam_nologin.so
auth        required       pam_env.so
auth        required       pam_unix.so
account     required       pam_tally.so onerr=3Dfail
account     required       pam_access.so
account     required       pam_unix.so
# pam_selinux.so close should be the first session rule
session     required       pam_selinux.so close
session     required       pam_loginuid.so
session     required       pam_motd.so
session     required       pam_limits.so
session     optional       pam_mail.so     dir=3D/var/mail standard
session     optional       pam_lastlog.so
session     required       pam_unix.so
# pam_selinux.so open should only be followed by sessions to be executed
in the
user context
session     required       pam_selinux.so open
# End /etc/pam.d/login

------_=_NextPart_001_01C88620.EF282B6A
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
<TITLE>First Attempt at root login on console always FAILS ??</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi =
All,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I am getting an =
irritating problem on my Linux card (running selinux in permissive =
mode), that I didn&#8217;t use to see before, and am not sure whats =
causing it :</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">When I reset my =
Linux Card, once it boots up, and I get the login prompt, my<B> first =
attempt at logging in as root on the console, ALWAYS fails !</B> My =
second attempt and afterwards ALWAYS succeeds !</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">unknown host login: root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">password: root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">Login Failure</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">unknown host login: root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">Password: root</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">root@unknown host#</FONT></SPAN>
</P>
<BR>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">This didn&#8217;t =
used to happen before, and I am not sure what's causing it. I do know =
that if I disable selinux, the problem goes away !&nbsp; I am guessing =
the problem is somewhere in between PAM and SELinux. Any suggestions on =
what may be causing it ?&nbsp; I have versions:</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">checkpolicy&nbsp;&nbsp;&nbsp;&nbsp; 1.34.1</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">libselinux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 1.34.7</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">libsemanage&nbsp;&nbsp;&nbsp;&nbsp; 1.10.3</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">libsepol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 1.16.1</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">policycoreutils&nbsp; 1.34.6</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Contents =
of&nbsp;</FONT><B> <FONT SIZE=3D2 =
FACE=3D"Arial">/etc/pam.d/login</FONT></B> <FONT SIZE=3D2 =
FACE=3D"Arial">file</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">------------------------------------------------</FONT></S=
PAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial"># Begin /etc/pam.d/login</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_tally.so onerr=3Dfail =
deny=3D3 unlock_time=3D300</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
requisite&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_securetty.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
requisite&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_nologin.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_env.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_unix.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">account&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_tally.so =
onerr=3Dfail</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">account&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_access.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">account&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_unix.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial"># pam_selinux.so close should be the first session =
rule</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_selinux.so =
close</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pam_loginuid.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_motd.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_limits.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
optional&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pam_mail.so&nbsp;&nbsp;&nbsp;&nbsp; dir=3D/var/mail =
standard</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
optional&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pam_lastlog.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_unix.so</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial"># pam_selinux.so open should only be followed by sessions =
to be executed in the</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">user context</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">session&nbsp;&nbsp;&nbsp;&nbsp; =
required&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pam_selinux.so =
open</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial"># End /etc/pam.d/login</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C88620.EF282B6A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
