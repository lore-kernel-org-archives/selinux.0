Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00834
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 11:45:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA10809
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:43:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA10803
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:43:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: Debian file_contexts needed
Date: Thu, 21 Mar 2002 17:44:55 +0100
Cc: selinux <selinux@tycho.nsa.gov>
References: <20020321161931.GP10482@vnl.com>
In-Reply-To: <20020321161931.GP10482@vnl.com>
MIME-Version: 1.0
Message-Id: <20020321164455.4DF255927@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Mar 2002 17:19, Dale Amon wrote:
> Does anyone have a current copy of a file_contexts for

It's in the new selinux package I put online on 
http://www.coker.com.au/selinux/ a few minutes ago.

> the new release for Debian? I presume Rich Coker does,

I don't know anyone named Rich.

> but given the time diff between Ireland and Australia,
> I suspect he's well before dawn and sound asleep.

I live in Amsterdam, not that far from Ireland.  But regardless I keep 
strange hours so even if I was in Australia I might be up.

> I could go ahead and roll my own, but it seems a boring
> waste of a few hours to re-invent it.

The file_contexts is the trivially easy part.  Writing the .te rules and 
having them not be too permissive is the hard part.

Also regarding my Debian packages, the only real problems now are that cron 
doesn't work (haven't got around to finding out why) and I haven't packaged 
logrotate.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
