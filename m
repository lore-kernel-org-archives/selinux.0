Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SIxDC4026424
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:59:13 -0400
Received: from ccerelbas01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SIwdQW015072
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 18:58:39 GMT
Received: from mailrelay01.cce.cpqcorp.net (relay.cpqcorp.net [16.47.68.171])
	by ccerelbas01.cce.hp.com (Postfix) with ESMTP id B8AAA3414A
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 13:59:12 -0500 (CDT)
Received: from kitche.zk3.dec.com (kitche1.zk3.dec.com [16.140.160.161])
	by mailrelay01.cce.cpqcorp.net (Postfix) with ESMTP id 16FC8BE21
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 13:59:10 -0500 (CDT)
Message-ID: <451C1B7A.7010203@hp.com>
Date: Thu, 28 Sep 2006 14:59:06 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELINUX_ERR using chcon to set a printer to Secret
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to develop the policy needed for CUPS to do labeled
printing.  I've already got:

allow sysadm_t printer_device_t:chr_file { relabelfrom relabelto };

With that loaded however I still get the following message in my audit
log when I try to do:

[sysadm_r@orb dev]# chcon -l Secret /dev/lp0

type=SELINUX_ERR msg=audit(1159469257.883:92):
security_validate_transition:  denied for
oldcontext=system_u:object_r:printer_device_t:s0
newcontext=system_u:object_r:printer_device_t:s2
taskcontext=root:sysadm_r:sysadm_t:s0-s15:c0.c255 tclass=chr_file

Is this something that can be allowed in policy?  How can I specify that
I want to authorize sysadm_r to adjust the level of a printer device file?

thanks
-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
