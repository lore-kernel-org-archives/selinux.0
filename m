Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72E1ErT012386
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:01:16 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72E0eXV020831
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:00:41 GMT
Subject: Re: lkm rootkitted, or issue with selinux 2.6.7 kernel?
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1091452021.23449.31.camel@moss-spartans.epoch.ncsc.mil>
References: <20040801124138.GA15205@lkcl.net>
	 <1091452021.23449.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 02 Aug 2004 16:01:21 +0200
Message-Id: <1091455281.28925.14.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> I have no direct knowledge here, but I have seen discussions on various
> lists indicating that chkrootkit is buggy/racy at least with respect to
> Linux 2.6, yielding false positives.  

Yes, IIRC chkrootkit doesn't understand new threads, listing these as
hidden processes. (they used to be in /proc, now they are
in /proc/parentpid/threads or so)

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?      //\
  Wer keine Zeit mehr mit echten Freunden verbringt, der wird bald   V_/_
          sein Gleichgewicht verlieren. --- Michael Levine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
