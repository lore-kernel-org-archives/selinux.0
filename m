Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3CAVORb007375
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 06:31:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3CATMUZ015361
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 10:29:22 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i3CATKmT015307
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 10:29:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Rogelio Serrano <rogelio@smsglobal.net>
Subject: Re: booting in enforcing mode
Date: Mon, 12 Apr 2004 20:29:57 +1000
Cc: selinux@tycho.nsa.gov
References: <f0412392a31bd031317c4713e9d4eeda@debian>
In-Reply-To: <f0412392a31bd031317c4713e9d4eeda@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404122029.57706.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Apr 2004 17:10, Rogelio Serrano <rogelio@smsglobal.net> wrote:
> I think thats a good idea.
> I understand.
> Im going to download the policy snapshot from your website. I
> think its better than the default policy from selinux-usr.

The policy snapshot on my site is out of date, I haven't updated it for a 
while and lots of new things have gone into the latest NSA release.  I don't 
recommend my snapshot at the moment.

> Well klogd is reading from /proc kmsg and syslogd from
> /dev/log. I will need to keep them separate. The system is
> going to be used on both big and small "machines".

For big machines it's best to keep them separate.  For small machines you can 
save some disk space and RAM by using the same executable for both.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
