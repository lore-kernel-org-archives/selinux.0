Message-ID: <415D799B.3060406@redhat.com>
Date: Fri, 01 Oct 2004 11:36:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Today's diffs
References: <415CAFC5.8020505@redhat.com> <200410020125.00090.russell@coker.com.au>
In-Reply-To: <200410020125.00090.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Fri, 1 Oct 2004 11:15, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>New tvtime and vpnc
>>Fixes for mozilla and inetd daemons
>>    
>>
>
>allow getty_t initrc_devpts_t:chr_file { read write };
>
>How do you trigger this?  There doesn't seem to be a good reason for getty to 
>have such access.  Bug in init?
>
>-# /usr/sbin/sendmail asks for w access to utmp, but it will operate
>-# correctly without it.  Do not audit write and lock denials to utmp.
>-allow sendmail_t initrc_var_run_t:file { getattr read };
>-dontaudit sendmail_t initrc_var_run_t:file { lock write };
>+# /usr/sbin/sendmail asks for w access to utmp
>+allow sendmail_t initrc_var_run_t:file { getattr read lock write };
>
>Why does sendmail need lock and write access to initrc_var_run_t?
>
>  
>
sm-client will not work without this.

>+allow user_tvtime_t xdm_tmp_t:dir { search };
>
>The above rule is redundant, you also have it in 
>macros/program/tvtime_macros.te.
>
>  
>
Ok remove it.

>Also you have put in comments indicating that several programs have been 
>compiled with SSP (Stack Smashing Protection).  If the Fedora GCC packages 
>support SSP then we should enable it for newrole etc.
>
>+allow udev_t domain:dir r_dir_perms;
>
>Why does udev need this?  Why would it need read access to the directory but 
>not to files inside it?
>
>  
>
It is running killall.

>+/usr/bin/chage         --      system_u:object_r:passwd_exec_t
>
>This is wrong.  It should be admin_passwd_exec_t.  A regular user should not 
>execute this.
>
>  
>
chage -l dwalsh is available.

>--- nsapolicy/macros/global_macros.te   2004-09-22 16:19:13.000000000 -0400
>+++ policy-1.17.25/macros/global_macros.te      2004-09-30 20:59:57.315488479 
>-0400
>@@ -287,6 +287,7 @@
> allow $1_t device_t:dir { getattr search };
> allow $1_t null_device_t:chr_file rw_file_perms;
> dontaudit $1_t console_device_t:chr_file rw_file_perms;
>+dontaudit $1_t unpriv_userdomain:fd use;
> 
> r_dir_file($1_t, sysfs_t) 
>
>How do you trigger this?  Is it related to the bug in su where su does not 
>re-open the terminal when changing role?  I expect that fixing su will fix 
>this.
>
>  
>
Maybe, it happens when you do a service daemon restart.  Not sure we can 
easily fix the su bug.

>+allow $1_lpr_t $1_mozilla_t:tcp_socket { read write };
>+allow $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
>
>Looks like mozilla is too buggy to close it's file handles before spawning 
>lpr.  There's no reason for lpr to access a tcp or unix socket that mozilla 
>has created, they should be dontaudit rules.
>
>  
>
Happens when printing from pdf files.  Could they be opening  a pipe to 
the lpr command?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
