Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69Eq1rT019869
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 10:52:03 -0400 (EDT)
Received: from mproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i69Epgbg009914
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 14:51:42 GMT
Received: by mproxy.gmail.com with SMTP id d15so143446rng
        for <selinux@tycho.nsa.gov>; Fri, 09 Jul 2004 07:52:01 -0700 (PDT)
Message-ID: <e294b46e0407090752b199eeb@mail.gmail.com>
Date: Fri, 9 Jul 2004 15:52:00 +0100
From: Bradley Chapman <kakadu@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: An SELinux policy for Red Hat 9
Cc: selinux@tycho.nsa.gov, russell@coker.com.au
In-Reply-To: <1089375253.11726.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <e294b46e040708131736c57b6@mail.gmail.com>
	 <200407092111.55045.russell@coker.com.au>
	 <e294b46e0407090443663d55c4@mail.gmail.com> <1089375253.11726.34.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Smalley,

On Fri, 09 Jul 2004 08:14:13 -0400, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> 
> 
> On Fri, 2004-07-09 at 07:43, Bradley Chapman wrote:
> > On Fri, 9 Jul 2004 21:11:55 +1000, Russell Coker <russell@coker.com.au> wrote:
> > > But if you REALLY want to use RHL 9, the current policy should work OK, you
> > > just have to make the appropriate changes to pam, logrotate, cron, coreutils,
> > > etc.
> >
> > What sort of changes? Path changes?
> 
> I think Russell is referring to the userland patches for those
> packages.  The current patches and SRPMS in our userland tree are drawn
> from the Fedora Core development tree, so you are likely to run into
> dependency problems building them on RH9.  And Fedora Core actually
> includes _many_ other patched userland packages for SELinux; we only
> maintain a core subset in our tree for reference purposes for people who
> want to port to other distributions.  A few examples of patched userland
> packages in Fedora Core that are not in our tree include gdm, usermode,
> atd, and libuser, and there are many others.  There is also the issue of
> glibc security awareness; the RH9 glibc won't enable secure mode upon
> domain transitions, unlike the Fedora Core glibc.

Oh.

I thought the patches mentioned were confined mostly to core system
utilities; I had no idea that FC2's modifications for SELlinux were
quite that extensive!

> 
> If you truly are limited to using RH9, then you should likely grab an
> older release of SELinux that was based on RH9.  But life will be
> simpler if you can move to FC2.

Well, in light of your recommendations, I will certainly consider such
a move now.
If I do decide to move to FC2, how difficult will it then become to
adapt the SELinux policy
to my needs?

> 
> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 

Brad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
