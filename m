Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VIhNHa004871
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 14:43:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6VIhMDW018614
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:43:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6VIhLeN018611 for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:43:21 GMT
Subject: Re: Error while installing:
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Hariharan Gopalan <hari@sapta.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <MBEOIIDPALLENBNPLKLCIEPLHOAA.hari@sapta.com>
References: <MBEOIIDPALLENBNPLKLCIEPLHOAA.hari@sapta.com>
Content-Type: text/plain
Message-Id: <1059677000.1052.260.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 31 Jul 2003 14:43:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-07-31 at 14:38, Hariharan Gopalan wrote:
> I am getting this error while making quickinstall:
> 
> It looks like the policy for inetd. My system uses xinetd, and so I did
> notmove the inetd.te from unused, but I could not find a xinted.te...

You still want to move up inetd.te when using xinetd.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
