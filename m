Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NHZCNG022062
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 12:35:12 -0500
Received: from vsmtp1.tin.it (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1NHaUPU016533
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 17:36:31 GMT
Received: from [192.168.0.3] (87.4.127.7) by vsmtp1.tin.it (7.2.072.1)
        id 45DC4ED2002E9961 for selinux@tycho.nsa.gov; Fri, 23 Feb 2007 18:36:23 +0100
Subject: init_t and sshd
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Feb 2007 18:36:27 +0100
Message-Id: <1172252188.10636.9.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, once i solved every problems related to SELinux installation from
scratch i started working on policies for Netwosix.

Here the problem:

vciaglia@vciaglia-desktop:~$ ssh -l vciaglia 192.168.0.4
vciaglia@192.168.0.4's password:
Read from remote host 192.168.0.4: Connection reset by peer
Connection to 192.168.0.4 closed.

In few words i can ssh into my machine only as "root" when i'm in
enforcing mode. So i took a look to the avc denials and audit2allow says
me to add this line to my "init.te":

allow init_t shadow_t:file { getattr read };

So i tried to add the line and rebuild the policy but i get this result:

grep ^portcon tmp/policy.conf.tmp >> policy.conf || true
grep ^netifcon tmp/policy.conf.tmp >> policy.conf || true
grep ^nodecon tmp/policy.conf.tmp >> policy.conf || true
Compiling netwosix policy.21
/usr/bin/checkpolicy policy.conf -o policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
libsepol.check_assertion_helper: assertion on line 147384 violated by
allow init_t shadow_t:file { read };
libsepol.check_assertions: 1 assertion violations occured
Error while expanding policy
make: *** [policy.21] Error 1

I have read that this means that my init.te file includes a rule that
allows sshd, in this case, to read my /etc/shadow file, and this
violates an assertion in the base policy.

How can i solve the problem?

Thank you!

-- 
Vincenzo Ciaglia - <vin(at)netwosix(dot)org>
Linux Netwosix - <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
