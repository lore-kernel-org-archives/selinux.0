Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA29950
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 16:28:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA07893
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 21:26:01 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA07885 for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 21:25:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Joshua Brindle" <JBrindle@snu.edu>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux distro building
Date: Tue, 12 Nov 2002 19:45:48 +0100
References: <sdd0dd07.038@atlas.snu.edu>
In-Reply-To: <sdd0dd07.038@atlas.snu.edu>
MIME-Version: 1.0
Message-Id: <200211121945.48259.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Nov 2002 17:50, Joshua Brindle wrote:
> 1) it installs to /usr/local/selinux which is unacceptable, it needs to
> go to /usr/selinux (thats easily taken care of by patches to the
> Makefiles which i already did)

I think that autoconf would be good for this.  Also perhaps my script for 
extracting header files from the kernel patch (instead of from a kernel 
source tree) would be a good addition to the distribution.

> 2) when compiling the selinux archive it needs libsecure to already be
> installed (and to have copied the .h files from the lsm kernel) before
> the policy compiler can be built. This is a problem because the ports
> system wants to compile everything, install it to a fake root so that it
> can enumerate the files for uninstallation, then copy them to the file
> system.

I think it would be good to have the selinux-small split into two parts, one 
for the header files and library code for compiling applications, and the 
other for policy, run_init, etc.

> it seems to me that the entire archive package desperatly needs a
> configure system so that it will be a little more flexible. What is your
> opinion on this?

I agree.  Perhaps if I had posted patches here in the past rather than just 
talking about it then something would have happened.  I suggest that you post 
your patches here.

> Also, i haven't looked at the debian builds since i don't have any
> debian machines but how did you handle these problems, or did you?

Well I've got things basically solved for my use, but it is rather ugly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
