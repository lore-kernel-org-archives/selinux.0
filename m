Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38LRaRb021211
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:27:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i38LRZmw012448
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 21:27:35 GMT
Received: from hawaii.efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
        by jazzband.ncsc.mil  with ESMTP id i38LRY4w012441 for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 21:27:35 GMT
Received: from hawaii.efficax.net (localhost.localdomain [127.0.0.1])
	by hawaii.efficax.net (8.12.10/8.12.10) with ESMTP id i38LRY02025901
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 16:27:34 -0500
Received: (from nick@localhost)
	by hawaii.efficax.net (8.12.10/8.12.10/Submit) id i38LRXWY025899
	for selinux@tycho.nsa.gov; Thu, 8 Apr 2004 16:27:33 -0500
Subject: Fedora Core 2 Test 2
From: Nick Gray <nagray@austin.rr.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1081459652.24857.33.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 16:27:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the strategy with Fedora Core 2 Test 2. I loaded it on my test
server in order to make a first stab at transitioning to a 2.6 Kernel.

My observations so far:

1: I was a little surprised to find that SELinux was installed by
default and that there didn't seem to be a way to avoid it. This said,
the kernel did come up properly and the system booted.

2: I was a little bit more than surprised to find that the policy src
and policy tools (i.e. checkpolicy) were not on the system anywhere.
They also seem to be missing from the DVD ISO that I downloaded.

3: Not to be daunted by this, I downloaded the New release and installed
it. My first attempt has gone down in flames. I get a system which trys
to load X and gives me a couple of warnings in the top left portion of
the screen (which I cant read) and hangs.

 I am going to make another stab at it and see if I can control the
install a little bit better. Then I will guess making the system come up
in permissive mode and then try re-installing SEL from source.

Another thing I find sort of odd is, I needed to add packages to the
install of SELinux on Core1. I did this by modifying the comps.xml to
create an SELinux group which included:

<packagereq type="mandatory">sharutils</packagereq>
<packagereq type="mandatory">linuxdoc-tools</packagereq>
<packagereq type="mandatory">netpbm-progs</packagereq>
<packagereq type="mandatory">tetex-latex</packagereq>
<packagereq type="mandatory">autoconf213</packagereq>
<packagereq type="mandatory">elfutils-devel</packagereq>
<packagereq type="mandatory">libcroco-devel</packagereq>

On Core2, It looks as if elfutils, and libcroco have been updated but
the DVD ISO is missing the development RPMs. I guess these were not
needed for the SELinux kernel install when the system was building, but
they seem to still be needed for the after installation build of the
system.

I am interested in hearing others experience on this. In particular
anyone who is running core 2 with added users/programs.

I am attempting to setup JBOSS as a daemon. With Core1 at least I was
able to get it running in permissive. I couldn't even do that with
Core2.

Nix

-- 
Nick Gray
Senior Systems Engineer
Bruzenak Inc.
nagray@austin.rr.com
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
