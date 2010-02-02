Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12Ho1Sx029738
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 12:50:01 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o12HnpVK026683
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 17:49:51 GMT
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265132044.3114.31.camel@moss-pluto.epoch.ncsc.mil>
References: <1265120566.3003.5.camel@tesla.lan>
	 <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
	 <1265129920.3003.28.camel@tesla.lan>
	 <1265132044.3114.31.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 18:49:55 +0100
Message-Id: <1265132995.3003.41.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again !

On Tue, 2010-02-02 at 12:34 -0500, Stephen Smalley wrote:
> On Tue, 2010-02-02 at 17:58 +0100, Guido Trentalancia wrote:
> > Hello again !
> > 
> > On Tue, 2010-02-02 at 11:44 -0500, Stephen Smalley wrote:
> You can't digitally sign the message w/o causing the inlined patch to be
> encoded.  So don't digitally sign patch postings.

That's fine. I won't sign patch postings anymore.

> That's ok.  checkpatch is just advisory; it still falls to a person to
> make the final judgment.

Ok.

> > Please let me know about the oops for ebitmap_destroy(). Do you think it
> > is due to the initial SID issue rather than to calling mls_destroy() for
> > a standard policy ? I wasn't saving that for a separate patch, it's just
> > that we did not discuss that further...
> 
> I'd rather track down the cause and see if we can allow
> mls_context_destroy() to be unconditionally safe.  In fact, I'm tempted
> to drop the mls_enabled tests from all of those inline functions and
> just ensure that the fields are always properly initialized and thus the
> functions will just evaluate properly even in the non-MLS case.

Well, after you told me to do that, we have context_destroy() calling
mls_context_destroy(), which in turn calls:

ebitmap_destroy(&c->range.level[i].cat);   for i={0,1}
memset(&c->range, 0, sizeof(c->range));

But in the case of a standard policy, there is no range field I suppose.

> Chris is correct btw - the kernel has no notions of "standard", or
> "MCS".  It only knows about MLS-enabled vs MLS-disabled.

Ok. So, I have now changed the message accordingly. Thanks again Chris
for pointing that out !

By the way, I think I have now got confused about the initial SID issue
that you mentioned earlier on... Could you please be more specific ? You
should know what the code looks like at the moment in ss/services.c.

Regards,

Guido



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
