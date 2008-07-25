Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PDMI2v017746
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 09:22:18 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PDMH78006719
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 13:22:17 GMT
Received: by py-out-1112.google.com with SMTP id a78so8874330pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 06:22:17 -0700 (PDT)
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
	3
From: Stephen Smalley <stephen.smalley@gmail.com>
To: James Morris <jmorris@namei.org>
Cc: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.64.0807252302500.12139@us.intercode.com.au>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
	 <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
	 <Pine.LNX.4.64L.0807241800060.14689@ruuvi.it.helsinki.fi>
	 <1216948850.5185.10.camel@sulphur>
	 <Xine.LNX.4.64.0807252302500.12139@us.intercode.com.au>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 09:19:57 -0400
Message-Id: <1216992009.11948.1.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-25 at 23:03 +1000, James Morris wrote:
> Turns out it was caused by 
> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE being set to the 
> default of 19.
> 
> After setting it to 22 (same as the Fedora kernel), the problem went away.  

Makes sense - policy.19 predates the avtab memory optimization work I
did, and requires the policy toolchain to fully expand all
attribute-based rules into individual type pairs.  So that shows how
much memory we are saving from that particular optimization today.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
