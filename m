Date: Sun, 1 Jun 2003 22:23:59 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: some policy feedback
Message-ID: <20030601222359.D31891@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just come back from a 3-day hacker convention where I brought an
SELinux play system with me, to let the likes of teso, THC, LSD, etc.
have a go at it.

There were a number of interesting points that I'd like to feed to the
list:

1) su problem
The default policy seems to have a hole that has potentially serious
consequences. Root can run su and change to any user account authorized
for root's current role. That way, root can set up traps for the sysadm
when he logs into his own account, e.g. by trojaning the .bashrc file
and having the sysadm execute a fake newrole (which calls the real one
in the background, possibly a wrapper), capturing his password.

Someone (whose name I unfortunately forgot to get) did exploit this
problem and modified my .bashrc in a non-malicious way. I discussed the
issue with him and we both felt that it would probably be possible to
exploit it.


2) various kernel-level issues
code from LSD has brought up several interesting points that I could
not really answer due to lack of in-depth knowledge, especially in the
kernel operations.

One question was the usual LKM issue. Would it be possible to overload
calls of the SELinux patch, in turn disabling it? Or does LSM and/or SE
have any kind of "self-preservation" behaviour?

Another issue was whether it would be possible to trojan a running
binary. Assuming that a daemon has an exploitable buffer overflow, it
seems to be possible to change the daemon itself, at runtime. No exec
would be made, and as I understand it, no system calls that could
trigger SE. The trojaned daemon would continue to run, with whatever
changes were made. (obviously, patching binary code while its running
isn't for the faint of heart, but I've seen several methods for doing
so in action, and it certainly is possible.)


that brings me to

3) user macros
I've been digging through the user macros, because I wanted to set up
an additional unpriviledge (guest) user. Is there any documentation on
why the macros were laid out the way they were?


Some more details when I've caught up on some sleep.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
