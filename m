Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l333SeMs007445
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 23:28:40 -0400
Received: from mu-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l333Sdk2010783
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 03:28:40 GMT
Received: by mu-out-0910.google.com with SMTP id w1so1653233mue
        for <selinux@tycho.nsa.gov>; Mon, 02 Apr 2007 20:28:39 -0700 (PDT)
Message-ID: <9d1b82480704020912q268428eao9655fe824797b2f2@mail.gmail.com>
Date: Mon, 2 Apr 2007 21:42:06 +0530
From: Pravin <shindepravin@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Compatibility between binary policy file and kernel version
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <1175526715.5889.55.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9d1b82480704020747v1f05b267j874c4bb2d3f1f941@mail.gmail.com>
	 <1175526715.5889.55.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/2/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2007-04-02 at 20:17 +0530, Pravin wrote:
> > Hi,
> > I am facing some problems with compatibility between binary policy
> > file and kernel version.
> >
> > I have properly working selinux with kernel 2.6.19.
> > But When I use kernel 2.6.18 or 2.6.20, the filesystem labels r not recognized.
> > These kernels shows the default labels like
> > "system_u:object_r:unlabeled_t:s0" but same object shows proper label
> > in kernel 2.6.19.
>
> Can you give a specific example of such a label?
Yes, I am giving u the output of "ls -Z /" command on same filesystem
with different kernel, and u can see the difference in label that each
kernel is picking up.

This is kernel linux-2.6.19, here most of the directories are labeled properly.
{{{
sh-3.1# ls -Z /
-rwxr-xr-x  root root system_u:object_r:xattrfs_t:s0   a.out
drwxr-xr-x  root root system_u:object_r:dir_bin_t:s0   bin
drwxr-xr-x  root root system_u:object_r:boot_t:s0      boot
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 config
drwxr-xr-x  root root system_u:object_r:initrc_tmpfs_t:s0 dev
drwxr-xr-x  root root system_u:object_r:dir_etc_t:s0   etc
-rw-r--r--  root root system_u:object_r:xattrfs_t:s0   forkloop.c
drwxr-xr-x  root root system_u:object_r:dir_homedir_rootdir_t:s0 home
drwxr-xr-x  root root system_u:object_r:dir_lib_t:s0   lib
drwx------  root root system_u:object_r:xattrfs_t:s0   lost+found
-rw-r--r--  root root system_u:object_r:xattrfs_t:s0   lsof_output
drwxr-xr-x  root root system_u:object_r:media_t:s0     media
drwxr-xr-x  root root system_u:object_r:autofs_t:s0    misc
drwxr-xr-x  root root system_u:object_r:mnt_t:s0       mnt
drwxr-xr-x  root root system_u:object_r:autofs_t:s0    net
drwxr-xr-x  root root system_u:object_r:xattrfs_t:s0   nn
drwxr-xr-x  root root system_u:object_r:opt_t:s0       opt
-rw-r--r--  root root system_u:object_r:xattrfs_t:s0   out
dr-xr-xr-x  root root system_u:object_r:proc_t:s0      proc
drwxr-x---  root root system_u:object_r:dir_root_t:s0  root
drwxr-xr-x  root root system_u:object_r:dir_sbin_t:s0  sbin
drwxr-xr-x  root root system_u:object_r:security_t:s0  selinux
drwxr-xr-x  root root system_u:object_r:srv_t:s0       srv
drwxr-xr-x  root root system_u:object_r:sysfs_t:s0     sys
-rw-r--r--  root root system_u:object_r:xattrfs_t:s0   test1.sh
-rwxr-xr-x  root root system_u:object_r:xattrfs_t:s0   test.sh
drwxrwxrwt  root root system_u:object_r:initrc_tmpfs_t:s0 tmp
-rw-r--r--  root root system_u:object_r:xattrfs_t:s0   tt.c
-rw-r--r--  root root system_u:object_r:xattrfs_t:s0   tttt
drwxr-xr-x  root root system_u:object_r:dir_usr_t:s0   usr
drwxr-xr-x  root root system_u:object_r:dir_var_t:s0   var
sh-3.1#
}}}
And here is the output for linux-2.6.18.
Most of the folders are unlabeled here.
{{{
sh-3.1# ls -Z /
-rwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 a.out
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 bin
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 boot
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 config
drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     dev
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 etc
-rw-r--r--  root root system_u:object_r:unlabeled_t:s0 forkloop.c
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 home
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 lib
drwx------  root root system_u:object_r:unlabeled_t:s0 lost+found
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 media
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 misc
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 mnt
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 net
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 nn
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 opt
-rw-r--r--  root root system_u:object_r:unlabeled_t:s0 out
dr-xr-xr-x  root root system_u:object_r:proc_t:s0      proc
drwxr-x---  root root system_u:object_r:unlabeled_t:s0 root
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 sbin
drwxr-xr-x  root root system_u:object_r:security_t:s0  selinux
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 srv
drwxr-xr-x  root root system_u:object_r:sysfs_t:s0     sys
-rw-r--r--  root root system_u:object_r:unlabeled_t:s0 test1.sh
-rwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 test.sh
drwxrwxrwt  root root system_u:object_r:tmp_t:s0       tmp
-rw-r--r--  root root system_u:object_r:unlabeled_t:s0 tt.c
-rw-r--r--  root root system_u:object_r:unlabeled_t:s0 tttt
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 usr
drwxr-xr-x  root root system_u:object_r:unlabeled_t:s0 var
sh-3.1#
}}}

