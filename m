Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA27527
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 20:25:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA17993
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 00:25:09 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id AAA17989
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 00:25:07 GMT
Subject: Re: selinux question
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20020723131932.EE9B4116C@lyta.coker.com.au>
References: <20020717025148.GA25379@snoopy.apana.org.au>
	<20020723131932.EE9B4116C@lyta.coker.com.au>
Content-Type: text/plain
Date: 24 Jul 2002 10:25:47 +1000
Message-Id: <1027470348.8943.77.camel@scrooge>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2002-07-23 at 23:19, Russell Coker wrote:
> I've run into a similar issue, some scripts such as dh_installdocs call "cp 
> -a" which tries to do such a chsid and fails.  I think that "cp -a" should 
> not preserve sids to avoid breaking compatability in such situations.  
> Generally when "cp -a" is called you don't even want to preserve the UID, 
> just the mode.

I have to ask why does dh_installdocs use cp -a, and not cp -dR.

It doesn't need to copy ownership or group, or permissions, as these
will be reset later on by dh_fixperms.

It doesn't want to copy SIDs, as even if (or when) tar supported this, I
don't think you want Debian packages to come supplied with built in
SIDs.
-- 
Brian May <bam@snoopy.apana.org.au>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
