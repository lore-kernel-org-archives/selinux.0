Subject: Re: security_task_getsecid and selinux_get_task_sid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <82670.92517.qm@web36606.mail.mud.yahoo.com>
References: <82670.92517.qm@web36606.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 16:12:26 -0400
Message-Id: <1185999146.15215.375.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 12:49 -0700, Casey Schaufler wrote:
> Is there any difference between calls to security_task_getsecid() and
> selinux_get_task_sid() with selinux installed? It doesn't look like
> there is, but I could be missing something.

No, there is known duplication between the direct SELinux exports and
certain LSM hooks, a consequence of audit going one direction and
labeled networking going the other.  On our todo list for cleanup unless
you get to it first.  Same thing applies for e.g.
security_secid_to_secctx vs. selinux_sid_to_string.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
