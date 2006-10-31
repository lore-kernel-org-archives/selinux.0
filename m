Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9VKxOGN029049
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 15:59:24 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9VKvmsE019900
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 20:57:48 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <453E2A8C.4070207@redhat.com>
References: <453E2A8C.4070207@redhat.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 16:00:08 -0500
Message-Id: <1162328409.31675.131.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-24 at 11:00 -0400, Daniel J Walsh wrote:
> flow_in flow_out changes for labeled networking.  Not sure if these are 
> still needed.

Dropped this since labeled networking is still up in the air.

> Added use_lpd_server boolean to eliminate some not needed permissions 
> from cups versions of lpr commands.

I would rather split out the lpr portions out to a lpr module that would
function like the mta module.  Then the rules that aren't common for lpd
and cups can go into optionals.

> Added a userdom_executable_file type so that we can change the ability 
> to execute all commands in MLS, to only be allowed to execute commands 
> that an admin would legitimately like to execute without transition.

I don't like the implementation of this; the idea of a user executable
doesn't make sense to me.  It may be better defining this concept in
terms of executables an admin wouldn't execute.

In addition, the corecmd_exec_all_executables() change breaks the
meaning of the interface.

> Redhat's Fedora Extras apd-get and apt-shell run as rpm.

Can't add this because it causes conflicting file contexts if the dpkg
module is included.

Dropped mcs_killall(rpm_script_t) and mcs_ptrace_all(rpm_script_t) since
it does not have the requisite TE permissions.

> IBM requests javaws and bin under /opt/ibm/java2-ppc64-50/jre be labeled 
> java_exec_t

Dropped the other change; I'm trying to stay away from broad
specifications since it makes more problems for sorting.

> mv dosfs_t to nfs_t needs to work.

You have fs_associate_tmpfs(noxattrfs), which won't do it.  My guess is
that you want something like fs_associate_noxattr(noxattrfs).

> httpd needs to be able to rotatelogs

The problem with this is that it would allow apache to delete its logs.
I suggest trying rotatelogs labeled as logrotate_exec_t instead.

> Major changes to crontab_t to transition to user_tmp_t.  Why do we have 
> a user_crond_t, would just transitioning to user_t make more sense?

I don't know the original intention, but my guess is to be a subset of
the user domain.

> Fixed for oddjob_mkhomedir_t

Why is domain_subj_id_change_exemption(oddjob_t) needed?

> squid wants to rw_tmpfs for diskd mode.

I'm wondering if this is tmpfs_t because there is no squid_tmpfs_t+type
transition, or if it is because the machine is targeted.

> getty needs sys_admin 

I find this very questionable, and the bug you mentioned doesn't have
any good information.

Why does sasl need compute_av?

What program(s) have a dyntrans from unconfined to unconfined_execmem?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
