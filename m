Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA02933
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 16:21:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA08411
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 20:19:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA08407 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 20:19:34 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: devfs change
Date: Mon, 26 Aug 2002 22:21:03 +0200
Cc: selinux@tycho.nsa.gov
References: <20020826192528.23787.qmail@web40011.mail.yahoo.com>
In-Reply-To: <20020826192528.23787.qmail@web40011.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020826202104.0A6687942@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Aug 2002 21:25, Brad Chapman wrote:
> --- Russell Coker <russell@coker.com.au> wrote:
> > I've attached a patch to change devfs_t to device_t everywhere, and make
> > some
> >
> > other related changes.
> >
> > Also there's a couple of minor things unrelated to devfs in this because
> > they
> >
> > were trivial and close to the devfs changes.
>
> Is this patch included in your current policy?

When I release Debian packages based on the August release it (and all the 
other patches I've posted over the last few days) will be included.

I will not make a release until I get some of these issues sorted it, there's 
no point in releasing something if it's not going to work.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
