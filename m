Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13784
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 18:15:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA17131
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 22:13:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA17127
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 22:13:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Fwd: Re: setfiles patch
Date: Sat, 20 Apr 2002 00:14:56 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204191511430.18117-300000@raven>
In-Reply-To: <Pine.GSO.4.33.0204191511430.18117-300000@raven>
MIME-Version: 1.0
Message-Id: <20020419221457.2764644F20@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 21:33, Stephen Smalley wrote:
> I've merged this support, but with a number of modifications.  See the
> attached complete setfiles.c and setfiles.8 files.  Explanations
> and descriptions of my changes below:

That's all great.  I've just uploaded a new Debian package containing it.

> 3) The default is now "no warnings", as you suggested.  If you want
> warnings, use the new -W option.  The -m option is currently accepted
> by getopt (but does nothing now) for compatibility, but I can remove it
> if/when you update your packages.

I've removed the -m option from my tree.

I just realised that I forgot to update the Makefile to match.  I'll upload a 
new version tomorrow morning.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
