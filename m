Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02189
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 08:31:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA20902
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 12:30:21 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id MAA20898
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 12:30:21 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Russell Coker" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: adduser??
Date: Thu, 8 Aug 2002 08:33:07 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIOEDMKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020807124111.9FC8D2800@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> So do you have patches to adduser to use the correct contexts for files?
>
> Currently I have the following contexts:
> /home                           system_u:object_r:root_t
> /home/[^/]*     -d              system_u:object_r:user_home_dir_t
> /home/.*/.*                     system_u:object_r:user_home_t
> /home/[^/]*/.ssh(|/.*)          system_u:object_r:user_home_ssh_t
> /home/[^/]*/.gnupg(|/.*)          system_u:object_r:user_gpg_secret_t

No but that's a great idea...having add user use its configuration files to
established file contexts for user home dirs based on their default
type...just one more item for the wish list.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
