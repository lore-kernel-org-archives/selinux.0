Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i39C42Rb024095
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 08:04:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i39C41mw011807
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 12:04:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i39C404w011804 for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 12:04:00 GMT
Subject: Re: Fedora Core 2 Test 2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nagray@austin.rr.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Jeremy Katz <katzj@redhat.com>
In-Reply-To: <1081459652.24857.33.camel@hawaii.efficax.net>
References: <1081459652.24857.33.camel@hawaii.efficax.net>
Content-Type: text/plain
Message-Id: <1081512224.8524.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Apr 2004 08:03:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-08 at 17:27, Nick Gray wrote:
> 1: I was a little surprised to find that SELinux was installed by
> default and that there didn't seem to be a way to avoid it. This said,
> the kernel did come up properly and the system booted.

You can disable it on the firewall setup screen, but it is easy to miss
the checkbox.  I think that they plan on making it more distinctive, and
they might end up disabling it by default for the final release, forcing
people to explicitly enable it if they want SELinux, as things are still
rather rough.

> 2: I was a little bit more than surprised to find that the policy src
> and policy tools (i.e. checkpolicy) were not on the system anywhere.
> They also seem to be missing from the DVD ISO that I downloaded.

I was also surprised by the initial absence of checkpolicy and
policy-sources, but from a strict dependency perspective, it does make
sense - you only need the binary policy and policycoreutils for basic
operation of the system.  RH wants to support minimal installs, where
policy-sources and its dependencies may be excessive.  However, I did
mention to Dan that I thought that checkpolicy and policy-sources should
be installed by default unless you explicitly select a minimal install. 
I installed them after the fact from the CD ISOs; you can always install
the latest versions via yum.  

> 3: Not to be daunted by this, I downloaded the New release and installed
> it. My first attempt has gone down in flames. I get a system which trys
> to load X and gives me a couple of warnings in the top left portion of
> the screen (which I cant read) and hangs.

Try fixfiles relabel from single-user mode.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
