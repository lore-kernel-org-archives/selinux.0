Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OIA7Rb024906
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 13:10:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OI8WlK002882
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 18:08:32 GMT
Received: from warszawa.7bulls.com (warszawa.7bulls.com [213.241.20.163])
	by jazzswing.ncsc.mil  with ESMTP id i1OI8VOX002878
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 18:08:31 GMT
Received: from localhost (localhost [127.0.0.1])
	by warszawa.7bulls.com (Postfix) with ESMTP id 1CF4552E45
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 19:09:46 +0100 (CET)
Received: from warszawa.7bulls.com ([127.0.0.1])
 by localhost (warszawa [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02244-02 for <selinux@tycho.nsa.gov>;
 Tue, 24 Feb 2004 19:09:42 +0100 (CET)
Date: Tue, 24 Feb 2004 19:09:42 +0100
To: selinux@tycho.nsa.gov
Subject: Su(1) flaws (was: identity)
Message-ID: <20040224180942.GA2322@warszawa.7bulls.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
From: rafal.wojtczuk@7bulls.com (Rafal Wojtczuk)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
Smalley> Changing su(1) to support context transitions is
Smalley> not; it has been suggested previously on the list, and my advice 
Smalley> has been to do it carefully, not to avoid doing it altogether.
	So, here go a few arguments _not_ to support su(1), as IMHO (and not
only mine) su, at least in current shape, is broken by design.
	Su is used for the following purposes:
*) to allow an unprivileged user to temporarily acquire another user's
uid (in selinux, security context) via password authentication
**) to allow root (in selinux, sysadm_t) to temporarily acquire another 
user's uid (in selinux, security context).
Both ways are dangerous. The third one, usage of "su dedicated_user" in root
cron jobs (e.g. /etc/cron.daily/inn-cron-expire), seems secure to me (though 
unnecessary). 
	In case of (*), the whole idea of "an unprivileged user to
temporarily acquire another user's credential" is broken. If user "joe" reads
his mail with a buggy mail client and also likes to "su" to root/sysadm_t, a
buffer overflow in joe's mail client can result in total system compromise. 
Yes, it requires a targetted attack. IIRC, monkey.org (which holds dsniff's
homepage) was compromised some time ago in a similar way (someone cracked 
"joe" account and was able to take over a su session left on "screen").
	Moreover, for (*) purposes su(1) must be executable by unprivileged 
users (unless we restrict su to be mode 4750, group wheel by default;
it is not so at least in Fedora). Therefore, if an unprivileged user 
successfully exploits a buffer overflow in su or any library used, he gains 
all su(1) privileges -> ability to transform to sysadm_t. This 
(unnecessarily) enlarges the area prone to exploitation. 
	Finally, (*) is redundant - it can be achieved by directly logging
as the target user via ssh. If someone dislikes direct login to 
root/sysadm_t, it is sensible to run two sshd servers - one for ordinary 
users, the other (with client IP restrictions applied) for admins. BTW, this 
solution is only meant to decrease the number of attack vectors - sshd 
architecture (generally, Unix authentication) is imperfect. It can be 
improved by utilizing the least privilege principle, via something similar to 
how it is solved in plan9, if we only remove its cryptographic bloat. But, 
it's a different story.
	In case of (**), if su is invoked by a process with a controlling
tty, there exist two processes with different security context which share
the same controlling tty. Doesn't it sound bad ? Let's assume the target user
(Mallory) is malicious and convinces admin to run "su mallory". At least two
exploitation scenarios are possible:
1) Mallory's .bashrc executes a binary which stuffs characters to the
controlling tty with the help of TIOCSTI ioctl, then kills the shell.
Admin's shell will receive these characters from the controlling tty and
execute appropriate (read - malicious) commands. This can be prevented if 
admin is smart enough to never run "su user", but "screen su user" instead 
(but then we introduce dependency on "screen" security, not to mention the 
dependency on admin's smartness).
2) If admin uses xterm (or many other X tty emulators), it is possible to 
stuff keystrokes to the controlling tty by simply echoing to output some
xterm control sequences. Search for "CSI Ps ; Ps ; Ps t" ctlseq
description. This can be prevented if admin is smart enough not to use X
(how about this dependency?).

	There are a few utilities whose design problems cannot be solved by 
pure selinux methods of context manipulation; it seems sane not to propagate
these broken solutions (or fix them).

Regards,
Rafal Wojtczuk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
