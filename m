Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9CItTrT014252
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 14:55:29 -0400 (EDT)
Message-ID: <416C288E.1010001@redhat.com>
Date: Tue, 12 Oct 2004 14:55:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: More SELinux fixes.
References: <4165B9AA.8090803@redhat.com> <200410091622.08531.russell@coker.com.au> <41688FAF.5010601@redhat.com> <200410101736.25763.russell@coker.com.au>
In-Reply-To: <200410101736.25763.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Sun, 10 Oct 2004 11:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Temporarily added a rule to allow apache to talk to tmp_t:sock_file in
>>targeted policy.  This allows
>>it to work with postgresql.  Not sure of a good way to fix this.  One we
>>    
>>
>
>I don't think that there is any other option.  As long as apache has to talk 
>to programs in unconfined_t via unix domain sockets such access is required.
>
>  
>
Ok.  It is in there.

>>could add postgresql policy to targeted
>>but I am afraid this is a slipperly slope,  Colin suggested that we add
>>a new policy postgresql_unconfined.te for
>>targeted that basically runs postgres unconfined but creates /tmp files
>>with an appropriate security context.
>>    
>>
>
>Might as well go the whole hog and make Postgresql use it's regular policy.  
>Postgresql isn't THAT difficult to do.
>
>dontaudit mount_t reserved_port_type:{tcp_socket udp_socket} name_bind;
>
>Why remove all the rules of that form?  Has something equivalent been added to 
>a macro?
>
>  
>
This is now defined in can_ypbind, but I guess for mount_t it should 
remain.  Some of these
rules were proliferating because of yp.  If the app uses portmap, it 
will need this rule otherwise it
can rely in the rule in can_ypbind.

>+can_exec(postgresql_t, { postgresql_exec_t bin_t sbin_t ls_exec_t su_exec_t 
>shell_exec_t etc_t hostname_exec_t })
>
>The above really needs to become:
>ifdef(`hostname.te', `
>can_exec(postgresql_t, hostname_exec_t)
>')
>  
>
Done

>+allow procmail_t mqueue_spool_t:file { getattr read };
>
>I believe that this is a bug in sendmail.  Put in the following instead:
>ifdef(`hide_broken_symptoms', `
>dontaudit procmail_t mqueue_spool_t:file { getattr read };
>')
>  
>
Ok I changed it.

>Also put it inside ifdef(`sendmail.te', only sendmail.te uses mqueue_spool_t, 
>so we should move the type declaration into sendmail.te.
>
>-file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
>+file_type_auto_trans(snmpd_t, usr_t, snmpd_var_lib_t, file)
>+file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, file)
>
>What is the point of this change?
>  
>
I thought combining these caused problems.  I saw some avc messages with 
snmpd trying to write to var_t, which
I thought might have been caused by a macro expansion problem.  When I 
changed to the above, the problem
went away, could have been a red herring.

>+allow udev_t dev_fs:{ chr_file blk_file } { relabelfrom relabelto };
>
>The above is redundant, the below line covers it.
>
>allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom 
>relabelto create_file_perms };
>
>  
>
I think the problem came in because these files are not covered by the 
above command
type sysadm_tty_device_t, file_type, sysadmfile, ttyfile, dev_fs;
type user_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, 
dev_fs;
type staff_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type, 
dev_fs;

If you stop and restart udev, you get lots of AVC's from these.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
