Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69C1uHa022724
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 08:01:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h69C1tH5027740
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 12:01:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h69C1tRX027737 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 12:01:55 GMT
Subject: Re: context trouble with 2.5 bits
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>, Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1057701768.25921.53.camel@columbia>
References: <1057701768.25921.53.camel@columbia>
Content-Type: text/plain
Message-Id: <1057752105.13738.10.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jul 2003 08:01:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-08 at 18:02, Colin Walters wrote:
> I think I'm pretty close to getting my Debian system running with the
> SELinux 2.5 bits.  However, I can't seem to get either the patched sshd
> or login to give me the correct context.  When I login (using login) as
> root, I see:
> 
> Warning!  Could not get new context for tty1, not relabeling.

Did you remember to mount selinuxfs on /selinux, as described in the
selinux-doc README?  Otherwise, the daemons cannot obtain security
policy decisions from the kernel, such as the new label for the tty.

> ...followed by a bunch of avc denials about tty1 and /root, and then my
> context is:
> 
> meta:~# id
> uid=0(root) gid=0(root) groups=0(root) context:system_u:system_r:user_t

Verify that execcon or runcon work for you, e.g.
	execcon root:sysadm_r:sysadm_t bash

If so, then you need to verify that your login patch is properly calling
setexeccon() with a legitimate user context prior to exec'ing the shell
and that the call is not failing.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
