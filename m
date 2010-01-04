Subject: Re: CentOS 5.4 nfs home directories + cron
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom Boland <tom@t0mb.net>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4B2F901B.1010507@t0mb.net>
References: <4B225A8D.908@t0mb.net>
	 <1260557420.26597.19.camel@moss-pluto.epoch.ncsc.mil>
	 <4B27B377.1000506@t0mb.net>
	 <1260975906.19290.15.camel@moss-pluto.epoch.ncsc.mil>
	 <4B2F901B.1010507@t0mb.net>
Content-Type: text/plain
Date: Mon, 04 Jan 2010 15:34:44 -0500
Message-Id: <1262637284.28009.104.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-12-21 at 15:11 +0000, Tom Boland wrote:
> Hi there,
> 
> I've been battling with this, but don't seem to have much luck.  I've 
> added a default file context for the crontabs in /var/spool/crontab, but 
> this doesn't seem to be honoured.  I've also added rules to allow 
> crontab to transition to the user_t type, but it's not choosing to do 
> so.  I also get permission denied when attempting to set the context 
> with the -s option to crontab.   I'm really confused about this.  Here 
> are my rules so far.

Any errors in /var/log/cron?
Any AVC messages in /var/log/audit/audit.log or /var/log/messages?

> ================================================================
> 
> module cronusertr 1.0;
> 
> require {
>     type crond_t;
>     type user_crontab_t;
>     type nfs_t;
>     type user_t;
>     class file { getattr read write execute unlink create lock 
> relabelfrom relabelto rename entrypoint };
>     class dir { add_name remove_name reparent search rmdir };
>     class process { transition };
> };
> 
> allow crond_t nfs_t:file {getattr read write execute unlink create lock 
> relabelfrom relabelto rename entrypoint };
> allow crond_t nfs_t:dir { add_name remove_name reparent search rmdir };
> allow crond_t user_t:file { getattr read write execute unlink create 
> lock relabelfrom relabelto rename entrypoint };

The above rule should be unnecessary - no files (other than /proc/pid
entries for a process that is running in user_t) should be labeled with
user_t.

> allow crond_t user_t:process { transition };
> allow user_crontab_t user_t:file { getattr read write unlink create lock 
> rename entrypoint };

Likewise.

> allow user_crontab_t user_t:process { transition };

This shouldn't be needed either.
> 
> ================================================================
> 
> Could someone please let me know if I'm on completely the wrong track?  
> I think I must be, as I'm getting absolutely nowhere seemingly.

Let's review:
crond_t is transitioning to user_crond_t under the CentOS 5.4 strict
policy but you want it to transition to user_t.  Yes?

So you need to allow the transition on the type pair, which you seem to
have done, and you need to update your default_contexts entry for crond,
which you seem to have done.  But you also likely need to amend the
policy/constraints file in the strict policy.  I'd have to see your
current one - look at your selinux-policy .src.rpm.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
