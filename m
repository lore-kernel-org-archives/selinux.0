Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69C5AHa022752
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 08:05:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h69C59H5027811
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 12:05:09 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h69C59RX027808 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 12:05:09 GMT
Subject: Re: context trouble with 2.5 bits
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>, Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1057701768.25921.53.camel@columbia>
References: <1057701768.25921.53.camel@columbia>
Content-Type: text/plain
Message-Id: <1057752291.13738.15.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jul 2003 08:04:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-08 at 18:02, Colin Walters wrote:
> Hi,
> 
> I think I'm pretty close to getting my Debian system running with the
> SELinux 2.5 bits.  However, I can't seem to get either the patched sshd
> or login to give me the correct context.  When I login (using login) as
> root, I see:

Also, make sure that the login process is running in the correct domain,
i.e. local_login_t.  You need to relabel /bin/login to login_exec_t
after updating it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
