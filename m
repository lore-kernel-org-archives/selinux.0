Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FENZI4026409
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 10:23:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3FENY7R016284
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:23:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3FENYKP016281 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:23:34 GMT
Subject: Re: auditallow
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200304141822.43798.russell@coker.com.au>
References: <200304141822.43798.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1050416640.1051.12.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Apr 2003 10:24:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-04-14 at 04:22, Russell Coker wrote:
> auditallow sysadm_mail_t var_run_t:dir search;
> 
> I put the above rule in my policy, but then see the following in my dmesg 
> output:
> 
> Apr 14 18:16:21 caesar kernel: avc:  denied  { search } for  pid=8716 
> exe=/usr/sbin/sendmail path=/run dev=09:03 ino=2593 
> scontext=root:sysadm_r:sysadm_mail_t tcontext=system_u:object_r:var_run_t 
> tclass=dir
> 
> Surely it should be reporting "granted" not "denied".
> 
> The machine in question is running with the kernel patch from the January 
> release of SE Linux.  But I have reproduced the same situation on a machine 
> running the latest release.

auditallow does not imply allow.  There are three kinds of access
vectors:
1) allow - specifies the set of permissions that are granted, defaults
to none (deny everything unless explicitly allowed by an allow rule),
2) auditallow - specifies the set of permissions that should be audited
when granted, defaults to none (audit no grantings unless explicitly
enabled by an auditallow rule),
3) auditdeny - specifies the set of permissions that should be audited
when denied, defaults to all (audit all denials unless explicitly
disabled by a dontaudit rule, formerly handled by the auditdeny rules
with the complement).

The policy compiler could automatically generate an allow vector for
each auditallow rule, but I'd rather not.  Add a separate allow rule to
the configuration.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
