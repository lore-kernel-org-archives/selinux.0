Subject: threads
From: Albert Cahalan <albert@users.sourceforge.net>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1072454081.827.103.camel@cube>
Mime-Version: 1.0
Date: 26 Dec 2003 10:54:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Normal Linux security data (uid, capability bits)
is per-thread. There are at least two reasons for
this:

1. Multi-threaded server daemons can rely on
   kernel-enforced security.

2. Race conditions are eliminated without locking.
   This deals with the problem of two threads
   simultaneously updating the security data, or
   one thread updating while another thread uses.

I'm told that SE Linux enforces shared security
data. I suppose this is mostly required when
implementing a mandatory system. Is this race-free?
Is there a capability that would allow a suitably
privileged process to have per-thread contexts?

Also, I'm told that a security context can only
change during exec. WHAT???? Besides the case of
a suitably privileged process, what about the
need to move some sort of watermark? AFAIK, your
security context needs to be tainted when you
read low-integrity data and so on.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
