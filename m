Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kABI3cks025179
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 13:03:38 -0500
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kABI20LQ015616
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 18:02:00 GMT
Date: Sat, 11 Nov 2006 13:03:47 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <jbrindle@tresys.com>
cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, dccp@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: RE: [PATCH RFC] SELinux support for DCCP
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
Message-ID: <XMMS.LNX.4.64.0611111302030.30219@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Nov 2006, Joshua Brindle wrote:

> > From: James Morris [mailto:jmorris@namei.org] 
> > 
> > On Sat, 11 Nov 2006, Joshua Brindle wrote:
> > 
> > > James Morris wrote:
> > > > The kernel patch is included below, please review.
> > > > 
> > > > Signed-off-by: James Morris <jmorris@namei.org>
> > > >   +#define CONTEXT__TRANSLATE                        0x00000001UL
> > > > +#define CONTEXT__CONTAINS                         0x00000002UL
> > > >   +   S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
> > > > +   S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
> > > >   +    S_("context")
> > > >   +#define SECCLASS_CONTEXT                                 59
> > > >   
> > > 
> > > oops?
> > 
> > What?
> > 
> 
> Did you mean to include context classes as part of the dccp patch?

The kernel headers have to match the flask headers in the userland tools, 
as they share policy-related data structures.  Ideally, we'd have security 
server namespaces, to keep these things separate.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
