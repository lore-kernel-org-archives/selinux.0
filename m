Subject: RE: Bootup problem with refpolicy-2.20091117 - rules found but
 still can't login
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: justinmattock@gmail.com, selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy@oss1.tresys.com
In-Reply-To: <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>
	 ,<4B53CEB9.3050207@gmail.com> <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>
	 ,<4B543977.40007@gmail.com> <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>
	 ,<4B550EB9.50806@gmail.com>  <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
Content-Type: text/plain
Date: Thu, 21 Jan 2010 08:19:55 -0500
Message-Id: <1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-21 at 09:36 +0000, TaurusHarry wrote:
> Hi Justin,
> 
> Sorry I respond late, thanks a lot for you to remind to first boot
> SELinux into Permissive mode then analyze the AVC denied messages and
> try to supplement necessary rules, I think it is indeed the
> once-and-for-all solution to any problem of missing SELinux rules.
> 
> It took me two days to come up with following rules that may be
> desirable to the refpolicy-2.20091117: (or to use dontaudit if they
> are expected redundant behaviors)
> 
> +allow crond_t self:capability { dac_override setgid setuid sys_nice
> dac_read_search audit_control };
> 
> +corecmd_bin_domtrans(crond_t)
> +hostname_domtrans(crond_t)
> +corecmd_getattr_bin_files(crond_t)
> +corecmd_exec_bin(crond_t)
> +corecmd_manage_bin_files(crond_t)
> +fs_search_tmpfs(crond_t)
> +fs_manage_tmpfs_sockets(crond_t)
> 
> +dontaudit quota_t self:memprotect { mmap_zero} ;
> 
> +fs_search_tmpfs(getty_t)
> 
> +term_use_console(insmod_t)
> 
> +fs_search_tmpfs(iscsid_t)
> +fs_manage_tmpfs_sock! ets(iscsid_t)
> 
> +files_rw_lock_dirs(mount_t)
> +files_manage_generic_locks(mount_t)
> 
> +fs_search_tmpfs(pam_console_t)
> +fs_getattr_tmpfs_dirs(pam_console_t)
> +fs_manage_tmpfs_dirs(pam_console_t)
> 
> +fs_search_tmpfs(portmap_t)
> 
> +/root        -d    gen_context(system_u:object_r:user_home_dir_t,s0)
> +/root/.+        gen_context(system_u:object_r:user_home_t,s0)
> 
> +fs_search_tmpfs(sendmail_t)
> +fs_manage_tmpfs_sockets(sendmail_t)
> 
> +term_read_console(setfiles_t)
> 
> +fs_search_tmpfs(syslogd_t)
> +fs_manage_tmpfs_dirs(syslogd_t)
> +fs_manage_tmpfs_sockets(syslogd_t)
> 
> +fs_search_tmpfs(sysstat_t)
> 
> (BTW, why there are so many types that have missed the "search"
> privilege against tmpfs_t? Any convenient way to solve this problem
> than invoking fs_search_tmpfs() against each type individually?)
> 
> I've tried my best to translate as many AVC denied mess! ages to
> SELinux rules as possible, however, even with all above additi onal
> rules applied, I still can't log in SELinux in Enforcing mode(the
> console stuck with "INIT: Id "0" respawning too fast: disabled for 5
> minutes"), and there is NOT a single AVC denied message I could find
> any more by dmesg after log in with enforcing=0! I really don't get
> it :-( 
> 
> What could I have missed out? So far all I know is that neither the
> kernel nor the SELinux tools I used are latest, my kernel is 2.6.27
> and SELinux tools are of "Release 2009-04-03". Do I need to update
> kernel and SElinux tools in order to use refpolicy-2.20091117? What
> can I do now to solve this problem?
> 
> BTW, I've compiled refpolicy-2.20091117 with "TYPE = standard", while
> I originally wanted to try out the MLS type. I uuss I have to overcome
> the standard type problem before moving on to the MLS type.
> 
> Any comment is greatly appreciated!

refpolicy questions go to refpolicy@oss.tresys.com (cc'd).

I would recommend updating your SELinux userspace to the latest released
version and rebuilding your policy, and also booting permissive and
performing a complete filesystem relabel.

Your tmpfs denials suggest that you have a tmpfs mount that is not being
properly labeled.  For example, if you are using a tmpfs mount on /dev,
then it usually needs to have restorecon -R /dev applied during early
boot (from rc.sysinit in Fedora) or to be mounted with a rootcontext=
option.  ls -Z /dev would be interesting, as would cat /proc/mounts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