Here, few things that I should mention are, the filesystem is "ext2".
And I am doing all my experiments in (UML) User Mode Linux.
I think that it should not make any difference, as it is working fine
for one kernel, then it should work for other kernel also.

>
> > I am using FC6 filesystem with selinux policies compiled by SEEdit.
> > The binary policy file created is "/etc/selinux/seedit/policy/policy.21"
>
> Are there any other binary policy files in that directory, and is
No, there is only one file in "/etc/selinux/seedit/policy/" folder.
> your /etc/selinux/config specifying "seeedit" as the SELINUXTYPE?
Yes, it specifies "seedit".
{{{
sh-3.1# cat etc/selinux/config
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - SELinux is fully disabled.
SELINUX=permissive
# SELINUXTYPE= type of policy in use. Possible values are:
#       targeted - Only targeted network daemons are protected.
#       strict - Full SELinux protection.
SELINUXTYPE=seedit

# SETLOCALDEFS= Check local definition changes
SETLOCALDEFS=0
}}}
>
> > Do I need to re-create compiled binary policies for kernel 2.6.18 ?
>
> You shouldn't need to do so; load_policy should handle downgrading of
> the binary policy file to the kernel version automatically (as of FC5
> and later).
>
> > One more doubt that I have is kernel that I am using are not
> > Fedora-core kernel but plain vanilla kernels.
> > Can this create problems, as may be FC kernels are having different
> > binary policy format?
>
> Shouldn't be different.
>
> Might be useful to capture strace load_policy output and see what policy
> file(s) it opens.
>
I am not having "strace" in my filesystem, so I am using "lsof" to
capture the files that are opened by "load_policy".
Here only interesting file that I was able to see was
"/etc/selinux/seedit/policy/policy.21"
Here is the output for more details.
{{{
sh-3.1# lsof -c load_policy
COMMAND    PID USER   FD   TYPE DEVICE     SIZE   NODE NAME
load_poli 1670 root  cwd    DIR   98,0     4096      2 /
load_poli 1670 root  rtd    DIR   98,0     4096      2 /
load_poli 1670 root  txt    REG   98,0     6720  18335 /usr/sbin/load_policy
load_poli 1670 root  mem    REG   98,0   121684 177821 /lib/ld-2.5.so
load_poli 1670 root  mem    REG   98,0  1576920 176386 /lib/libc-2.5.so
load_poli 1670 root  mem    REG   98,0    16528 176358 /lib/libdl-2.5.so
load_poli 1670 root  mem    REG   98,0    89408 176362 /lib/libselinux.so.1
load_poli 1670 root  mem    REG   98,0   245376 177739 /lib/libsepol.so.1
load_poli 1670 root  mem    REG   98,0 55569968 167259
/usr/lib/locale/locale-archive
load_poli 1670 root  mem    REG   98,0   211659 129490
/etc/selinux/seedit/policy/policy.21
load_poli 1670 root    0u   CHR    5,1             918 /dev/console
load_poli 1670 root    1u   CHR    5,1             918 /dev/console
load_poli 1670 root    2u   CHR    5,1             918 /dev/console
load_poli 1670 root    3r   REG   98,0   211659 129490
/etc/selinux/seedit/policy/policy.21
load_poli 1670 root    4u   REG   0,12        0      3 /selinux/load
}}}

I am working on CKRM and selinux integration, and CKRM works only on
linux 2.6.18, so I need to get these policies on 2.6.18.
Thanx.
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
 Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
