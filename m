Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0LAjac7005069
	for <selinux@tycho.nsa.gov>; Thu, 21 Jan 2010 05:45:45 -0500
Received: from mail-iw0-f184.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0LAjdo3002350
	for <selinux@tycho.nsa.gov>; Thu, 21 Jan 2010 10:45:39 GMT
Received: by iwn14 with SMTP id 14so4761617iwn.18
        for <selinux@tycho.nsa.gov>; Thu, 21 Jan 2010 02:45:41 -0800 (PST)
Message-ID: <4B583096.3010001@gmail.com>
Date: Thu, 21 Jan 2010 02:46:46 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: TaurusHarry <harrytaurus2002@hotmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: Bootup problem with refpolicy-2.20091117 - rules found but still
 can't login
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>,<4B53CEB9.3050207@gmail.com> <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>,<4B543977.40007@gmail.com> <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>,<4B550EB9.50806@gmail.com> <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
In-Reply-To: <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/21/10 01:36, TaurusHarry wrote:
> Hi Justin,
>
> Sorry I respond late, thanks a lot for you to remind to first boot
> SELinux into Permissive mode then analyze the AVC denied messages and
> try to supplement necessary rules, I think it is indeed the
> once-and-for-all solution to any problem of missing SELinux rules.
>
(o.k. had to change the character encoding if you don't mind.)
first things first.. is obviously putting everything into permissive 
mode(boot param=enforcing=0,and /etc/selinux/config*
(which you seem to have done).

> It took me two days to come up with following rules that may be
> desirable to the refpolicy-2.20091117: (or to use dontaudit if they are
> expected redundant behaviors)
>

alright so your using the stable release of refpolicy(apologize if any
typo's... a bit late,and a bit of hops in) ;-)

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
> +fs_manage_tmpfs_sockets(iscsid_t)
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
> +/root -d gen_context(system_u:object_r:user_home_dir_t,s0)
> +/root/.+ gen_context(system_u:object_r:user_home_t,s0)
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

I think the main thing first before customizations is making
sure everything is legit.(but could be wrong);
>
> (BTW, why there are so many types that have missed the "search"
> privilege against tmpfs_t? Any convenient way to solve this problem than
> invoking fs_search_tmpfs() against each type individually?)
>

sounds like a problem with pam_namespace, and xselinux/xsandbox
(did dan think about polyinstantiation as he wrote xsandbox?(no offense))
noticed my home directory is being waxed out with a change of policy 
type(standard/mcs)

> I've tried my best to translate as many AVC denied messages to SELinux
> rules as possible, however, even with all above additional rules
> applied, I still can't log in SELinux in Enforcing mode(the console
> stuck with "INIT: Id "0" respawning too fast: disabled for 5 minutes"),
> and there is NOT a single AVC denied message I could find any more by
> dmesg after log in with enforcing=0! I really don't get it :-(
>

with the namespace, and xsandbox thing I've set-up an new policy, 
relabeled with the new policy and for some reason have been stuck with
user_r:object_r:user_home_t(:s0) in my home dir(anything with name:name 
as the owner)
labeled in .mozilla/.thunderbird,and most of everything that was there
as the original home dir after compiling the policy(but could be my part 
because of keeping a copy of my home directory and copying over , 
because namespace/xsandbox keeps waxing out my home directory(or eating 
it up).

basically I see user_r:object_r:user_home_t(:s0) as the context even 
thoug I've defined my user name/login with semanage.
(but could be missing something);

> What could I have missed out? So far all I know is that neither the
> kernel nor the SELinux tools I used are latest, my kernel is 2.6.27 and
> SELinux tools are of "Release 2009-04-03". Do I need to update kernel
> and SElinux tools in order to use refpolicy-2.20091117? What can I do
> now to solve this problem?
>

best thing is to pull everything from git
git clone http://oss.tresys.com/git/refpolicy.git
git clone http://oss.tresys.com/git/selinux.git

this way everybosy gets a better/updated idea of whats happening
(having policycoreutils 2yrs behind, libselinux might cause issues);

> BTW, I've compiled refpolicy-2.20091117 with "TYPE = standard", while I
> originally wanted to try out the MLS type. I uuss I have to overcome the
> standard type problem before moving on to the MLS type.
>

I would stick with standard just to make things simple
mls does not work with the xserver(but could be wrong), mcs does, but 
just noticed a constraint with changing roles(but have not reported due 
to  making sure I have things legit);

> Any comment is greatly appreciated!
>
> Thanks a lot!
> Harry
>
>


first things first is making sure the policy loads.. so lets focus in
on that(people jump in anytime).

regards,

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
