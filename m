Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JL3aRb014247
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 17:03:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JL3XAR012645
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 21:03:33 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4JL3WHn012543 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 21:03:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Date: Thu, 20 May 2004 07:02:24 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org
References: <20040519091454.GL7348@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net>
In-Reply-To: <20040519200057.GD24597@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405200702.24155.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 May 2004 06:00, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  it's worth double-checking, and russell would be able to confirm:
>  on an SELinux system, system_u _can_ never be a valid username...

Correct.

>  the thing is that from what i gather, SELinux actually checks things
>  via the username that it sees cron jobs create.

It checks that the type of the crontab file is an entry-point for the domain 
used for executing cron jobs.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
