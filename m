Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hANG7gRb005175
	for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2003 11:07:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hANG7ZqY004995
	for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2003 16:07:35 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hANG7Y0o004992 for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2003 16:07:34 GMT
Date: Sun, 23 Nov 2003 16:07:13 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031123160713.GF2718@vnl.com>
References: <20031119144708.GB8546@vnl.com> <200311200150.21987.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311200150.21987.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 20, 2003 at 01:50:21AM +1100, Russell Coker wrote:
> On Thu, 20 Nov 2003 01:47, Dale Amon <amon@vnl.com> wrote:
> > The policy build error for today is:
> >
> > ERROR 'unknown type mailman_queue_chkpwd_t' at token ';' on line 81971:
> > #line 10047
> > allow mailman_queue_su_t mailman_queue_chkpwd_t:process transition;
> > /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> > make: *** [/etc/security/selinux/policy.15] Error 1
> 
> The chkpwd changes broke mailman.  I'm not sure whether it's worth trying to 
> fix this or whether mailman itself should be fixed instead.  I'll probably do 
> a work-around soon.

Is anything in progress? I've not found a way to get by 
this without going into the end-result disk image and fiddling
things manually, which is a pain. I haven't got any other workaround
because I install packages into the chrooted image like this:

 yes "" | PRIORITY=low DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -qqqqq -y install "$name" > /dev/null

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
