Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i06Et4Rb009164
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 09:55:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i06EsqiV029299
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 14:54:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i06Esq06029296 for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 14:54:52 GMT
Subject: Re: modification of vixie-cron patch to get crond working in
	permissive mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>, Eamon Walsh <ewalsh@epoch.ncsc.mil>
In-Reply-To: <200401011705.12427.arekm@pld-linux.org>
References: <200401011705.12427.arekm@pld-linux.org>
Content-Type: text/plain
Message-Id: <1073400871.3476.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 09:54:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-01 at 11:05, Arkadiusz Miskiewicz wrote:
> This patch should be applied after fedora core selinux patch for vixie-cron 
> (probably the same as on nsa.gov/selinux page).
> 
> It changes behaviour when running selinux in permissive mode. Until now when 
> there were no known context with which jobs should be executed then error 
> message was logged and crontab file was skipped. Now error message is logged 
> but jobs are still run.
> 
> It's better to have working crond + bunch of log messages instead of not 
> usable crond.
> 
> Please apply + rediff new selinux patch.

I doubt that we want to fork the error handling on each operation into
separate cases for enforcing vs. permissive.  The only case where this
might be reasonable is the entrypoint permission check, since this is
essentially emulating a kernel check in userspace to deal with the fact
that crontab files are not directly executed.  In the future, I would
expect this to be encapsulated in the userspace AVC, so that the
application code can just call avc_has_perm, and the AVC will internally
check the enforcing flag and handle it, as in the kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
