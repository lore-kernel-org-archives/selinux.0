From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Today's diffs
Date: Sat, 2 Oct 2004 02:36:22 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <415CAFC5.8020505@redhat.com> <200410020125.00090.russell@coker.com.au> <415D799B.3060406@redhat.com>
In-Reply-To: <415D799B.3060406@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GeYXB5AGmBdbRFw"
Message-Id: <200410020236.22248.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_GeYXB5AGmBdbRFw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 2 Oct 2004 01:36, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >+# /usr/sbin/sendmail asks for w access to utmp
> >+allow sendmail_t initrc_var_run_t:file { getattr read lock write };
> >
> >Why does sendmail need lock and write access to initrc_var_run_t?
>
> sm-client will not work without this.

That turned out to be a bug in sendmail.fc.  I have attached a patch which 
fixes sendmail.fc and also removes the unnecessary rules from sendmail.te.

> >Also you have put in comments indicating that several programs have been
> >compiled with SSP (Stack Smashing Protection).  If the Fedora GCC packages
> >support SSP then we should enable it for newrole etc.

You missed the bit about SSP.

> >+allow udev_t domain:dir r_dir_perms;
> >
> >Why does udev need this?  Why would it need read access to the directory
> > but not to files inside it?
>
> It is running killall.

OK, then probably we want a dontaudit rule.

> >+/usr/bin/chage         --      system_u:object_r:passwd_exec_t
> >
> >This is wrong.  It should be admin_passwd_exec_t.  A regular user should
> > not execute this.
>
> chage -l dwalsh is available.

OK, we need to patch chage in the same way as passwd then.  We don't want to 
permit root:user_r:user_t to invalidate accounts.

> >--- nsapolicy/macros/global_macros.te   2004-09-22 16:19:13.000000000
> > -0400 +++ policy-1.17.25/macros/global_macros.te      2004-09-30
> > 20:59:57.315488479 -0400
> >@@ -287,6 +287,7 @@
> > allow $1_t device_t:dir { getattr search };
> > allow $1_t null_device_t:chr_file rw_file_perms;
> > dontaudit $1_t console_device_t:chr_file rw_file_perms;
> >+dontaudit $1_t unpriv_userdomain:fd use;
> >
> > r_dir_file($1_t, sysfs_t)
> >
> >How do you trigger this?  Is it related to the bug in su where su does not
> >re-open the terminal when changing role?  I expect that fixing su will fix
> >this.
>
> Maybe, it happens when you do a service daemon restart.  Not sure we can
> easily fix the su bug.

Please give an example of a command that triggers this.

> >+allow $1_lpr_t $1_mozilla_t:tcp_socket { read write };
> >+allow $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
> >
> >Looks like mozilla is too buggy to close it's file handles before spawning
> >lpr.  There's no reason for lpr to access a tcp or unix socket that
> > mozilla has created, they should be dontaudit rules.
>
> Happens when printing from pdf files.  Could they be opening  a pipe to
> the lpr command?

I can't believe that mozilla would use a TCP socket to send data to lpr.  
Creating a unix domain socket for it also seems to be a very odd way of doing 
things that is likely to cause breakage.  It would either be a fifo or a 
temporary file.

Does it work if you replace those allow rules with dontaudit rules?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_GeYXB5AGmBdbRFw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/file_contexts/program/sendmail.fc	2004-02-25 17:05:05.000000000 +1100
+++ /tmp/sendmail.fc	2004-10-02 02:28:23.000000000 +1000
@@ -3,3 +3,5 @@
 /var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 /var/log/sendmail\.st		--	system_u:object_r:sendmail_log_t
 /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t
+/var/run/sendmail.pid		--	system_u:object_r:sendmail_var_run_t
+/var/run/sm-client.pid		--	system_u:object_r:sendmail_var_run_t
--- /usr/src/se/policy/domains/program/unused/sendmail.te	2004-09-11 16:21:45.000000000 +1000
+++ domains/program/unused/sendmail.te	2004-10-02 02:31:38.000000000 +1000
@@ -65,11 +65,6 @@
 # Read /usr/lib/sasl2/.*
 allow sendmail_t lib_t:file { getattr read };
 
-# /usr/sbin/sendmail asks for w access to utmp, but it will operate
-# correctly without it.  Do not audit write and lock denials to utmp.
-allow sendmail_t initrc_var_run_t:file { getattr read };
-dontaudit sendmail_t initrc_var_run_t:file { lock write };
-
 # When sendmail runs as user_mail_domain, it needs some extra permissions
 # to update /etc/mail/statistics.
 allow user_mail_domain etc_mail_t:file rw_file_perms;

--Boundary-00=_GeYXB5AGmBdbRFw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
