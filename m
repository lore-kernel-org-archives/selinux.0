Subject: API for getting loginuid, for use by newrole and run_init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   LSPP <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 24 Jan 2006 08:30:51 -0500
Message-Id: <1138109451.20815.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Are there plans to add an API for getting the loginuid of the current
process (e.g. getluid() or getloginuid()) either to glibc or in a
separate library so that we can easily create and/or modify programs to
get and use the loginuid without needing to directly replicate the code
to read and parse /proc/self/loginuid each time?  In particular, I'd
like to modify newrole and run_init to use the loginuid for the
re-authentication phase rather than the SELinux username, as the latter
is no longer a Linux username at all due to the use of seusers.  newrole
already has a fallback case where if the SELinux username is user_u, it
falls back to the Linux uid, but this isn't sufficiently general, since
we now have other generic SELinux users (e.g. staff_u, sysadm_u), and
the Linux uid isn't as reliable as the loginuid as the fallback case.

Given that other distributions likely aren't using pam_loginuid yet to
set the loginuid at login time, we'll need to still be able to build
versions of newrole and run_init that don't depend on the loginuid, but
when it is supported by the distribution, we should likely just use it
exclusively as the basis for identifying the user to re-authenticate
(which is purely a confirmation of user intent to help counter the risk
of invocation by a trojan, ultimately to be replaced by use of a real
trusted path mechanism when one exists for Linux).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
