Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04015
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 10:08:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA11310
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 14:06:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA11306
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 14:06:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux packages
Date: Tue, 1 Oct 2002 16:08:05 +0200
References: <20020920022148.GA12250@snoopy.apana.org.au> <20020927092947.GJ15981@snoopy.apana.org.au> <20021001100711.A19556@lemuria.org>
In-Reply-To: <20021001100711.A19556@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210011608.05975.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 10:07, Tom wrote:
> On Fri, Sep 27, 2002 at 07:29:47PM +1000, Brian May wrote:
> > I am currently copying newer versions of kernel-patch, kernel-source,
> > kernel-image, and selinux, to the same location:
> >
> > deb http://www.microcomaustralia.com.au/debian/ woody main selinux
>
> Is it possible that the selinux-policy-default is broken? I've done
> everything I could to make sure I have a clean build (including rm -rf
> /etc/selinux) and I still get several hundred errors on install or
> make. Here are some:

I suspect that you may have chosen to ignore the changes (or selected "always 
ignore" on a previous upgrade).  When you do this you are taking parts of the 
policy out of the automatic upgrade path and therefore if an upgrade is 
necessary to produce a compilable policy then the policy will not compile.

To resolve this you can edit /usr/share/selinux/policy/ignorediff and remove 
the files you don't want to protect from modifications and then run
"se_dpkg --configure -a".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
