Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBU9wutx024393
	for <selinux@tycho.nsa.gov>; Sun, 30 Dec 2012 04:58:56 -0500
Received: by mail-ee0-f52.google.com with SMTP id d17so5685969eek.11
        for <selinux@tycho.nsa.gov>; Sun, 30 Dec 2012 01:58:24 -0800 (PST)
Date: Sun, 30 Dec 2012 10:51:58 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Reloading policy fills audit log with "selinux_audit_rule_match:
 stale rule"
Message-ID: <20121230095158.GA6943@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

When I reload the SELinux policy on my system (semodule -R) or rebuild
and reload (semodule -B), for every action I do it generates a dozen or so
errors like the following:

#v+
Dec 30 10:25:24 test kernel: [  181.999527] type=1403 audit(1356859524.575:133): policy loaded auid=0 ses=1
Dec 30 10:25:26 test kernel: [  184.148180] type=1401 audit(1356859526.724:134): selinux_audit_rule_match: stale rule
Dec 30 10:25:26 test kernel: [  184.148180]
Dec 30 10:25:26 test kernel: [  184.148187] type=1401 audit(1356859526.724:135): selinux_audit_rule_match: stale rule
Dec 30 10:25:26 test kernel: [  184.148187]
Dec 30 10:25:26 test kernel: [  184.148191] type=1401 audit(1356859526.724:136): selinux_audit_rule_match: stale rule
Dec 30 10:25:26 test kernel: [  184.148191]
#v-

I am completely lost as to what this is about. Perhaps the audit subsystem
not realising that the SELinux policies have been reloaded? Is there a way
to reload the SELinux audit rules that I don't know about? I've grepped the
kernel sources for audit_rule_init but didn't find anything useful.

I did not have this with 3.6.* kernels (this is on a 3.7 kernel). One
change between the 3.6 and 3.7 kernels that I have is that I enabled
IMA/EVM, but I have the problem even when I disable IMA appraisal
(ima_appraise=off ima_audit=0).

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
