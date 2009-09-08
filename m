Subject: Re: policycoreutils: audit2allow gives bad policy for role
 violations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov, 498320-forwarded@bugs.debian.org,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <878whavayy.fsf@anzu.internal.golden-gryphon.com>
References: <878whavayy.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 10:17:09 -0400
Message-Id: <1252419429.13634.352.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-08-23 at 09:52 -0500, Manoj Srivastava wrote:
> Hi,
> 
>         This has been reported against the Debian BTS.
> =========== ROLES ===============
> role system_r types ssh_exec_t;
> 
>         The above policy is given as the output of audit2allow for the
>  below kernel message:
> 
> type=SELINUX_ERR msg=audit(1220928625.787:79): security_compute_sid:
> invalid context unconfined_u:system_r:user_t:s0-s0:c0.c1023 for
> scontext=unconfined_u:system_r:inetd_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:ssh_exec_t:s0 tclass=process
> 
>         One possibility is to have the following, although it might be
>  best to just flag the error and let the sys-admin decide on their own
>  way of solving it (there are several possibilities that are equally
>  valid): 
> 
>         role_transition system_r ssh_exec_t user_r;
> 
>         manoj
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=498320

The current audit2allow/sepolgen yields the following output on the
above message:
#============= ROLES ==============
role system_r types user_t;

Thus, the bug (incorrect role-type rule) appears to have already been
fixed (seemingly in 2.0.50).

Generating role_transition rules has never been supported by
audit2allow/sepolgen, so that would be a new feature.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
