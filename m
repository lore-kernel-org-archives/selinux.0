Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9A7afrT000817
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2004 03:36:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9A7ZSpb002727
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2004 07:35:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: More SELinux fixes.
Date: Sun, 10 Oct 2004 17:36:25 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <4165B9AA.8090803@redhat.com> <200410091622.08531.russell@coker.com.au> <41688FAF.5010601@redhat.com>
In-Reply-To: <41688FAF.5010601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410101736.25763.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 10 Oct 2004 11:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Temporarily added a rule to allow apache to talk to tmp_t:sock_file in
> targeted policy.  This allows
> it to work with postgresql.  Not sure of a good way to fix this.  One we

I don't think that there is any other option.  As long as apache has to talk 
to programs in unconfined_t via unix domain sockets such access is required.

> could add postgresql policy to targeted
> but I am afraid this is a slipperly slope,  Colin suggested that we add
> a new policy postgresql_unconfined.te for
> targeted that basically runs postgres unconfined but creates /tmp files
> with an appropriate security context.

Might as well go the whole hog and make Postgresql use it's regular policy.  
Postgresql isn't THAT difficult to do.

dontaudit mount_t reserved_port_type:{tcp_socket udp_socket} name_bind;

Why remove all the rules of that form?  Has something equivalent been added to 
a macro?

+can_exec(postgresql_t, { postgresql_exec_t bin_t sbin_t ls_exec_t su_exec_t 
shell_exec_t etc_t hostname_exec_t })

The above really needs to become:
ifdef(`hostname.te', `
can_exec(postgresql_t, hostname_exec_t)
')

+allow procmail_t mqueue_spool_t:file { getattr read };

I believe that this is a bug in sendmail.  Put in the following instead:
ifdef(`hide_broken_symptoms', `
dontaudit procmail_t mqueue_spool_t:file { getattr read };
')

Also put it inside ifdef(`sendmail.te', only sendmail.te uses mqueue_spool_t, 
so we should move the type declaration into sendmail.te.

-file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
+file_type_auto_trans(snmpd_t, usr_t, snmpd_var_lib_t, file)
+file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, file)

What is the point of this change?

+allow udev_t dev_fs:{ chr_file blk_file } { relabelfrom relabelto };

The above is redundant, the below line covers it.

allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom 
relabelto create_file_perms };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
