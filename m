Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA23828
	for <selinux@tycho.nsa.gov>; Mon, 25 Nov 2002 19:59:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA21849
	for <selinux@tycho.nsa.gov>; Tue, 26 Nov 2002 00:57:01 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id AAA21843
	for <selinux@tycho.nsa.gov>; Tue, 26 Nov 2002 00:56:55 GMT
Date: Tue, 26 Nov 2002 12:01:49 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: selinux@tycho.nsa.gov
Subject: Re: Patch for selinux automake
Message-ID: <20021126010149.GA16650@snoopy.apana.org.au>
References: <sde22e24.022@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <sde22e24.022@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 25, 2002 at 02:05:12PM -0600, Joshua Brindle wrote:
> Here is the patch to add the include dir's for the Makefile.in for the
> directories listed in my last post. 

I have made identical changes to my version.

Currently the installed include files are broken,
because /usr/include/linux/flask files are not installed,
I am currently considering the best way to rectify this issue.

> this successfully compiles the entire package, here is what i did
> 
> ./configure --with-lsm=/usr/src/linux-2.4.19-selinux/
> make
> make DESTDIR=/root/selinux-build install
> 
> and everything is in /root/selinux-build/usr  EXCELLENT..
> the only problem i had is if i tried to do ../selinux-build install
> complained and said it needed an absolute pathname and nothing got
> installed, not a problem for me since my package installer will use
> absolute paths but it may be a problem to someone manually installing,
> Thanks a lot, this will help me tremendously..

Absolute paths are required everywhere (at least for the --with-lsm
parameter), because otherwise the patch would need to be adjusted when
processing nested sub directories.

(I really need to add a check to the configure script to ensure that the
--with-lsm= directory is absolute...)

If you are installing it manually, I think it is unlikely you would want
to use DESTDIR=, probably ./configure --prefix=... (IIRC) would be a
better alternative. DESTDIR is for installing it in a temporary location
for packaing, --prefix= is the final location (although with SE-Linux is
probably doesn't make any difference, as no directory names seem to be
hardcoded anywhere).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
