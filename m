Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCKBeRb010846
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 15:11:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBCKBdAH023214
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 20:11:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBCKBdZA023211 for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 20:11:39 GMT
Subject: RE: syslog()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
In-Reply-To: <00bd01c3c0e9$2c16a3a0$9a01a8c0@TECRA>
References: <00bd01c3c0e9$2c16a3a0$9a01a8c0@TECRA>
Content-Type: text/plain
Message-Id: <1071259896.14716.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Dec 2003 15:11:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-12 at 14:50, Ed Street wrote:
> I should have said this is a bash mod.  Logs keyboard activity to
> syslog()for testing purposes.  All I need is to append to the syslog and
> disallow any thing else.  Question is, is there anyway to allow an append

The log files aren't directly modified by the user; the message is sent
to syslogd via /dev/log.  Domains that have the 'privlog' attribute are
allowed to communicate with syslogd via /dev/log; see the corresponding
allow rules in syslogd.te.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
