MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH RFC] SELinux support for DCCP
Date: Sat, 11 Nov 2006 12:49:33 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
In-Reply-To: <XMMS.LNX.4.64.0611111246360.29096@d.namei>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "James Morris" <jmorris@namei.org>
Cc: "Arnaldo Carvalho de Melo" <arnaldo.melo@gmail.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <dccp@vger.kernel.org>,
        <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: James Morris [mailto:jmorris@namei.org] 
> 
> On Sat, 11 Nov 2006, Joshua Brindle wrote:
> 
> > James Morris wrote:
> > > The kernel patch is included below, please review.
> > > 
> > > Signed-off-by: James Morris <jmorris@namei.org>
> > >   +#define CONTEXT__TRANSLATE                        0x00000001UL
> > > +#define CONTEXT__CONTAINS                         0x00000002UL
> > >   +   S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
> > > +   S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
> > >   +    S_("context")
> > >   +#define SECCLASS_CONTEXT                                 59
> > >   
> > 
> > oops?
> 
> What?
> 

Did you mean to include context classes as part of the dccp patch?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
