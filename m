Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01517
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 07:51:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA27510
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 11:50:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA27506
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 11:50:44 GMT
Date: Mon, 24 Jun 2002 07:50:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: Re: Default policy under debian
In-Reply-To: <002c01c21974$eed40bd0$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0206240717270.10386-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002, Ed Street wrote:

> Just to let everyone know, using woody bf2.4 minimal install with
> selinux we found remote root could execute /sbin/poweroff

Can you clarify what you mean by this statement?  "Remote root" is
ambiguous, as there is a difference between having the Linux root uid and
having the SELinux root user identity, and you also need to specify the
role and domain.  Notice that processes with the Linux root uid do
not necessarily have the SELinux root user identity, since the
identities are independent.  The SELinux user identity can only be
set by certain TE domains such as login and sshd, and the SELinux
root user identity is not assigned to system processes or setuid
root programs executed by ordinary user processes.  "Execute
/sbin/poweroff" is also ambiguous, as there is a difference between having
execute permission to /sbin/poweroff (relatively unimportant) and having
the necessary permissions to truly power off the system.

If you simply mean that a person who can authenticate as the root user can
power off the system, then that is no surprise.  The example policy
authorizes the SELinux root user identity for sysadm_r (see policy/users)
for direct logins as root:sysadm_r:sysadm_t, and the example policy
authorizes sshd_t to transition to sysadm_t for remote administration (see
the domain_trans rule in policy/domains/program/sshd.te).

You can certainly remove the corresponding domain_trans rule from sshd.te
if you do not wish to permit remote administrator shells, although you
would also need to do something about newrole if you want to completely
prevent the use of newrole by remote sessions (e.g. setting up a separate
user domain for remote shells that cannot transition to newrole_t).

You can also remove sysadm_r from the authorized roles for root in
policy/users if you are willing to always login under an ordinary user
account and use su (plus newrole, if you don't login directly as sysadm_r)
for administration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
