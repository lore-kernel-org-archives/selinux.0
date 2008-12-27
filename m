Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBR9YLvm009099
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 04:34:21 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBR9YKZd009421
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 09:34:20 GMT
Received: from [IPv6:2001:6f8:1294:1:211:24ff:fee1:776c] ([IPv6:2001:6f8:1294:1:211:24ff:fee1:776c])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id mBR9YFBl032397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 10:34:15 +0100
Subject: transition policy/logic for shell-, perl- and python-scripts
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 27 Dec 2008 10:34:14 +0100
Message-Id: <1230370454.2932.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone,

I would like to know the policy/logic for transition of e.g. a
Perl-Script. If I write a daemon in Perl, label the file as
daemon_exec_t and execute it using the initrc_t, then the daemon runs
under the daemon_t domain. This SELinux behavior is very convenient.

I would like to know when and how does a transition for such a script
occur?

For example, create a /tmp/test.pl and run it. The file is labeled as 

unconfined_u:object_r:user_tmp_t:s0

but runs as

unconfined_u:unconfined_r:unconfined_t:s0

Therefore, no type transition occurred. Can someone give me a hind?

cheers,
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
