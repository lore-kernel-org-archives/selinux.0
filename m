Subject: Re: MCS and unconfined_t
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <russell@coker.com.au>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <442B5714.9080100@kaigai.gr.jp>
References: <442933AD.3040208@kaigai.gr.jp>
	 <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
	 <1143649773.13732.30.camel@sgc.columbia.tresys.com>
	 <1143650740.24555.5.camel@moss-spartans.epoch.ncsc.mil>
	 <1143655164.13732.36.camel@sgc.columbia.tresys.com>
	 <442B5714.9080100@kaigai.gr.jp>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 07:31:57 -0500
Message-Id: <1143721917.24555.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-30 at 12:57 +0900, KaiGai Kohei wrote:
> +mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
> +		( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t ) or
> +		( t1 == kernel_t ));
> 
> It says an process can transit to more restricted categories only
> by (h1 dom h2). I felt it's over restriction.
> For example, a user login with 's0' cannot transit to any wider range
> categories, even if he would be allowed to belong 's0-s0:c0.c2' at most.
> 
> I modified my desktop environment (FC5). At a moment, the following
> configuration seems to me working fine.
> Do you think it's a reasonable solution ?

The reason that we need the stronger restriction above is that there is
not a one-to-one mapping from Linux users to SELinux users, and we are
now relying on the seusers mapping and initial setup by login to bound
what is reachable by a given Linux user.  For example, two different
Linux users might be mapped to user_u but with different category sets
by seusers, and the underlying policy will authorize user_u for the
combination of those category sets so that both security contexts are
valid.  Thus, if we allow the process to later escalate its categories
to anything permitted in the security context by policy, it can escape
the per-Linux-user restrictions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
