Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA04389
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 11:08:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA28514
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 16:04:46 GMT
Received: from babylon.swishmail.com (babylon.swishmail.com [209.10.110.2])
	by jazzswing.ncsc.mil  with SMTP id QAA28484
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 16:04:44 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: RE: Core policy
Date: Wed, 26 Feb 2003 11:08:39 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMOEDLCDAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.LNX.4.33.0302260836250.3682-100000@vox.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There are probably as many definitions of "core" as there are people
actively working on SELinux.

I've put a SELinux box into a secured network that required that the box
pass a vulnerability/lockdown test.  Since the box acts as a server where
the only visible application is the one we put on it, my "core" is certainly
minimal!  It sounds similar to the other "hardened" systems people are
reporting.

The only "optional" component I have is sshd. I have no ftpd, telnetd, mail,
printing etc.  Since it took me a lot of trial-and-error to see which policy
files I could safely exclude, I certainly support the idea of a cleaner
hierarchy and a better notion of "linkage" between policies (try removing
crond and working backwards to clean up the errors).

However, for 95% of you (the other 19 active people?) I doubt if that
minimal a policy is any use.  Even so, I think that approach that the "core"
should only get the system booted is valid.  I'm thinking that "CPU+DISK"
makes a core. +NET makes a usable core, after that it's service-by-service
until you get to a full-blown installation running apache etc.

If "core" is the minimal system to get an experimenter up and running, then
it's already too big for me, but I managed to experiment with the "full" set
of policies.

So, does anyone have a list that might support only the "CPU+DISK" policy
list?

Leslie French
Semandex Networks Inc.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
