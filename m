Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h690I3Ha021171
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2003 20:18:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h690I2H5017328
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 00:18:02 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h690HtRX017324 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 00:18:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: context trouble with 2.5 bits
Date: Wed, 9 Jul 2003 10:17:42 +1000
References: <1057701768.25921.53.camel@columbia>
In-Reply-To: <1057701768.25921.53.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307091017.42539.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jul 2003 08:02, Colin Walters wrote:
> Warning!  Could not get new context for tty1, not relabeling.

Which may mean that the original type for the device node is not one that is 
expected.  Please tell me what "ls --context /dev/tty1" reports.

However this should have nothing to do with the ability to login and run a 
session in the correct context.

> ...followed by a bunch of avc denials about tty1 and /root, and then my
> context is:
>
> meta:~# id
> uid=0(root) gid=0(root) groups=0(root) context:system_u:system_r:user_t

This is wrong.  There's a domain_auto_trans() rule to transition to user_t for 
when using a login program that is not aware of SE Linux.  So it looks like 
the target context is not being set.

Under the new scheme I believe that some file is supposed to be written under 
/proc for this.  Make sure that the right stuff is mounted under /proc, the 
file is available, etc.

Also while in permissive mode do some tests at the command line, do:
# echo user_u:user_r:user_t > /proc/whatever-it-is
# id

Then id should report a context of user_u:user_r:user_t if the context change 
is working correctly.

> Now, since Debian uses the login in shadow-utils (not the one in
> util-linux), I had to port over the patch, but I'm fairly sure that's
> not the problem, because I get the exact same symptoms when logging in
> over the patched ssh.
>
> Does anyone have any ideas for what could be going wrong?

Does the NSA supplied patch for 2.5.x do the same things as the patch for 
2.4.x?  Maybe there's something new in the NSA tree that's necessary and that 
merely calling execve_secure() is not enough.

Does your /etc/security/default_contexts have the right stuff?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
