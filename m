Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02389
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 14:35:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA10781
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:34:29 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA10773 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:34:28 GMT
Date: Wed, 6 Mar 2002 14:34:27 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: invalid contaxt
In-Reply-To: <20020306191008.AB1B41F08D@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203061422310.15401-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 6 Mar 2002, Russell Coker wrote:

> When I load a new policy I get the following message in syslog:
> Mar  6 19:18:05 lyta kernel: security:  context
> system_u:system_r:sysadm_ssh_t is invalid
>
> Here is how I try and find the cause of the message:
> root@lyta:/etc/flask# list_sids |grep sysadm_ssh_t
> SID 256 -> Scontext  system_u:system_r:sysadm_ssh_t
> root@lyta:/etc/flask# ps ax --secsid  | grep 256
> 13654    248 grep 256
> root@lyta:/etc/flask#
>
> So it seems that I have not process using SID 256!
>
> What am I doing wrong?

Look for a message in the log of the form:
	security_compute_sid:  invalid context %s for scontext=%s tcontext=%s tclass=%s

When in permissive mode, the kernel will log such a message but permit the
SID to be created anyway.  Then, on subsequent policy reloads, you'll get
another warning about the context (as in your message) being invalid.

sysadm_ssh_t is a domain entered when a sysadm_t process runs the ssh
program.  The example policy only authorizes the sysadm_r role for this
domain, since ssh is typically run from a user session whose user identity
and role have been set by login (or sshd).  If you ran ssh from a
single-user shell or you aren't using a modified login/sshd, then you'll
still have the system_u:system_r user identity and role, so you'll get
this error.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
