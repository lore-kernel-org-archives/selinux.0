Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA04045
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 05:11:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA12103
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 09:09:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA12099
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 09:09:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>, selinux@tycho.nsa.gov
Subject: Re: preferred way to configure devfs contexts
Date: Mon, 6 May 2002 19:09:38 +1000
References: <20020505144746.A353E8145A@coffeesaur2.evoserve.com>
In-Reply-To: <20020505144746.A353E8145A@coffeesaur2.evoserve.com>
MIME-Version: 1.0
Message-Id: <20020506090938.50C673C86@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 6 May 2002 00:47, Debian User wrote:
> devfs_context is fast becoming my preferred way to configure
> /dev contexts. Can we do away with the hacked devfsd?

/etc/devfs/conf.d/selinux is a conffile, you can just comment out all the 
lines in it...

devfs_context doesn't apply to device nodes that were created before the 
policy was loaded, so if you've added new hardware or drivers you can't use 
it to apply permissions to them without a reboot.

Also devfsd can do lots of other things such as running scripts on device 
open etc...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
