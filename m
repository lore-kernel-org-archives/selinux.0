Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA26895
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 11:09:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA09427
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:09:03 GMT
Received: from web40205.mail.yahoo.com (web40205.mail.yahoo.com [66.218.78.66])
	by jazzswing.ncsc.mil  with SMTP id PAA09421
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:09:02 GMT
Message-ID: <20020627150927.32672.qmail@web40205.mail.yahoo.com>
Date: Thu, 27 Jun 2002 08:09:27 -0700 (PDT)
From: Michael Nyika <nyix@yahoo.com>
Subject: RE: System.te ?
To: Stephen Smalley <sds@tislabs.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: "'Michael Nyika'" <nyix@yahoo.com>, selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0206270938330.1331-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Again. Question: 

If Sysadm_t and user_t are domains whose definitions
exist in admin.te and user.te in policy/domain, then
why isnt there ( i presume) a file called system.te to
define default behaviour for the system_t domain for
system processes, in the same directory (or other
dir)?


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
