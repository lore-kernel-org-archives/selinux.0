Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6Q0lGNp025922
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 20:47:16 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6Q0lGDo020135
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2008 00:47:16 GMT
Received: by py-out-1112.google.com with SMTP id a78so9659906pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 17:47:15 -0700 (PDT)
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
	3
From: Stephen Smalley <stephen.smalley@gmail.com>
To: James Morris <jmorris@namei.org>
Cc: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.64.0807260046250.19915@us.intercode.com.au>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
	 <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
	 <Pine.LNX.4.64L.0807241800060.14689@ruuvi.it.helsinki.fi>
	 <1216948850.5185.10.camel@sulphur>
	 <Xine.LNX.4.64.0807252302500.12139@us.intercode.com.au>
	 <1216992009.11948.1.camel@sulphur>
	 <Xine.LNX.4.64.0807260046250.19915@us.intercode.com.au>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 20:45:26 -0400
Message-Id: <1217033137.14295.11.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-07-26 at 00:47 +1000, James Morris wrote:
> On Fri, 25 Jul 2008, Stephen Smalley wrote:
> 
> > On Fri, 2008-07-25 at 23:03 +1000, James Morris wrote:
> > > Turns out it was caused by 
> > > CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE being set to the 
> > > default of 19.
> > > 
> > > After setting it to 22 (same as the Fedora kernel), the problem went away.  
> > 
> > Makes sense - policy.19 predates the avtab memory optimization work I
> > did, and requires the policy toolchain to fully expand all
> > attribute-based rules into individual type pairs.  So that shows how
> > much memory we are saving from that particular optimization today.
> 
> Should we bump that value so that kernel developers don't hit the same 
> problem if they have SELinux enabled?  (Many would assume the boot hung).

No - the whole point of that config option is to avoid breakage on
Fedora 3 and 4, as noted in the help text.  And the option on which it
depends defaults to n and thus shouldn't be enabled for anyone by
default.

As to whether or not we need to care about Fedora 3 and 4 anymore is
perhaps a reasonable question; if not, then the entire option could go
away.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
