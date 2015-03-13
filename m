Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DIQqwA001252
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 14:26:52 -0400
Message-ID: <55032BCD.7090103@tycho.nsa.gov>
Date: Fri, 13 Mar 2015 14:26:21 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
In-Reply-To: <20150313181459.GB9437@linksys-wireless-usb.network2>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2015 02:15 PM, Dominick Grift wrote:
> I was playing with systemd-nspawn/machine, and machinectl allows one to pull in images. I am trying to confine it and i hit issues:
> 
> systemd runs systemd-importd, and systemd-importd runs systemd-pull
> 
> It seems as if though its some multithreading going on because i get:
> 
> type=SELINUX_ERR msg=audit(1426268982.258:2559): op=security_bounded_transition seresult=denied oldcontext=system_u:system_r:systemd_t newcontext=system_u:system_r:importd_t
> 
> Even though I am in permissive mode, and a transition rule "allow systemd_t importd_t:process transition;" is present, SELinux does not transition.
> 
> When i add a typebounds statement (typebounds systemd_t importd_t), then the scenario changes:
> 
> type=SELINUX_ERR msg=audit(1426268121.044:2414): op=security_compute_av reason=bounds scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process perms=transition
> ----
> type=AVC msg=audit(1426268121.044:2415): avc:  denied  { transition } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process permissive=1
> ----
> type=SELINUX_ERR msg=audit(1426268121.044:2416): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file perms=entrypoint
> ----
> type=AVC msg=audit(1426268121.044:2417): avc:  denied  { entrypoint } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file permissive=1
> ----
> type=SELINUX_ERR msg=audit(1426268121.046:2418): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd perms=use
> ----
> type=AVC msg=audit(1426268121.046:2419): avc:  denied  { use } for  pid=9210 comm="systemd-importd" path="/dev/null" dev="devtmpfs" ino=1028 scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd permissive=1
> 
> These rules are present in the policy (the transition is obviously taking place in permissive mode) and so is the typebounds rule, but access looks still denied.
> 
> I do not understand what is going on here.
> 
> First of all importd_t is bounded to systemd. So why does it appear to be a problem that systemd operates on importd_t entities?
> 
> Also why does selinux refuse to type transition without a typebounds, and why does it give me a permission denied with a typebounds 

NO_NEW_PRIVS?  See http://marc.info/?l=selinux&m=140717412324539&w=2
Previously domain transitions on exec were always disabled under
NO_NEW_PRIVS and nosuid mounts.  This was introduced as a way of
supporting e.g. the SELinux sandbox or other cases where NNP is being
used and they want to transition domains on exec.  Typebounds makes this
safe, but typebounds requires you to cap the child type's permissions to
a subset of the parent type's permissions.  This is normally checked by
checkpolicy or libsemanage at policy build/link time but I'm sure Red
Hat has disabled it along with neverallow checking, so you probably
don't see it until the kernel recognizes the discrepancy and dynamically
blocks the access that would violate the bound.
