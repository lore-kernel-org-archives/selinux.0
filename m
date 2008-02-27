Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1REZJLO002157
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 09:35:19 -0500
Received: from g1t0028.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1REZHDA026696
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 14:35:17 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 0/5] New labeled networking permissions for 2.6.25
Date: Wed, 27 Feb 2008 09:35:15 -0500
Cc: Eric Paris <eparis@parisplace.org>, selinux <selinux@tycho.nsa.gov>
References: <20080226184032.834798290@hp.com> <200802261708.08090.paul.moore@hp.com> <1204118622.32061.209.camel@gorn>
In-Reply-To: <1204118622.32061.209.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802270935.15797.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 February 2008 8:23:41 am Christopher J. PeBenito wrote:
> On Tue, 2008-02-26 at 17:08 -0500, Paul Moore wrote:
> > On Tuesday 26 February 2008 4:52:34 pm Eric Paris wrote:
> > > On 2/26/08, paul.moore@hp.com <paul.moore@hp.com> wrote:
> > > >  It is important to note that
> > > >  while this patchset adds the permissions required it doesn't
> > > > enable the "network_peer_controls" policy capability.
>
> [...]
>
> > > So, does anyone have a good idea suggestions where we should turn
> > > on/off these new capabilities?  I know it has to be in the base
> > > module in the end, but I don't know what file to put them in.  I
> > > might just throw it in kernel.te for now for me to keep testing
> > > but I assume we are going to want all of these definitions in one
> > > place? Are we going to want them all over as long as they end up
> > > being built into base?
> >
> > I have no idea but I suspect Chris has given this some thought and
> > probably has some ideas.  I tend to think putting them in one place
> > is probably a good idea ...
>
> I haven't thought about this much, but my initial idea would be to
> have a specific file, maybe policy/polcaps or policy/capabilites.

Sounds good to me.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
