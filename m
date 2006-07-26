Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6QKqhfa021818
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 16:52:43 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6QKqemc024833
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 20:52:40 GMT
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 2/6] netfilter integration: add netfilter contexts package section
Date: Wed, 26 Jul 2006 16:52:40 -0400
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1153168353.10090.47.camel@sgc> <1153234686.10744.10.camel@localhost.localdomain> <1153842540.8634.17.camel@sgc.columbia.tresys.com>
In-Reply-To: <1153842540.8634.17.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607261652.40451.kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 July 2006 11:49, Christopher J. PeBenito wrote:
> On Tue, 2006-07-18 at 10:58 -0400, Karl MacMillan wrote:
> > On Mon, 2006-07-17 at 16:32 -0400, Christopher J. PeBenito wrote:
> > > Add a section to the package for netfilter contexts.
> > >
> > > @@ -254,6 +312,12 @@ int sepol_link_packages(sepol_handle_t *
> > >  		ERR(handle, "Out of memory!");
> > >  		return -2;
> > >  	}
> > > +
> > > +	if (link_netfilter_contexts(base, modules, num_modules) == -1) {
> > > +		ERR(handle, "Out of memory!");
> > > +		return -2;
> > > +	}
> > > +
> >
> > Is this really the correct place for the secmark linking code? In
> > general the code in module.c deals with the policy package, but not the
> > details of the sections. Seems better to put this in a separate file or
> > with the rest of the linking code.
>
> This addition is right under the link_file_contexts() call.
> Link_netfilter_contexts() does the same thing as link_file_contexts().
>

Sorry - wrong file. I was thinking this was going into 
libsemanage/src/modules.c. I think that module.c is a little broad, but I 
don't think it is a big deal.

> > Also, seems that secmark would be a better name than netfilter. This
> > code is not intended to handle generic netfilter rules (though I guess
> > it could).
>
> It provides labeling rules for packets going through netfilter, hence
> netfilter_contexts.  SECMARK is an implementation detail of netfilter.
>

I'm still not convinced, but if I am in the minority that is fine.

> > Finally, the error handling above prevents the propagation of errors
> > from lower-level functions. I understand that you are following what the
> > existing code does, but it would be nice to not add any additional code
> > that follows this broken model. Cleaning up the magic return codes would
> > also be nice.
>
> Cleaning up return code handling is outside the scope of this patchset.

But you are adding code that has the same error. You should at least not 
introduce the same error, but cleaning up the surrounding related code 
(perhaps in a separate patch) would be helpful.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
