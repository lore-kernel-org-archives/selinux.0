Date: Sat, 26 Jul 2008 00:47:14 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <stephen.smalley@gmail.com>
cc: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
 3
In-Reply-To: <1216992009.11948.1.camel@sulphur>
Message-ID: <Xine.LNX.4.64.0807260046250.19915@us.intercode.com.au>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
 <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
 <Pine.LNX.4.64L.0807241800060.14689@ruuvi.it.helsinki.fi>
 <1216948850.5185.10.camel@sulphur>  <Xine.LNX.4.64.0807252302500.12139@us.intercode.com.au>
 <1216992009.11948.1.camel@sulphur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Jul 2008, Stephen Smalley wrote:

> On Fri, 2008-07-25 at 23:03 +1000, James Morris wrote:
> > Turns out it was caused by 
> > CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE being set to the 
> > default of 19.
> > 
> > After setting it to 22 (same as the Fedora kernel), the problem went away.  
> 
> Makes sense - policy.19 predates the avtab memory optimization work I
> did, and requires the policy toolchain to fully expand all
> attribute-based rules into individual type pairs.  So that shows how
> much memory we are saving from that particular optimization today.

Should we bump that value so that kernel developers don't hit the same 
problem if they have SELinux enabled?  (Many would assume the boot hung).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
