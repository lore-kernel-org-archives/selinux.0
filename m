Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBP7ItIi010922
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 02:18:55 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBP7IuFA024594
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 07:18:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: gentoo diff for arpwatch
Date: Sat, 25 Dec 2004 18:18:51 +1100
Cc: petre rodan <kaiowas@gentoo.org>, SELinux <selinux@tycho.nsa.gov>
References: <4198D07B.6070401@gentoo.org> <1100893653.31793.25.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100893653.31793.25.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eRRzBO4RT6qADE4"
Message-Id: <200412251818.54944.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_eRRzBO4RT6qADE4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 20 November 2004 06:47, James Carter <jwcart2@epoch.ncsc.mil>=20
wrote:
> I moved the following rules and put an "ifdef(`arpwatch.te'" around
> them:
> "allow system_mail_t" rules to mta.te
> "allow qmail_inject_t" rules to qmail.te
> "allow allow postfix_local_t" rule to postfix.te

This is not what we want.  Below I have pasted some text from=20
http://www.coker.com.au/selinux/talks/ibmtu-2004/linux21.ppt describing the=
=20
MTA policy (it's not great but it's the best description of MTA policy).

I have attached a patch that makes some changes to make it work with the=20
design of the mta policy.  This makes it work with Postfix, Qmail, Sendmail=
,=20
and any other mta that might be used.  The idea is that you don't have to=20
write policy for every combination of program that sends mail and mta, this=
=20
doesn't scale well as the number of supported mta's increases.

It might be appropriate to move the policy in the ifdef(`arpwatch.te' from=
=20
mta.te into arpwatch.te with an ifdef(`mta.te'.  We probably don't want to=
=20
have an ifdef in mta.te for every daemon that does unexpected things.

Also note that system_mail_t is unable to do anything you might desire with=
 a=20
packet_socket file handle that it inherits.  This would be a bug in=20
arpwatch...

Sorry for the month delay in responding to this.

> I also moved the "allow initrc_t" rules to initrc.te and put
> "ifdef(`distro_gentoo" and "ifdef(`arpwatch.te'" around them.
>
> On Mon, 2004-11-15 at 10:51, petre rodan wrote:
> > Hi,
> >
> > attached you'll find a +15 -5 patch to the arpwatch policy
> >
> > both /var/lib/arpwatch and /var/arpwatch are used by gentoo.
> > etc_t is used when arpwatch_t reads nsswitch.conf, usr_t is needed to
> > read the ethercodes file.
> >
> > the distro_gentoo block is needed because init creates ethX.dat files
> > before the daemon is started.
> >
> > bye,
> > peter

A mail server interacts with most programs on the system.  To alleviate the=
=20
risk of local DOS the program that receives mail from a user runs in it=E2=
=80=99s own=20
domain.

Separate domain for receiving local mail from each user role, such domains =
can=20
not communicate with each other

Mail server also interacts with the rest of the system for local delivery,=
=20
SMTP delivery, and SMTP reception

Mail related attributes:
user_mail_domain for user_mail_t, staff_mail_t, sysadm_mail_t, etc =E2=80=
=93 all the=20
domains used to read the user=E2=80=99s files to send to the local mail ser=
ver

mta_user_agent for domains that are part of an MTA which need to read user=
=20
files for local mail receipt =E2=80=93 executed from user_mail_domain

mta_delivery_agent for MTA domains that deliver mail to the user=E2=80=99s =
home=20
directory

Mail_server_sender for the domain in the MTA which makes outbound port 25=20
connections =E2=80=93 for anti-virus etc

Mail_server_domain for MTA domains that listen on port 25

=2D-=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_eRRzBO4RT6qADE4
Content-Type: text/x-diff;
  charset="utf-8";
  name="arpwatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="arpwatch.diff"

--- /usr/src/se/policy/domains/program/unused/mta.te	2004-12-13 09:55:24.000000000 +1100
+++ domains/program/unused/mta.te	2004-12-25 18:09:46.000000000 +1100
@@ -48,9 +48,13 @@
 allow { system_mail_t mta_user_agent } admin_tty_type:chr_file { read write };
 
 ifdef(`arpwatch.te', `
-allow system_mail_t arpwatch_tmp_t:file rw_file_perms;
-allow system_mail_t arpwatch_t:packet_socket { read write };
+# why is mail delivered to a directory of type arpwatch_data_t?
+allow mta_delivery_agent arpwatch_data_t:dir search;
+allow { system_mail_t mta_user_agent } arpwatch_tmp_t:file rw_file_perms;
+ifdef(`hide_broken_symptoms', `
+dontaudit { system_mail_t mta_user_agent } arpwatch_t:packet_socket { read write };
 ')
+')dnl end if arpwatch.te
 
 allow mta_delivery_agent home_root_t:dir { getattr search };
 
--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-12-03 19:49:24.000000000 +1100
+++ domains/program/unused/postfix.te	2004-12-25 04:53:28.000000000 +1100
@@ -207,9 +209,6 @@
 allow postfix_local_t postfix_public_t:dir search;
 allow postfix_local_t postfix_public_t:sock_file write;
 can_exec(postfix_local_t, shell_exec_t)
-ifdef(`arpwatch.te', `
-allow postfix_local_t arpwatch_data_t:dir { search };
-')
 
 define(`postfix_public_domain',`
 postfix_server_domain($1)
--- /usr/src/se/policy/domains/program/unused/qmail.te	2004-12-03 19:49:24.000000000 +1100
+++ domains/program/unused/qmail.te	2004-11-25 22:38:37.000000000 +1100
@@ -148,10 +148,6 @@
 allow qmail_inject_t sbin_t:dir search;
 role sysadm_r types qmail_inject_t;
 in_user_role(qmail_inject_t)
-ifdef(`arpwatch.te', `
-allow qmail_inject_t arpwatch_tmp_t:file { read write };
-allow qmail_inject_t arpwatch_t:packet_socket { read write };
-')
 
 qmaild_sub_domain(userdomain, qmail_qread, `, mta_user_agent')
 in_user_role(qmail_qread_t)

--Boundary-00=_eRRzBO4RT6qADE4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
