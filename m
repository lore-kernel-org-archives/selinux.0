Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0O3gQXf022581
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2006 22:42:26 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0O3gNnm019180
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 03:42:24 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2715061B07
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 14:42:23 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27261-04 for <selinux@tycho.nsa.gov>;
	Tue, 24 Jan 2006 14:42:22 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B38CE61B02
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 14:42:22 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 22EB3A80A6
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 14:42:24 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: apparent bug in setrans
Date: Tue, 24 Jan 2006 14:42:18 +1100
References: <200601241431.25155.russell@coker.com.au>
In-Reply-To: <200601241431.25155.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601241442.23964.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 24 January 2006 14:31, Russell Coker <russell@coker.com.au> wrote:
> $ runcon -l s0:c1.c3 id
> uid=500(rjc) gid=500(rjc) groups=500(rjc) context=rjc:system_r:unconfined_t
>
> Above is the result of running id on a fairly recent rawhide machine.  It
> appears that there's a bug in setrans which maps everything to "" if it
> can't find a name.

An apparently related bug is that the command "newrole -l s3-s15:c0.c255" will 
fail because it tries to label the terminal device with no sensitivity level.  
Adding "s3=TopSecret" in the setrans.conf file makes it work correctly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
