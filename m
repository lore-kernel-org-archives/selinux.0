Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA22572
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 06:59:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA02753
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 10:57:51 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id KAA02749 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 10:57:51 GMT
Date: Fri, 12 Jul 2002 06:59:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: revising the su decision
In-Reply-To: <20020712020642.D58E442F2@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207120637070.28541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Jul 2002, Russell Coker wrote:

> However now that the sshd policy has been set to default to not allow logins
> as sysadm_r:sysadm_t this causes some inconveniance.  I have to ssh in to my
> server as a non-root account with a non-sysadm_r context.  Then I have to use
> newrole to change to sysadm_r (entering the password), and then I have to su
> to the root account (entering the root password).
>
> This requires entering the password two times (or three if not using ssh
> authorized_keys).

Which is exactly what we want.  You authenticate to the sshd daemon to
login as the user (authenticate user to sshd).  Then, you re-authenticate
to newrole to verify that the user truly wants to change roles
(authenticate user to newrole to ensure that newrole wasn't called by
malicious code unwittingly run by the user or by a compromised sshd).  You
then use su to assume Linux capabilities (authenticate as root user),
which is orthogonal to the SELinux security context (user, role, and
domain).  This is precisely how I have been using SELinux for a long
time.  Hurdles to remote logins with administrator privileges are a good
thing, IMHO.

Notice that you can still directly ssh into a root account if your
sshd_config permits it and then use newrole -r sysadm_r, avoiding the
separate su step.  This works, although you start off without a home
directory and without having run your dotfiles due to a lack of access to
/root.  However, I don't recommend this approach.

> This is excessively painful, and I think that to make SE Linux more usable we
> need to address this issue, possibly by changing su to allow it to change
> roles too.
>
> What do you think?

I think you need to carefully consider what this would mean.  'su'
authenticates the new user identity to control entry to the new Linux uid.
'newrole' re-authenticates the existing SELinux user identity (not the
current Linux uid, and there is no new Linux uid for newrole) to guard
against calls by malicious code; in this newrole case, the control over
entry is truly provided by the policy configuration.  'su' involves a
change only to the Linux uid, not the SELinux user identity.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
