Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h33LrUx6002969
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 16:53:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h33LnpOv019982
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:49:51 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h33LnpY1019979
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:49:51 GMT
Message-Id: <200304032201.RAA25118@moss-shockers.ncsc.mil>
Date: Thu, 3 Apr 2003 17:01:04 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: policy
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> can_exec(crond_t, sbin_t);
> Why was the above rule added to crond.te?

Good question.  Looks like a mistake when they removed can_exec_any
from system_crond_t and were adding individual can_exec rules.

> allow $1_t sshd_tmp_t:file create_file_perms;
> The above rule from macros/user_macros.te looks dangerous.  We have the type 
> sshd_tmp_t being used for all user domains.

Agreed, I've removed this from our internal tree.  It appears that this
is also granted to some program domains, e.g. the su domains and the
ssh client domains.

> Could the following please be added to initrc.fc:
> /etc/nologin.*                 system_u:object_r:etc_runtime_t
> /etc/nohotplug                 system_u:object_r:etc_runtime_t

Yes, I've made this change to our internal tree.

--
Stephen Smalley, NSA



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
