Message-ID: <1512405173.20988.31.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 04 Dec 2017 11:32:53 -0500
In-Reply-To: <CAPMH7-_pGOPjqLPuiwTE5S7WgkH8WsTeNtuz6OeGF=K0Dz6rtw@mail.gmail.com>
References: <CAPMH7-9ci7BmMNLrFDcbKVsj+oYQW_e4h942UFK1VL1O99R1gQ@mail.gmail.com>
 <1512402299.20988.23.camel@tycho.nsa.gov>
 <1512403233.20988.25.camel@tycho.nsa.gov>
 <CAPMH7-_pGOPjqLPuiwTE5S7WgkH8WsTeNtuz6OeGF=K0Dz6rtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Issue regarding Selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-12-04 at 21:45 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> sestatus -v
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             targeted
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy MLS status:              enabled
> Policy deny_unknown status:     allowed
> Max kernel policy version:      28
> 
> Process contexts:
> Current context:                system_u:system_r:unconfined_t:s0-
> s0:c0.c1023
> Init context:                   system_u:system_r:init_t:s0
> /usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> s0:c0.c1023
> 
> File contexts:
> Controlling terminal:           system_u:object_r:sshd_devpts_t:s0
> /etc/passwd                     system_u:object_r:passwd_file_t:s0
> /etc/shadow                     system_u:object_r:shadow_t:s0
> /bin/bash                       system_u:object_r:shell_exec_t:s0
> /bin/login                      system_u:object_r:login_exec_t:s0
> /bin/sh                         system_u:object_r:bin_t:s0 ->
> system_u:object_r:shell_exec_t:s0
> /sbin/agetty                    system_u:object_r:getty_exec_t:s0
> /sbin/init                      system_u:object_r:bin_t:s0 ->
> system_u:object_r:init_exec_t:s0
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> /lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> system_u:object_r:lib_t:s0
> /lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> system_u:object_r:ld_so_t:s0
> 
> 
>  rpm -q libselinux
> libselinux-2.5-6.el7.i686
> libselinux-2.5-6.el7.x86_64
> 
> Please let me know if you want any other details .

Ok, so this is the same system that has the wrong ssh login context
(per your Current context" and "Controlling terminal" lines above. So
likely the same root cause as that problem.  Look for sshd errors in
/var/log/secure or journalctl, run selinuxdefaultcon as I described to
see whether you can reproduce the incorrect context computation.
