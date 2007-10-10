Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9AL2t7K011481
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 17:02:55 -0400
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9AL2rI8008441
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 21:02:54 GMT
Received: by nz-out-0506.google.com with SMTP id i1so265321nzh
        for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 14:02:20 -0700 (PDT)
Message-ID: <7e0fb38c0710101402l1ea0a269m16ed42f4e33712c8@mail.gmail.com>
Date: Wed, 10 Oct 2007 17:02:15 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [RFC PATCH v4 1/3] [SELinux] Add a capabilities bitmap to SELinux policy version 22
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <200710101431.57330.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net>
	 <20071005193245.28034.67610.stgit@flek.americas.hpqcorp.net>
	 <1192040194.2687.75.camel@moss-spartans.epoch.ncsc.mil>
	 <200710101431.57330.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/10/07, Paul Moore <paul.moore@hp.com> wrote:
> On Wednesday 10 October 2007 2:16:34 pm Stephen Smalley wrote:
> > On Fri, 2007-10-05 at 15:32 -0400, Paul Moore wrote:
> > > @@ -1304,6 +1307,9 @@ int security_load_policy(void *data, size_t len)
> > >                     return -EINVAL;
> > >             }
> > >             policydb_loaded_version = policydb.policyvers;
> > > +           selinux_policycap_netpeer =
> > > +             ebitmap_get_bit(&policydb.policycaps,
> > > +                             POLICYDB_CAPABILITY_NETPEER);
> > >             ss_initialized = 1;
> > >             seqno = ++latest_granting;
> > >             LOAD_UNLOCK;
> >
> > Only handles the initial policy load case, not reloads.
>
> So it does, thanks.  I just added the same assignment further down in the
> security_load_policy() function to handle the reload case.


Do we expect to have more of these?  are we going to keep making
load_policy larger and larger or should this type of assignment just
be made in its own function to start with?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
