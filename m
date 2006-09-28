Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SJXwwb027465
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 15:33:58 -0400
Received: from ccerelbas02.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SJXOQW020271
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 19:33:24 GMT
Received: from mailrelay01.cce.cpqcorp.net (relay.jp.compaq.com [16.47.68.171])
	by ccerelbas02.cce.hp.com (Postfix) with ESMTP id 09B0D3457E
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:33:58 -0500 (CDT)
Received: from kitche.zk3.dec.com (kitche3.zk3.dec.com [16.140.160.165])
	by mailrelay01.cce.cpqcorp.net (Postfix) with ESMTP id 662DBBF80
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:33:55 -0500 (CDT)
Message-ID: <451C239F.7070003@hp.com>
Date: Thu, 28 Sep 2006 15:33:51 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: SELINUX_ERR using chcon to set a printer to Secret
References: <451C1B7A.7010203@hp.com>
In-Reply-To: <451C1B7A.7010203@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I add the policy:

allow secadm_t printer_device_t:chr_file { getattr relabelfrom relabelto };

I'm able to perform the relabel from secadm_r.  This meets my needs wrt
CUPS, but could one of the policy gurus point what in the policy allows
secadm_r to do this?

thanks
-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
