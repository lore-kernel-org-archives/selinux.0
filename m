Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9BKwmrT007818
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 16:58:49 -0400 (EDT)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9BKwkWH005162
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 20:58:47 GMT
Subject: PostgreSQL Fun
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4AFD5.A6F3AB70"
Date: Mon, 11 Oct 2004 17:02:43 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B1DAEC@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4AFD5.A6F3AB70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I've been having a ton of fun lately trying to get PostgreSQL running =
using the Strict policy. I have a Fedora Core 2 system that has been =
updated to run the latest selinux strict policy (1.17.30-1). Most of the =
rest of the services run ok (MySQL still isn't happy either, but that's =
next), but PostgreSQL refuses to start. After running audit2allow, it =
generates the following recommendations:

allow postgresql_t chkpwd_exec_t:file { execute };
allow postgresql_t file_t:dir { search };
allow postgresql_t security_t:dir { search };
allow postgresql_t shadow_t:file { read };

Those don't work for various reasons. The main reason is that the last =
line causes checkpolicy to choke on the following directive:

neverallow { domain -auth -auth_write } shadow_t:file ~getattr;

A discussion I found () suggests this is due to the requirement to limit =
access to /etc/shadow. I looked at my logs and found the top two errors =
lead me to believe it is a PAM issue with the following command in =
/etc/init.d/postgresql:

su -l postgres -c "/usr/bin/pg_ctl  -D $PGDATA -p /usr/bin/postmaster -o =
'-p ${PGPORT} ${PGOPTS}' start  > /dev/null 2>&1" < /dev/null

The offending lines are:
Oct 11 16:21:47 baal kernel: audit(1097526107.360:0): avc:  denied  { =
search } for  pid=3D26072 exe=3D/bin/su dev=3Dselinuxfs ino=3D1005 =
scontext=3Droot:system_r:postgresql_t =
tcontext=3Dsystem_u:object_r:security_t tclass=3Ddir
Oct 11 16:21:47 baal PAM-rootok[26072]: pam_check_access failed, user =
does not have proper access: root:system_r:postgresql_t

Has anyone else looked at this issue? Is it possibly a bugzilla issue to =
raise? I have pam-0.77-56 installed on my system. I imagine the problem =
doesn't show up in FC3test3 since the targeted policy runs postgres =
unconfined (haven't tested that theory though).  Any help I can get on =
this issue (even if it is just a link to a solution or ongoing =
discussion somewhere) would be greatly appreciated. I have found nothing =
so far on this issue.

Thanks!
Alex Ackerman
http://www.darkhonor.com




------_=_NextPart_001_01C4AFD5.A6F3AB70
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.6944.0">
<TITLE>PostgreSQL Fun</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I've been having a ton of fun lately trying to get =
PostgreSQL running using the Strict policy. I have a Fedora Core 2 =
system that has been updated to run the latest selinux strict policy =
(1.17.30-1). Most of the rest of the services run ok (MySQL still isn't =
happy either, but that's next), but PostgreSQL refuses to start. After =
running audit2allow, it generates the following recommendations:<BR>
<BR>
allow postgresql_t chkpwd_exec_t:file { execute };<BR>
allow postgresql_t file_t:dir { search };<BR>
allow postgresql_t security_t:dir { search };<BR>
allow postgresql_t shadow_t:file { read };<BR>
<BR>
Those don't work for various reasons. The main reason is that the last =
line causes checkpolicy to choke on the following directive:<BR>
<BR>
neverallow { domain -auth -auth_write } shadow_t:file ~getattr;<BR>
<BR>
A discussion I found () suggests this is due to the requirement to limit =
access to /etc/shadow. I looked at my logs and found the top two errors =
lead me to believe it is a PAM issue with the following command in =
/etc/init.d/postgresql:<BR>
<BR>
su -l postgres -c &quot;/usr/bin/pg_ctl&nbsp; -D $PGDATA -p =
/usr/bin/postmaster -o '-p ${PGPORT} ${PGOPTS}' start&nbsp; &gt; =
/dev/null 2&gt;&amp;1&quot; &lt; /dev/null<BR>
<BR>
The offending lines are:<BR>
Oct 11 16:21:47 baal kernel: audit(1097526107.360:0): avc:&nbsp; =
denied&nbsp; { search } for&nbsp; pid=3D26072 exe=3D/bin/su =
dev=3Dselinuxfs ino=3D1005 scontext=3Droot:system_r:postgresql_t =
tcontext=3Dsystem_u:object_r:security_t tclass=3Ddir<BR>
Oct 11 16:21:47 baal PAM-rootok[26072]: pam_check_access failed, user =
does not have proper access: root:system_r:postgresql_t<BR>
<BR>
Has anyone else looked at this issue? Is it possibly a bugzilla issue to =
raise? I have pam-0.77-56 installed on my system. I imagine the problem =
doesn't show up in FC3test3 since the targeted policy runs postgres =
unconfined (haven't tested that theory though).&nbsp; Any help I can get =
on this issue (even if it is just a link to a solution or ongoing =
discussion somewhere) would be greatly appreciated. I have found nothing =
so far on this issue.<BR>
<BR>
Thanks!<BR>
Alex Ackerman<BR>
<A HREF=3D"http://www.darkhonor.com">http://www.darkhonor.com</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4AFD5.A6F3AB70--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
