Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6PBb8Ha005786
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 07:37:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6PBb7DW025748
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 11:37:07 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
        by jazzband.ncsc.mil  with ESMTP id h6PBb7eN025745 for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 11:37:07 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6PBb6xH015198
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 07:37:06 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6PBb66k015196
	for selinux@tycho.nsa.gov; Fri, 25 Jul 2003 07:37:06 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6P39NHa004779
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 23:09:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6P38GFB017690
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 03:08:16 GMT
Received: from slb-smtpout-01.boeing.com (slb-smtpout-01.boeing.com [130.76.64.48])
	by jazzswing.ncsc.mil  with ESMTP id h6P38FGD017687
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 03:08:15 GMT
Received: from slb-av-02.boeing.com ([129.172.13.7])
	by slb-smtpout-01.boeing.com (8.9.2/8.8.5-M2) with ESMTP id UAA21403
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 20:08:37 -0700 (PDT)
Received: from blv-hub-01.boeing.com (localhost [127.0.0.1])
	by slb-av-02.boeing.com (8.9.3p2/8.9.2/MBS-AV-02) with ESMTP id UAA18683
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 20:09:16 -0700 (PDT)
Received: from redwood.rt.cs.boeing.com (redwood.rt.cs.boeing.com [130.42.35.231])
	by blv-hub-01.boeing.com (8.11.3/8.11.3/MBS-LDAP-01) with ESMTP id h6P37gD00368
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 20:07:42 -0700 (PDT)
Received: from boeing.com (bluesky [130.42.35.61]) by redwood.rt.cs.boeing.com (8.8.8+Sun/RDS-1.0-B2) with ESMTP id UAA18138 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 20:07:42 -0700 (PDT)
Message-ID: <3F209F03.60900@boeing.com>
Date: Thu, 24 Jul 2003 20:07:47 -0700
From: "Paul L. Allen" <paul.l.allen@boeing.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: 2003071106 on RH 7.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I grabbed a copy of the 2003071106 version of SE Linux and attempted
a "make quickinstall" on an old RedHat 7.2 partition.  It got part
way through the build and stopped with a complaint that it could not
find yacc.  So I put "bison -y $*" in /usr/bin/yacc and re-ran the
make.

It went a bit farther, but then stopped with this complaint:

ERROR 'unknown type system_mail_t' at token ';' on line 28350

It's apparently loading a policy.conf file from somewhere under
/etc/security/selinux and doesn't know what "system_mail_t" is.
Well, that makes two of us.  :-)

Since I don't see anybody else on the list talking about this, it
must be my fault.  Can anybody suggest what I might have done wrong
or where to look to fix it?  I've printed a pile of documents on SE
Linux, but have only waded through a bit of it so far.  I'm a long-
time Unix admin and programmer, but am brand-new to SE Linux.

Any help will be appreciated.

Paul Allen
-- 
Boeing Phantom Works                   \ Paul L. Allen, (425) 865-3297
Math & Computing Technology              \ paul.l.allen@boeing.com
POB 3707 M/S 7L-40, Seattle, WA 98124-2207 \ Prototype Systems Group


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
