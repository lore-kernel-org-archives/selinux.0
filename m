Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA12904
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 00:18:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA15994
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 04:16:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA15990 for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 04:16:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Gregory Ade <gkade@bigbrother.net>
Subject: Re: new policy changes
Date: Thu, 20 Jun 2002 06:18:02 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020619113740.9045569D@lyta.coker.com.au> <1024530561.32149.22.camel@pslgregory>
In-Reply-To: <1024530561.32149.22.camel@pslgregory>
MIME-Version: 1.0
Message-Id: <20020620041803.28265388E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Jun 2002 01:49, Gregory Ade wrote:
> On Wed, 2002-06-19 at 04:37, Russell Coker wrote:
> > I've changed /dev/console to be writable only by the admin domains not by
> > every_domain().
> >
> > This means of course that if you login at the console you have to do so
> > as an administrator, this is fair IMHO, there's no cause for regular
> > users to login at the console.
>
> What about the case of a workstation?  I log in to the console of my
> machine as myself every day.  Also, i believe that KDM/GDM/XDM logins
> via the physically attached kb/mouse/monitor are treated as "console"
> logins.

They are virtual consoles and have tty_device_t not console_device_t.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
