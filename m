Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA28093
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 13:07:25 -0400 (EDT)
From: jbyrd@vspacegroup.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA27951
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 17:05:47 GMT
Received: from sprout.phpwebhosting.com ([216.218.184.226])
        by jazzband.ncsc.mil  with SMTP id RAA27943 for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 17:05:46 GMT
Message-ID: <011b01c24547$639d8f60$0100a8c0@vspaceprs2>
To: <selinux@tycho.nsa.gov>
Subject: Re: Needing some direction
Date: Fri, 16 Aug 2002 13:07:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> If your kernel build then succeeds (i.e. 'err' only contains warnings, no
> actual errors), then do a 'make modules' in lsm-2.4.  Then jump down to
> the step-by-step 'INSTALLING' instructions and follow them.  Given your
> difficulties, I wouldn't recommend doing the quickinstall - just use the
> step-by-step instructions so that we can see exactly where things fail.

Will do ...
so far only 1 warning and no errors in the build. Once completed, I'll go
for the step-by-step install and see what happens.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
