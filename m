Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2ABbM0e001451
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 07:37:22 -0400
Received: from web90404.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2ABbKSA013091
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 11:37:20 GMT
Date: Mon, 10 Mar 2008 04:36:42 -0700 (PDT)
From: kihamba nengo <knengo@yahoo.com>
Subject: Problem compiling policy on Fedora 5.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-150549449-1205149002=:73722"
Message-ID: <548571.73722.qm@web90404.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-150549449-1205149002=:73722
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi, 
When i run make in the policy directory, i get the error below.How can i solve this problem? I am running Fedora 5, checkpolicy-1.32-1.

Compiling refpolicy policy.21
WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set correctly?

/usr/bin/checkpolicy policy.conf -o policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
tmp/rolemap.conf:1017:ERROR 'syntax error' at token 'ntfs-3g' on line 2430160:
genfscon ntfs-3g / system_u:object_r:dosfs_t
genfscon msdos / system_u:object_r:dosfs_t
checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.21] Error 1


       
---------------------------------
Never miss a thing.   Make Yahoo your homepage.
--0-150549449-1205149002=:73722
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hi, <br>When i run make in the policy directory, i get the error below.How can i solve this problem? I am running Fedora 5, checkpolicy-1.32-1.<br><br>Compiling refpolicy policy.21<br>WARNING: Policy version mismatch!&nbsp; Is your OUTPUT_POLICY set correctly?<br><br>/usr/bin/checkpolicy policy.conf -o policy.21<br>/usr/bin/checkpolicy:&nbsp; loading policy configuration from policy.conf<br>tmp/rolemap.conf:1017:ERROR 'syntax error' at token 'ntfs-3g' on line 2430160:<br>genfscon ntfs-3g / system_u:object_r:dosfs_t<br>genfscon msdos / system_u:object_r:dosfs_t<br>checkpolicy:&nbsp; error(s) encountered while parsing configuration<br>make: *** [policy.21] Error 1<br><br><p>&#32;



      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>


--0-150549449-1205149002=:73722--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
