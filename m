Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8QHtiNs015755
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 13:55:44 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8QHoRuQ017940
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 17:50:27 GMT
Subject: reserved_port_type attribute
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 13:50:38 -0400
Message-Id: <1127757038.32172.22.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

According to attrib.te, reserved_port_type is supposed to be for ports
that are less than 1024.  Why is reserved_port_t not included?  Also,
http_cache_port_t, ptal_port_t, clamd_port_t, pyzor_port_t, and
dbskkd_port_t aren't labeling any ports below 1024 (dbskkd_port_t
doesn't even have a portcon), so why have they been given this
attribute?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
