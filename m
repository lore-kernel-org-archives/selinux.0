Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2VMxx5h003169
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 18:59:59 -0400
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2VMxug2019269
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 22:59:56 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m2VMx3IO011528
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 18:59:03 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m2VMwtgQ002766
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 18:58:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: SSH + file_contexts + kerberos
Date: Mon, 31 Mar 2008 15:59:47 -0700
Message-ID: <4AE25A7D8CBE4E4DA8E87173237DE27E8B91@blums0042.bluelnk.net>
From: "Karrels, Jeffrey J \(US SSA\)" <jeffrey.karrels@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone.

I have two questions:

1) Is there a preferred way to search this lists archives?

2) I have a problem I could use a pointer on. I am using the 1217
reference policy on Machine A. I have a script on Machine A that
attempts to SSH into another Machine B with an older policy on it (set
in permissive mode). When I set Machine A to enforcing and call the
script, when the SSH gets called I get:
file_contexts: invalid context system_u:object_r:krb5_conf_t:s0.

I am assuming that this is because Machine B does not know of type
krb5_conf_t. Is there a way to still SSH from Machine A to Machine B
without updating Machine B's policy? 

Thanks
Jeff Karrels 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
