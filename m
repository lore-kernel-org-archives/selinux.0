Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6F87NZT014303
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 04:07:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6F87NX0011014
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 08:07:23 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: CVS-2006-3626 local privilege escalation stopped by targeted policy
Date: Sat, 15 Jul 2006 04:07:21 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015882987B8@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <selinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The local privilege escalation from
http://lists.grok.org.uk/pipermail/full-disclosure/2006-July/047907.html
is stopped by selinux targeted policy (both old and reference policy). I
used a rhel4 test vm to demonstrate below. This was released yesterday
so there is no updated kernel rpm yet.

This requires a.out support to exploit, you'll have to grab
binfmt_aout.c from the appropriate kernel sources (it isn't shipped with
RHEL or Fedora) and use a module makefile to build it, then insert it.

Setenforce 0

[jbrindle@rhel4-dev ~]$ id
uid=501(jbrindle) gid=502(jbrindle) groups=502(jbrindle)
context=user_u:system_r:unconfined_t
[jbrindle@rhel4-dev ~]$ ./h00lyshit /bin/ash.static 

preparing
trying to exploit /bin/ash.static

sh-3.00# id
uid=0(root) gid=502(jbrindle) groups=502(jbrindle)
context=user_u:system_r:unconfined_t

(may take a few times to get since it's a race, clear your cache between
tries)

Setenforce 1

[jbrindle@rhel4-dev ~]$ ./h00lyshit /bin/ash.static

preparing
trying to exploit /bin/ash.static

failed: Permission denied


All related denials:

audit(1152957171.464:5): avc:  denied  { setattr } for  pid=6291
comm="h00lyshit" name="environ" dev=proc ino=412286986
scontext=user_u:system_r:unconfined_t
tcontext=user_u:system_r:unconfined_t tclass=file
audit(1152957171.465:6): avc:  denied  { execute } for  pid=6292
comm="h00lyshit" name="environ" dev=proc ino=412286986
scontext=user_u:system_r:unconfined_t
tcontext=user_u:system_r:unconfined_t tclass=file
audit(1152957171.467:7): avc:  denied  { execute_no_trans } for
pid=6292 comm="h00lyshit" name="environ" dev=proc ino=412286986
scontext=user_u:system_r:unconfined_t
tcontext=user_u:system_r:unconfined_t tclass=file



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
