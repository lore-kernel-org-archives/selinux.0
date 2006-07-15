Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FFDZBY019527
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 11:13:35 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FFDYsi029861
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 15:13:34 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sat, 15 Jul 2006 11:13:27 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <Pine.LNX.4.64.0607150905550.24495@d.namei> <Pine.LNX.4.64.0607150911210.24495@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607150911210.24495@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151113.27922.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 July 2006 9:11 am, James Morris wrote:
> On Sat, 15 Jul 2006, James Morris wrote:
> > > +	/* XXX - In both cases, this is kinda ugly as we have to go through
> > > +	   the list once to determine how large of a buffer we need,
> > > +	   drop the locks, allocate the buffer, grab the locks, and
> > > +	   finally fill the buffer.  The problem is that there is that
> > > +	   open window where the table could grow and we will end up
> > > +	   short on space. */
> >
> > This needs to be fixed.
>
> Actually, you have many of these.

I believe there are a total of four, the two you just found in 
net/ipv4/cipso_ipv4.c and two more in net/netlabel/netlabel_domainhash.c.  I 
will fix all of them for the next submission of the patchset.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
