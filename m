Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DMsCrT006669
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 18:54:12 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DMrHHC013994
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 22:53:17 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 828DCC4C092
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 00:54:12 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 19610-06 for <selinux@tycho.nsa.gov>;
	Tue, 14 Sep 2004 00:54:11 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD958FBCF.dip.t-dialin.net [217.88.251.207])
	by legolas.drinsama.de (Postfix) with ESMTP id 71CC1C4C08E
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 00:54:11 +0200 (CEST)
Date: Tue, 14 Sep 2004 00:54:10 +0200
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Subject: atsar system stats
Message-ID: <20040913225410.GB14736@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
"atsar" is a system statistics utility. There is already a file context
defined so it runs in the sysstat_t type, but i added the following
rule to get rid of a warning:

dontaudit sysstat_t staff_home_dir_t:dir { search getattr };

No idea what atsar is trying to do there, but it works fine.

Gruß,
Erich Schubert
-- 
     erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
      Which is worse: ignorance or apathy? Who knows? Who cares?      //\
 Man kann sich auch in Gesellschaft anderer einsam fühlen. Weizsäcker V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
