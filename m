Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12145
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 09:43:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA04366
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 13:41:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA04362
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 13:41:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new Debian package
Date: Thu, 25 Apr 2002 15:43:19 +0200
References: <Pine.GSO.4.33.0204250829440.4789-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204250829440.4789-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020425134319.E0A8A3943@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Apr 2002 14:30, you wrote:
> Does this mean that you've inserted appropriate ifdef's throughout
> the .te files for all inter-domain dependencies?  If so, that's great!

Not all, just all the ones that bit me over the installations of three 
machines with significantly different uses.

Reading through all the .te's and analysing them for potential problems is 
more work than I wanted to get into, so I just fixed the things that bit me 
(I think I got all the most common ones) and I'll wait for bug reports now.

I'll post some patches soon for this type of thing.

Also with the current Makefile rules we need the following empty files:
file_contexts/program/custom.fc
file_contexts/program/kernel.fc
file_contexts/program/kmod.fc

I haven't worked out how to remove this need so I've just added the empty 
files to my package.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
