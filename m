From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: More SELinux fixes.
Date: Sat, 9 Oct 2004 13:10:35 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <4165B9AA.8090803@redhat.com>
In-Reply-To: <4165B9AA.8090803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410091310.35902.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Oct 2004 07:48, Daniel J Walsh <dwalsh@redhat.com> wrote:
policy-1.17.29/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te   2004-10-01 15:05:32.000000000 
-0400
+++ policy-1.17.29/macros/program/chkpwd_macros.te      2004-10-07 
17:24:28.492440739 -0400
@@ -27,6 +27,7 @@
 role system_r types system_chkpwd_t;
 dontaudit auth_chkpwd shadow_t:file { getattr read };
 allow auth_chkpwd sbin_t:dir search;
+dontaudit $1_chkpwd_t tty_device_t:chr_file rw_file_perms;
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
@@ -51,9 +52,6 @@
 allow $1_chkpwd_t etc_t:file { getattr read };
 allow $1_chkpwd_t self:unix_dgram_socket create_socket_perms;
 allow $1_chkpwd_t self:unix_stream_socket create_socket_perms;
-ifdef(`targeted_policy', `
-allow $1_chkpwd_t tty_device_t:chr_file { read write };
-')
 read_locale($1_chkpwd_t)
 
 # Use capabilities.

Do we have a bug in the PAM code?  If the PAM code is working as designed then 
the terminal will be closed before unix_chkpwd is executed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
