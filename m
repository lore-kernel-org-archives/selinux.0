Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09174
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 16:11:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA27544
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 20:10:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id UAA27540 for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 20:10:13 GMT
Date: Tue, 30 Jul 2002 16:11:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: proposed patch: policy management
In-Reply-To: <Pine.GSO.4.33.0207301342510.1806-100000@raven>
Message-ID: <Pine.GSO.4.33.0207301607550.14015-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


One other thought:  You might want to define a file_type_auto_trans rule
for checkpolicy_t and policy_src_t, to permit checkpolicy to create files
in the policy source directory while placing those files into a different
type.  You could use file_type_auto_trans(checkpolicy_t, policy_src_t,
policy_config_t) to directly place these files into the policy_config_t
type.  Or you could define a different type for this purpose.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
