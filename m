Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7I1SaHK027446
	for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2006 21:28:36 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7I1SJhn027784
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 01:28:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id D0FF0C4C084
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 03:28:31 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 23480-05 for <selinux@tycho.nsa.gov>;
	Fri, 18 Aug 2006 03:28:31 +0200 (CEST)
Received: from wintermute.xmldesign.de (p549A043A.dip0.t-ipconnect.de [84.154.4.58])
	by legolas.drinsama.de (Postfix) with ESMTP id 25E75C4C083
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 03:28:30 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 37692234070
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 03:19:33 +0200 (CEST)
Subject: refpoliy issues
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 18 Aug 2006 03:19:32 +0200
Message-Id: <1155863972.7443.36.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Reference policy issues I've come around recently:

- sxid not in role system_r, missing access to /dev
- cron needs to su for certain cronjobs
- semanage writes netfilter_contexts to default_contexts instead of the
files subdir (default contexts is read only for semanage)?
- load_policy tries to contact setrans, but I don't have setrans (found
also no docs on it or source...) - but the rules to search /var/run are
only active when setrans policy was loaded. This probably applies to
other apps as well.
and it tries to make a unix_stream_socket

I don't know much about this one:

kernel: audit(1155735318.128:5897): avc:  denied  { relabelfrom } for
pid=3325 comm="sshd" name="0" dev=devpts ino=2
scontext=system_u:system_r:sshd_t:s0-s0:c0.c255
tcontext=root:object_r:sysadm_devpts_t:s0 tclass=chr_file

on each ssh login.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                Friends are those who reach out for                 //\
                  your hand but touch your heart.                   V_/_
     Mathematik ist die Kunst, verschiedene Dinge mit demselben
                Namen zu belegen. --- Henri Poincaré



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
