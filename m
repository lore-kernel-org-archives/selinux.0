Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i390BURb021958
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 20:11:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i390BTmw018962
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 00:11:30 GMT
Received: from zaphod.crypt.gen.nz (port-203-99-29-49.jet.net.nz [203.99.29.49])
        by jazzband.ncsc.mil  with ESMTP id i390BS4w018954 for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 00:11:29 GMT
Received: from www (zaphod.crypt.gen.nz [192.168.1.5])
	by zaphod.crypt.gen.nz (Postfix) with SMTP id E3200FE9D
	for <selinux@tycho.nsa.gov>; Fri,  9 Apr 2004 12:11:13 +1200 (NZST)
Message-ID: <32926.192.168.1.3.1081469476.squirrel@www>
In-Reply-To: <1081459652.24857.33.camel@hawaii.efficax.net>
References: <1081459652.24857.33.camel@hawaii.efficax.net>
Date: Fri, 9 Apr 2004 12:11:16 +1200 (NZST)
Subject: Re: Fedora Core 2 Test 2
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "SE Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Gray said:
> What is the strategy with Fedora Core 2 Test 2. I loaded it on my test
> server in order to make a first stab at transitioning to a 2.6 Kernel.
>
> My observations so far:
>
> 1: I was a little surprised to find that SELinux was installed by
> default and that there didn't seem to be a way to avoid it. This said,
> the kernel did come up properly and the system booted.
> [snip]

I haven't tried FC2t2 yet so I can't comment on the details, but the
feedback and hits I'm seeing against the FAQ page indicate many people are
having problems. By far the most common google query is "disable selinux",
and the hit rate has quadrulped since FC2t2 came out. A few people have
commented that the desktop doesn't come up similar to Nick's comments.

I'm advising people that if they're not interested in SELinux or are
installing a desktop for their granny then disable with selinux=0. If
they're interested in SELinux, then go with enforcing=0 and be prepared
for some messages and maybe enable enforcing later.

I too would like to hear from the FC2 developers (Russell?) about what the
install options will be (there really needs to be one), and if the
policies will be clean enough for an install into enforcing mode.

I'm thinking of writing an introductory document for Fedora users new to
SELinux about what to do during and after installation ( a bit like Faye's
HOWTO but shorter and at a more basic level ) to help people when the FC2
release comes out. So the strategy for the release would be greatly
appreciated.

Kerry

-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
