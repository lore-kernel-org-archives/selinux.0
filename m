Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92KFarT009715
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 16:15:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i92KERnE001110
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 20:14:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policy patches
Date: Sun, 3 Oct 2004 06:15:33 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <200409292354.15227.russell@coker.com.au> <200410021043.19336.russell@coker.com.au> <415E8091.5000202@redhat.com>
In-Reply-To: <415E8091.5000202@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410030615.33865.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2 Oct 2004 20:18, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> >+dontaudit $1_mozilla_t tmp_t:lnk_file read;
> >
> >This should not be possible.  If tmp_t:lnk_file gets generated with strict
> >policy then we have a bug somewhere else.
>
> Something seems to generate it regularly, probably when setenforce 0 in
> effect.  Have had to
> do this alot because of broken kernel(s).

What is the name of the lnk_file in question?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
