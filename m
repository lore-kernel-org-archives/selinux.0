Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89As1La028560
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 06:54:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h89AqOLY025032
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 10:52:24 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h89AqNsG025028
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 10:52:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Romix" <romix@php.cd>, <selinux@tycho.nsa.gov>
Subject: Re: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 20:54:12 +1000
References: <005801c376bb$439ed330$4200000a@roadwarrior>
In-Reply-To: <005801c376bb$439ed330$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309092054.12989.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Sep 2003 20:15, Romix wrote:
> Sep  8 20:45:17 [sshd] Accepted password for setest from 10.0.0.23 port
> 33571 ssh2
> Sep  8 20:45:17 [sshd] fatal: Could not obtain SID for user setest
> Sep  8 20:45:17 [sshd] syslogin_perform_logout: logout() returned an
> error

>From your description it seems that you correctly added the user and 
configured your system.

Does "dmesg" display any avc messages concerning the login?

Is sshd running in the correct context?  "ps --context | grep sshd" will show 
you the context.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
