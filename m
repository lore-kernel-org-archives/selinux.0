Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9REnwXZ021385
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 10:49:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9REmdrP004446
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 14:48:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: screen patch
Date: Thu, 28 Oct 2004 00:49:51 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20041026120629.GC24672@rom.cip.ifi.lmu.de>
In-Reply-To: <20041026120629.GC24672@rom.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410280049.52089.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Oct 2004 22:06, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> The following patch allows users to start screen with some other program
> than the shell, e.g. "screen vim /some/file". The given command forms
> the first session inside of screen.

Looks OK.  But it still won't capture every case.  Someone who uses screen to 
run a text mode irc client wouldn't get the result that they probably expect 
(irc running in user_irc_t).

We could define an attribute $1_launcher_domain and then have something like 
this in irc_macros.te:
domain_auto_trans($1_launcher_domain, { irc_exec_t $1_irc_exec_t }, $1_irc_t)

Then have something like this in x_client_macros.te:

domain_auto_trans($1_launcher_domain, $2_exec_t, $1_$2_t)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
