Subject: Re: [PATCH] Lazy config init in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <965532.95521.qm@web51507.mail.yahoo.com>
References: <965532.95521.qm@web51507.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 13:11:27 -0500
Message-Id: <1172599888.19041.382.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-27 at 09:28 -0800, Steve G wrote:
> >- I'm not clear that __libc_once is intended to be a stable API/ABI
> >provided by glibc, 
> 
> We could copy it into a private header. Its a convenience wrapper around
> pthread_once, so moving it to a private header would guarantee its stability.

I'm a bit confused then - why doesn't that introduce a dependency on
libpthread?

> >- I'm not clear on what overhead this imposes upon the functions that
> >need to be guarded by __libc_once, and what the tradeoff is for real
> >workloads.
> 
> I have to ask how often something really needs to know the setting of targeted or
> strict that is performance critical. I'd rather see the development tools or
> rarely used utilities take the hit in favor of runtime performance of everything
> else. There are far more users of "ls" than semodule.

If it is only "development tools or rarely used utilities", then yes.
But I think we need to assess whether that is the case - I don't think
we know yet what the overall impact is.

> >We can certainly audit all uses now and add such guards, but I'm a
> >little concerned about the maintainability of this approach long term.
> 
> I did the audit yesterday to make sure everything was covered. Please double
> check me since this is important. During the audit, I was also wondering about
> /etc/security and whether that should die now. Moving the macro into a private
> header should aleviate external dependencies.

init_selinux_config() also sets several flags based
on /etc/selinux/config that are used by other functions, and you don't
appear to have explicitly added guards for them, although some end up
hitting a guard due to prior call to a path function.  The one that
looks particularly worrisome is the cache_trans flag, used by the
context translation functions, which in turn are called pervasively to
translate contexts when they are passed into or out of libselinux.  If
we add a guard to those functions, we'll essentially hit the guard on
almost every libselinux function call, just not is_selinux_enabled().

I assume too that __libc_once() or its equivalent is going to have
different impact depending on whether the application is actually
multi-threaded or not, so it would be interesting to see what impact it
has in the multi-threaded case, even if that is less common.

I'm not trying to block performance improvement, but we do need to first
understand the implications of the change, in terms of overall
performance impact, correctness, and maintainability.  That's all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
