Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3BAOkRb003499
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 06:24:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3BAOimw014253
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 10:24:45 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i3BAOW4w014204 for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 10:24:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Rogelio Serrano <rogelio@smsglobal.net>
Subject: Re: booting in enforcing mode
Date: Sun, 11 Apr 2004 20:23:07 +1000
Cc: selinux@tycho.nsa.gov
References: <edb0cd3759adb044522304e91946929a@debian>
In-Reply-To: <edb0cd3759adb044522304e91946929a@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404112023.07189.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Apr 2004 00:53, Rogelio Serrano <rogelio@smsglobal.net> wrote:
> I see. I think i have to remove some of those that i added. the
> hotplug scripts are the noisiest. i will fix /bin/login first.
> its the login fom util-linux 2.12 and im not using PAM. i need

Not using PAM is a problem.  I have written policy to prevent /bin/login from 
accessing /etc/shadow directly.  When using PAM the helper program 
unix_chkpwd is granted read access to /etc/shadow and /bin/login will spawn 
unic_chkpwd to check the password.

When not using PAM you would have to put the following in login.te:
allow $1_login_t shadow_t:file { getattr read };

Then in the domain declaration change auth_chkpwd to auth.

> to label the tty properly. i can login but not into

That's another thing, if you use a non-PAM login program then you have to 
patch it to relabel the tty.

I think that an option to consider is using pam-login.  It's source code is 
apparently very clean, partly because it's only designed to use PAM and has 
no options for doing other things.

> /User/Admin. login drops me into / then i can just "cd" and im
> in sysadm_home_dir. all home directories are in /Users and
> admins home dir is /Users/Admin alongside the other users. The
> context for /Users is system_u:object_r:file_t. Is that ok?
> Shouldnt it be root_t? Or should i create a totally new type.

Best thing to do would be sed -e s/^\/home\//\/Users\// on the file_contexts 
file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
