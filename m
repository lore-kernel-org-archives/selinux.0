Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05161
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:14:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA24048
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:13:04 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id PAA24039
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:13:03 GMT
Date: Thu, 18 Apr 2002 17:15:32 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020418171532.B6551@lemuria.org>
References: <20020418112238.A1788@lemuria.org> <20020418104424.B714A44C1C@lyta.coker.com.au> <20020418142518.A5613@lemuria.org> <20020418145101.D31F444CB8@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418145101.D31F444CB8@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 04:51:01PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 04:51:01PM +0200, Russell Coker wrote:
> > Absolutely. The problem is that you have a unified frontend with
> > diversification at the backend. This is the same issue you have for
> > ssh, except that ssh (and other remote login tools) have a method for
> > changing to a specific user, based on user/password data.
> 
> Ssh solves it by forking a new process and changing UID BEFORE doing any work.

Right. I want to do the same thing, but not with UIDs, but with
domains.


> > where user2's script contains something like:
> > <? $f=fopen("../user1/script.php"); read($f); ?>
> 
> What you could do is to have a unix domain socket named /var/www/socket/user1 
> which the Apache process creates and then forks off a child process to run 
> all PHP code for user1 under the UID of that user, and then pass back the 
> data to Apache through the socket for retransmission to the client.

That requires changes in the apache code, which is bug-prone and will
probably be lost with the next upgrade. I want to put the policy
enforcement into the kernel/security server, where it belongs.


In essence, it boils down to: "a script (php, cgi, whatever) that
belongs to user X can only access files of user X"

The sole problem being that the scripts aren't executed in the
unix-sense of execution, but by being loaded and interpreted by the
apache process.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
