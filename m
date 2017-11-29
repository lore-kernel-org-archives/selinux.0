Message-ID: <1511963505.10464.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 29 Nov 2017 08:51:45 -0500
In-Reply-To: <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 09:33 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> Below is the output of command :
> 
>  sestatus -v output
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             targeted
> Current mode:                   enforcing
> Mode from config file:          permissive
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
> Also I am using ssh session for login.
> 
> Please let me know how to change id command context to unconfined_u
> or Sysadm_u.

So from your earlier message, it is clear that you (or someone else)
has heavily customized your semanage login and user mappings from the
stock targeted policy.  The question is why, and whether you want/need
to retain any of those customizations.  If not, then you could just
delete all local customizations (via semanage or manually) and revert
to a stock policy.

If you do need to retain some of those customizations, then please show
your current semanage login -l and semanage user -l output since you
said you ran some further semanage commands after the last output you
showed.
