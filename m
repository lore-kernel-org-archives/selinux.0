Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03290
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:10:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA18015
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 21:09:10 GMT
Received: from web40005.mail.yahoo.com (web40005.mail.yahoo.com [66.218.78.23])
	by jazzswing.ncsc.mil  with SMTP id VAA18011
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 21:09:09 GMT
Message-ID: <20020826211017.76011.qmail@web40005.mail.yahoo.com>
Date: Mon, 26 Aug 2002 14:10:17 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: devfs change
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020826202104.0A6687942@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:
> On Mon, 26 Aug 2002 21:25, Brad Chapman wrote:
> > --- Russell Coker <russell@coker.com.au> wrote:
> > > I've attached a patch to change devfs_t to device_t everywhere, and make
> > > some
> > >
> > > other related changes.
> > >
> > > Also there's a couple of minor things unrelated to devfs in this because
> > > they
> > >
> > > were trivial and close to the devfs changes.
> >
> > Is this patch included in your current policy?
> 
> When I release Debian packages based on the August release it (and all the 
> other patches I've posted over the last few days) will be included.
> 
> I will not make a release until I get some of these issues sorted it, there's

> no point in releasing something if it's not going to work.

That makes sense. I asked because I have a modified version of your policy 
for my system (Red Hat 6.2) and don't want to have to modify your policy again.
The way I plan to do it now is:

1. Make a diff between my policy and your policy that I started with.
2. Apply the diff against the old policy to the new policy, fix the fuzz and
   reject errors, and attempt to compile it to see if it makes sense.

Is this a good way to keep my changes, yet enjoy your changes as well?

Thanks,

Brad


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
