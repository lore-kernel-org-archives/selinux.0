Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hANHWoRb005337
	for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2003 12:32:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hANHWnqY006180
	for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2003 17:32:50 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hANHWm0o006177 for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2003 17:32:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Policy error of the day
Date: Mon, 24 Nov 2003 04:32:34 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031119144708.GB8546@vnl.com> <200311200150.21987.russell@coker.com.au> <20031123160713.GF2718@vnl.com>
In-Reply-To: <20031123160713.GF2718@vnl.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y8Ow/OfHQi2ahga"
Message-Id: <200311240432.34633.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_y8Ow/OfHQi2ahga
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 24 Nov 2003 03:07, Dale Amon <amon@vnl.com> wrote:
> On Thu, Nov 20, 2003 at 01:50:21AM +1100, Russell Coker wrote:
> > On Thu, 20 Nov 2003 01:47, Dale Amon <amon@vnl.com> wrote:
> > > The policy build error for today is:
> > >
> > > ERROR 'unknown type mailman_queue_chkpwd_t' at token ';' on line 81971:
> > > #line 10047
> > > allow mailman_queue_su_t mailman_queue_chkpwd_t:process transition;
> > > /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> > > make: *** [/etc/security/selinux/policy.15] Error 1
> >
> > The chkpwd changes broke mailman.  I'm not sure whether it's worth trying
> > to fix this or whether mailman itself should be fixed instead.  I'll
> > probably do a work-around soon.
>
> Is anything in progress? I've not found a way to get by
> this without going into the end-result disk image and fiddling
> things manually, which is a pain. I haven't got any other workaround
> because I install packages into the chrooted image like this:

Try the attached policy file.  It compiles, not sure if it works though...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_y8Ow/OfHQi2ahga
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mailman.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mailman.te"

#DESC Mailman - GNU Mailman mailing list manager
#
# Author: Russell Coker <russell@coker.com.au>
# X-Debian-Packages: mailman

type mailman_data_t, file_type, sysadmfile;
type mailman_archive_t, file_type, sysadmfile;

type mailman_log_t, file_type, sysadmfile, logfile;
type mailman_lock_t, file_type, sysadmfile, lockfile;

define(`mailman_domain', `
type mailman_$1_t, domain, privlog;
type mailman_$1_exec_t, file_type, sysadmfile, exec_type;
role system_r types mailman_$1_t;
allow mailman_$1_t var_t:dir search;
file_type_auto_trans(mailman_$1_t, var_log_t, mailman_log_t, file)
rw_dir_create_file(mailman_$1_t, mailman_data_t)
uses_shlib(mailman_$1_t)
can_exec_any(mailman_$1_t)
allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
allow mailman_$1_t var_lib_t:dir { getattr search };
allow mailman_$1_t var_lib_t:lnk_file read;
allow mailman_$1_t device_t:dir search;
allow mailman_$1_t etc_runtime_t:file { read getattr };
read_locale(mailman_$1_t)
file_type_auto_trans(mailman_$1_t, var_lock_t, mailman_lock_t, file)
allow mailman_$1_t fs_t:filesystem getattr;
can_network(mailman_$1_t)
allow mailman_$1_t resolv_conf_t:file { getattr read };
allow mailman_$1_t self:unix_stream_socket create_socket_perms;
allow mailman_$1_t var_t:dir { getattr search };
')

mailman_domain(queue)
can_tcp_connect(mailman_queue_t, mail_server_domain)

can_exec(mailman_queue_t, su_exec_t)
allow mailman_queue_t self:capability setuid;

# some of the following could probably be changed to dontaudit, someone who
# knows mailman well should test this out and send the changes
allow mailman_queue_t sysadm_home_dir_t:dir { getattr search };

mailman_domain(mail)
dontaudit mailman_mail_t mta_delivery_agent:tcp_socket { read write };
allow mailman_mail_t mta_delivery_agent:fd use;
ifdef(`qmail.te', `
allow mailman_mail_t qmail_spool_t:file { read ioctl getattr };
# do we really need this?
allow mailman_mail_t qmail_lspawn_t:fifo_file write;
')

create_dir_file(mailman_queue_t, mailman_archive_t)

ifdef(`apache.te', `
mailman_domain(cgi)
can_tcp_connect(mailman_cgi_t, mail_server_domain)

domain_auto_trans({ httpd_t httpd_suexec_t }, mailman_cgi_exec_t, mailman_cgi_t)
# should have separate types for public and private archives
r_dir_file(httpd_t, mailman_archive_t)
allow httpd_t mailman_data_t:dir search;
r_dir_file(mailman_cgi_t, mailman_archive_t)

dontaudit mailman_cgi_t httpd_log_t:file append;
allow httpd_t mailman_cgi_t:process signal;
allow mailman_cgi_t httpd_t:process sigchld;
allow mailman_cgi_t httpd_t:fd use;
allow mailman_cgi_t httpd_t:fifo_file { getattr read write ioctl };
allow mailman_cgi_t httpd_sys_script_t:dir search;
allow mailman_cgi_t devtty_t:chr_file { read write };
allow mailman_cgi_t self:process { fork sigchld };
')

allow mta_delivery_agent mailman_data_t:dir search;
allow mta_delivery_agent mailman_data_t:lnk_file read;
domain_auto_trans(mta_delivery_agent, mailman_mail_exec_t, mailman_mail_t)
allow mailman_mail_t self:unix_dgram_socket create_socket_perms;

system_crond_entry(mailman_queue_exec_t, mailman_queue_t)
allow mailman_queue_t devtty_t:chr_file { read write };
allow mailman_queue_t self:process { fork signal sigchld };


# so MTA can access /var/lib/mailman/mail/wrapper
allow mta_delivery_agent var_lib_t:dir search;

--Boundary-00=_y8Ow/OfHQi2ahga--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
