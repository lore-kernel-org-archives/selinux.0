Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA00813
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 13:22:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA13692
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:21:44 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id RAA13687
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:21:43 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Frank Mayer" <mayerf@tresys.com>,
        "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: proposed patch: policy management
Date: Mon, 29 Jul 2002 13:25:19 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMICEAIKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIGEAHKFAA.mayerf@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Attached is the proposed patch I promised for policy management.  To apply
> the patch, use patch -p1 from within the policy directory.  Once applied,
> you should run make install-src and then perform all other
> actions from the
> /etc/security/selinux/src/policy directory.  If you don't
> relabel, the make sure you run:
>
> chcon -R system_u:object_r:policy_src_t /etc/security/selinux/src/policy

If you don't make relabel, you also need to do the following to fix labels.

chcon system_u:object_r:default_context_t /etc/security/default_context
chcon system_u:object_r:load_policy_exec_t
/usr/local/selinux/bin/load_policy
chcon system_u:object_r:checkpolicy_exec_t
/usr/local/selinux/bin/checkpolicy





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
