Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA04924
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 17:11:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA16513
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 21:10:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA16509 for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 21:10:02 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Eric Johnson <eric@gruver.net>
Subject: Re: oops
Date: Tue, 18 Jun 2002 23:11:14 +0200
Cc: selinux@tycho.nsa.gov
References: <45F949D73F69D41198B00004AC2513FB03D5B6CD@mad00mp3.dot.state.wi.us> <20020618145556.D02161581@lyta.coker.com.au> <20020618144758.3ed245ef.eric@gruver.net>
In-Reply-To: <20020618144758.3ed245ef.eric@gruver.net>
MIME-Version: 1.0
Message-Id: <20020618211114.C304769D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 Jun 2002 21:47, Eric Johnson wrote:
> > Anything on that machine is authorised.
>
> I hope that doesn't include spamming.  Someone could abuse the machine
> by connecting and spewing forth e-mail.  Of course, typing in spam
> with "mail" is hardly conducive to spewing out spam.

It doesn't include spamming or any other attacks on machines you don't own.

But this is a good point, I have changed the firewall rules to not allow any 
tcp connections to the outside world as a temporary measure.  Later I'll 
change it to not allow certain ports only.

> But it was nice to look around a SELinux installation for a couple of
> minutes.
>
> Thanks,

Glad you liked it!

Peter once mentioned a vague plan of doing what I have just done.  I'm sure 
that he could have setup a better SE demo system (but doing so would have 
taken more than the 4 hours I spent on it).

I should have planned for notices and firewalls first...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
