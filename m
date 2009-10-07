Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <4ACB5247.4000304@manicmethod.com>
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4AB0EF22.8070003@manicmethod.com>
	 <1254233003.2466.59.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4ACB5247.4000304@manicmethod.com>
Content-Type: text/plain
Date: Wed, 07 Oct 2009 13:37:58 -0400
Message-Id: <1254937078.2251.286.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-10-06 at 10:20 -0400, Joshua Brindle wrote:
> 
> Paul Nuzzi wrote:
> > On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote:
> <snip>
> > Thanks for your input.  Below is the updated patch for libsepol.
> >
> 
> A quick look through looks good. I'd like to test it out a bit, do you 
> have a Xen policy somewhere I can use for testing?
> 
> Also, I notice that this only lets you write out a "kernel" policy for 
> Xen, but it might be beneficial to write out a base policy for testing, 
> development, analysis, etc.

The Xen Flask policy lives in the xen-unstable tree; Paul has a patch to
update the Xen Flask module to support this new policy string identifier
and the new ocontext records and to update the policy there, but you'd
have to apply that patch to xen-unstable and build it.

In terms of base policy, if you mean modular base policy, we'd have to
introduce multiple string identifiers for it in the same way as the
kernel policy format, and I couldn't see the benefit of doing that when
the module format is going to be replaced in the not-too-distant future.
And what precisely is the benefit of writing a base policy vs. a kernel
policy now that policy.24 includes attribute names and preserves
attributes in allow rules (aside from certain cases, like type set
exclusion aka minus)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
