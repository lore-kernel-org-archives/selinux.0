Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAGDVcRb002397
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 08:31:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAGDV3Bb012013
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 13:31:03 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAGDV34o012010
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 13:31:03 GMT
Date: Sun, 16 Nov 2003 13:31:09 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: policy bug
Message-ID: <20031116133109.GE17041@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's another for you Russ. Fresh from today:

ERROR 'name conflict for type run_init_conf_t' at token ';' on line 42023:

type run_init_conf_t, file_type, sysadmfile;
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.15] Error 1

Let me know if you need any other specifics.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
