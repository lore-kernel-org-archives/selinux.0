Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA26233
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 06:38:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA23243
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 10:37:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA23239
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 10:37:06 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>, selinux@tycho.nsa.gov
Subject: Re: selinux system from scratch
Date: Mon, 29 Apr 2002 12:38:57 +0200
References: <20020429051308.0851A81C48@coffeesaur2.evoserve.com>
In-Reply-To: <20020429051308.0851A81C48@coffeesaur2.evoserve.com>
MIME-Version: 1.0
Message-Id: <20020429103857.5E5382362@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Apr 2002 07:13, Debian User wrote:
> Im going to start from scratch now i guess. Did anybody do that
> successfully? Just a stripped down system. Just the Bare minimum to host
> an apache server.

Yes.  Start by installing my packages from http://www.coker.com.au/selinux/ , 
then install the kernel-patch-2.*-lsm package and build a kernel with it 
(where * matches your kernel version).

Then remove policy files (.te files) for packages you don't use from 
/usr/share/selinux/policy/current and run "make install" in that directory.  
Then run "make relabel" in that directory before rebooting into the new 
kernel.

Let me know if you have any problems with this.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
