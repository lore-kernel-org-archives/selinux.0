Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Troubles with 2.4.18 kernel
Date: Mon, 1 Apr 2002 15:57:09 +0200
Cc: <SeLinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204010808560.20742-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204010808560.20742-100000@raven>
MIME-Version: 1.0
Message-Id: <20020401135709.A7D9C46E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Apr 2002 15:36, Stephen Smalley wrote:
> On Thu, 28 Mar 2002, Russell Coker wrote:
> > http://lsm.immunix.org/
> >
> > Immunix has had SE Linux included in their patches for several versions
> > now and they have lots of old versions on their site.
> >
> > I usually take my patches from Immunix instead of the NSA site.  When a
> > new kernel comes out Immunix has a patch long before the NSA.
>
> The LSM site does have older LSM kernel patches, but these patches do not
> always coincide with any particular NSA SELinux release.  New development
> on the SELinux kernel, including enhancements to the SELinux kernel module
> and (less frequently) new LSM hooks to support additional security
> functionality in the SELinux kernel module, may appear first on the NSA
> site and only subsequently be pushed to the LSM BitKeeper trees
> (subsequently showing up in later LSM snapshot patches).  Additionally,

Yes, that is the case with the 2.4.18 kernel patches now.  However a kernel 
compiled with the older patch seems to work fine with utilities compiled 
against the headers from the new one (some of the current patches for 
utilities require the latest kernel patch for the latest headers though).

I expect that when 2.4.19 comes out then Immunix will have a patch that 
incorporates your latest code at least a week before the main NSA site gets 
it.

The CVS Looks interesting.  I'll have to investigate it further.



Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
