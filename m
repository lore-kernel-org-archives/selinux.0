Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2G7YaRb018481
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 02:34:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2G7Wp6Q013809
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 07:32:51 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i2G7Wn5t013782
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 07:32:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: keen@internode.on.net
Subject: Re: macros/vi
Date: Tue, 16 Mar 2004 18:33:07 +1100
Cc: selinux@tycho.nsa.gov
References: <405699f4.146.40ec.155106242@internode.on.net>
In-Reply-To: <405699f4.146.40ec.155106242@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403161833.07172.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Mar 2004 17:08, "keen@internode.on.net" <keen@internode.on.net> 
wrote:
> would like to find out is there any technical difference by
> defining TE rules for an application in
> domains/program/app.te and macros/programs/app.te ? When
> would it be better to use it as a macro, or would it be
> better to list it just in the domains directory?

The main reason for the macros/program/ directory is so that macro definitions 
can be included before anything uses them.

If you have a macro that is only used in one .te file then including it's 
definition in that .te file is probably best (see ssh.te for an example).

> As a way to learn configuring the policy, I am currently
> still experimenting with configuring TE rules for vi(vim).
> Would it be necessary for vi to run in its own domain as
> such? Or running it under the invoking user's domain would
> suffice?

Why would you want vi to run in it's own domain?  What extra access do you 
want to grant or what of the regular user access do you want to remove?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
