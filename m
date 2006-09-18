Subject: Re: awk, isatty(), libc and ioctl()
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <1158598780.18951.254.camel@moss-spartans.epoch.ncsc.mil>
References: <1158185710.1594.94.camel@wintermute.xmldesign.de>
	 <200609162208.13198.russell@coker.com.au>
	 <1158410236.10929.8.camel@wintermute.xmldesign.de>
	 <1158598780.18951.254.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 19:41:44 +0200
Message-Id: <1158601304.14335.12.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,
So what should we do - add the missing dontaudit/allow rules, provide
patches for awk/perl (and likely others) to not use isatty() on regular
files but stat() first, or ask the glibc maintainers to modify isatty()?

best regards,
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
