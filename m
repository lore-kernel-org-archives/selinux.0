Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2UEjNRb012345
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 09:45:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2UEjLOl016109
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 14:45:21 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i2UEjKkH016101 for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 14:45:20 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i2UEjK1X012638
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 09:45:20 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i2UEjJj07106
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 09:45:19 -0500
Received: from thoron.boston.redhat.com (thoron.boston.redhat.com [172.16.65.238])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i2UEjHVj018790
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 09:45:17 -0500
Date: Tue, 30 Mar 2004 09:45:17 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: selinux@tycho.nsa.gov
Subject: IPv6 support available
Message-ID: <Xine.LNX.4.44.0403300942280.20550-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A set of preliminary patches providing IPv6 support may be found at:
http://people.redhat.com/jmorris/selinux/ipv6/

The kernel patch requires recent -mm kernels, and ipv6-exthdrs-core.patch 
needs to be applied if IPv6 is compiled as a module.

The kernel patches are expected to be submitted to mainline after 2.6.5 is 
released.

Any review or testing of the IPv6 code will be appreciated.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
