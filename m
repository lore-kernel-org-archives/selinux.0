Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA21580
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:33:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA21375
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 03:30:39 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id DAA21371
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 03:30:35 GMT
Date: Tue, 25 Feb 2003 14:33:33 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>
Cc: Russell Coker <russell@coker.com.au>, Wayne Salamon <wsalamon@tislabs.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
Message-ID: <20030225033332.GB17152@snoopy.apana.org.au>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <200302242059.51557.russell@coker.com.au> <20030224235117.B11665@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030224235117.B11665@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 24, 2003 at 11:51:17PM +0100, Tom wrote:
> On Mon, Feb 24, 2003 at 08:59:51PM +0100, Russell Coker wrote:
> > > gpm.te		General Purpose Mouse driver
> > 
> > GPM is not suitable for core IMHO.  I've never used it or seen anyone use it.
> 
> Isn't gpm required by vim in Debian? If it's installed per default,
> even if not used, the policy should be there.

No, I don't think it is required.

vim is linked against libgpmg1, but I would imagine libgpmg1 acts
as a NOP if gpm is not running.

I think it is possible to install vim and libgpmg1 without installing
gpm (but correct me if I am wrong).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
