Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265132995.3003.41.camel@tesla.lan>
References: <1265120566.3003.5.camel@tesla.lan>
	 <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
	 <1265129920.3003.28.camel@tesla.lan>
	 <1265132044.3114.31.camel@moss-pluto.epoch.ncsc.mil>
	 <1265132995.3003.41.camel@tesla.lan>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 14:01:24 -0500
Message-Id: <1265137284.3114.112.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-02 at 18:49 +0100, Guido Trentalancia wrote:
> Well, after you told me to do that, we have context_destroy() calling
> mls_context_destroy(), which in turn calls:
> 
> ebitmap_destroy(&c->range.level[i].cat);   for i={0,1}
> memset(&c->range, 0, sizeof(c->range));
> 
> But in the case of a standard policy, there is no range field I suppose.

struct context is defined in context.h and always has a struct mls_range
range field (that was made unconditional when MLS support was turned
into a runtime option rather than a compile-time option).
context_init() always clears the entire structure, so all fields should
be initialized to zero.

A struct mls_range is an array of mls_level structures with two elements
(for the low and high).  A struct mls_level is an unsigned integer
sensitivity value and a struct ebitmap category set.  A struct ebitmap
is a node pointer and an unsigned integer highbit.

So if the structure was properly initialized, we should have an ebitmap
with a NULL node pointer and a 0 highbit value.  In that situation,
ebitmap_destroy() should merely re-clear the two fields and return
without any difficulty.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
