Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13150
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 11:36:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA08691
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 15:35:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA08687 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 15:35:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: newrules
Date: Thu, 25 Apr 2002 17:36:09 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524367@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524367@csoc-mail-box.csoconline.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020425153609.71D743CCF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Apr 2002 16:41, you wrote:
> I called the newrules.pl
> newrule-selinux.pl
> I modified it to read /var/log/messages
> and printout to stdout.
>
> Have you done any thing different
> to new rules script.

No.  I haven't even run it myself.  I have no plans to use such software in a 
serious fashion and don't recommend that anyone else use it either.  I only 
included it because it's in the upstream so including it is the right thing 
to do.  It's OK for learning what the dmesg output means, but after that I 
think you're better off just reading the logs yourself.

But it's in my package so Debian users who disagree with me on this matter 
can do as they wish.

Renaming it as you suggest makes sense, I'll call it 
/usr/bin/newrules-selinux.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
