Subject: Re: Updated policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F6A47E.9010407@redhat.com>
References: <41F6A47E.9010407@redhat.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 23:54:36 -0700
Message-Id: <1106722476.17057.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 14:56 -0500, Daniel J Walsh wrote:
> Many changes to allow policy to support telnetd, rlogind and rshd.
> 
> allow mount_t binfmt_misc_fs_t:dir mounton;
> Required to run wine.

What about samba - how to get samba to work? (Bug: 145025)

Something along those lines, or does it need a separate
context from mount_t ?

--- mount.te    2005-01-25 22:40:04.000000000 -0700
+++ mount.new   2005-01-25 23:38:22.000000000 -0700
@@ -77,7 +77,16 @@
 #
 # required for mount.smbfs
 #
+ifdef(`samba.te', `
+can_network(mount_t)
+allow mount_t self:capability { setuid setgid };
+allow mount_t samba_log_t:file create_file_perms;
+allow mount_t samba_var_t:dir getattr;
+allow mount_t samba_var_t:file rw_file_perms;
+allow mount_t samba_etc_t:file { getattr read };
 allow mount_t sbin_t:lnk_file { getattr read };
+allow mount_t cifs_t:dir { getattr read ioctl };
+')

 rhgb_domain(mount_t)
--- mount_macros.te     2005-01-25 23:23:03.000000000 -0700
+++ mount_macros.new    2005-01-25 23:32:49.000000000 -0700
@@ -62,8 +62,10 @@
 allow $2_t sbin_t:dir search;

 # Access the terminal.
+allow $2_t devtty_t:chr_file rw_file_perms;
 allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
-allow $2_t $1_devpts_t:chr_file { getattr read write };
+allow $2_t devpts_t:dir { search };
+allow $2_t $1_devpts_t:chr_file { getattr read write ioctl };
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
 allow $2_t var_t:dir search;
 allow $2_t var_run_t:dir search;


=======

Also, this still hangs when doing ls, or trying to remount it. 
I don't know why. Possibly related:

(1)

Slab corruption: (Tainted: P     ) start=c8748e70, len=268
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<e0be357d>](smb_add_request+0x1da/0x25b [smbfs])
000: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
100: 6b 6b 6b 6b 6b 6b 6b 6b 00 fe ff ff
Prev obj: start=c8748d58, len=268
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

(2)

audit(1106721540.741:0): avc:  denied  { read } for  pid=16907
comm=smbiod laddr=192.168.2.96 lport=56841 faddr=192.168.2.96 fport=445
scontext=system_u:system_r:kernel_t tcontext=root:sysadm_r:mount_t
tclass=tcp_socket






-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
