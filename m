Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA03687
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 01:43:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA16203
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 05:42:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id FAA16199
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 05:42:41 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
Date: Tue, 13 Aug 2002 07:43:30 +0200
Cc: selinux@tycho.nsa.gov
References: <20020813002617.72875.qmail@web40008.mail.yahoo.com>
In-Reply-To: <20020813002617.72875.qmail@web40008.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020813054330.B512B8746@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Aug 2002 02:26, Brad Chapman wrote:
> Mr. Russell,

Mr. Brad,
What's with the "Mr" prefix to all email?

> --- Russell Coker <russell@coker.com.au> wrote:
> > On Mon, 12 Aug 2002 15:21, Brad Chapman wrote:
> > >         The context REMAINS THE SAME! Even when I use 'su -l' !!!
> > >
> > >         What does this mean?
> >
> > This means that su is operating correctly on your system.
>
>         Um.... OK. Could you explain that?

The point of the su domain is that the su program runs in it's own domain 
with access to authenticate the user and then transitions back to the 
original domain that it was run from.  So you run su from user_t, and then 
after the su you're in user_t again.

> > So how do you cause the situation where your programs are running in the
> > su domain and causing the errors to be logged?
>
>         I don't know. Does it have anything to do with the
> domain_auto_trans() m4 macro, or does it have to do with the use of su at
> all?

Show me the error messages from your system logs that caused you to add all 
those rules.  They will contain the name of the program which was denied 
access.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
