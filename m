Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15579
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 12:07:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA16306
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 16:05:40 GMT
Received: from rj.sgi.com (rj.SGI.COM [192.82.208.96])
	by jazzswing.ncsc.mil  with ESMTP id QAA16302
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 16:05:40 GMT
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with ESMTP id g41E7J1b016836
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 07:07:20 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [163.154.6.121])
	by cthulhu.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id JAA40448
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 09:07:28 -0700 (PDT)
Received: from changeling.engr.sgi.com (changeling.engr.sgi.com [163.154.6.122])
	by morgaine.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id JAA24538
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 09:07:28 -0700 (PDT)
Date: Wed, 01 May 2002 09:07:28 -0700
From: richard offer <offer@sgi.com>
To: selinux@tycho.nsa.gov
Subject: /usr/bin/checkpolicy ?
Message-ID: <596920000.1020269248@changeling.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I downloaded selinux-2.4.18-2002031409.src.rpm and tried to rebuild it (on
a uptodate RH 7.2 machine)

    rpm --rebuild selinux-2.4.18-2002031409.src.rpm

and got

....

m4 -Imacros -s
/var/tmp/selinux-2.4.18-root/usr/lib/selinux/security_classes
/var/tmp/selinux-2.4.18-root/usr/lib/selinux/initial_sids
/var/tmp/selinux-2.4.18-root/usr/lib/selinux/access_vectors all.te rbac
users constraints initial_sid_contexts fs_contexts devfs_contexts
net_contexts > policy.conf
/usr/bin/checkpolicy -o policy policy.conf
make: /usr/bin/checkpolicy: Command not found
make: *** [policy] Error 127
error: Bad exit status from /var/tmp/rpm-tmp.62266 (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.62266 (%build)



Shouldn't there be a BuildRequires: rule for checkpolicy ? And it so, it
would need to be in a separate (tools ?) package.


richard.

-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
