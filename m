Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3SCurRb005913
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 08:56:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3SCseZx024221
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 12:54:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3SCsdJv024214
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 12:54:39 GMT
Subject: Re: Adding user accounts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nagray@austin.rr.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1083087096.29534.185.camel@hawaii.efficax.net>
References: <1083087096.29534.185.camel@hawaii.efficax.net>
Content-Type: text/plain
Message-Id: <1083156838.25987.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Apr 2004 08:53:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-04-27 at 13:31, Nick Gray wrote:
> This is the procedure I have for adding user accounts.
> 
> #1.  useradd -m developer 
> #2.  passwd developer
> #3. sed -i -e /user\ root/a\ user\ developer\ roles\ \{\ staff_r\ \
> sysadm_r\ \}\; /etc/security/selinux/src/policy/users 
> 
> #4. cd /etc/security/selinux/src/policy
> #5. make policy
> #6. make load
> 
> Is this still necessary?

Have you tried the Tresys setools?  seuser, seuseradd?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
