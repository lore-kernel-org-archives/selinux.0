Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8334WLa021632
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 23:04:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8334Vet006269
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 03:04:31 GMT
Received: from ns.sonata.iscas.ac.cn ([159.226.5.83])
        by jazzband.ncsc.mil  with ESMTP id h8334Klq006260 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 03:04:21 GMT
Received: from smy.sonata.iscas.ac.cn (smy.sonata.iscas.ac.cn [192.9.200.21])
	by ns.sonata.iscas.ac.cn (8.9.3/8.8.7) with ESMTP id LAA04938
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 11:31:37 -0400
From: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>
To: selinux@tycho.nsa.gov
Subject: Data type changed?
Date: Wed, 3 Sep 2003 11:00:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309031100.47270.yanjunwu@sonata.iscas.ac.cn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


In Linux-2.6.0-test4, I see selinux changed the type of basic data structures 
significantly.  eg. turn security_id_t, access_vector_t, security_class_t, 
etc. back to their protoypes.Could any one tell me what's the reason? and 
will these changes be permanent?

-- 
Best regards,
Wu Yanjun
---------------------------------------------------------------
Open System and Chinese Information Processing Center,
Institute of Software, Chinese Academy of Sciences,
P.O. Box 8718, Beijing 100080, CHINA
Phone: 62544129/62647145/62638063-42(Lab), 82137436(Dorm)
----------------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
