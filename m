Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CKG72K016359
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 16:16:07 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5CKG58g021955
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 20:16:06 GMT
Received: by ug-out-1314.google.com with SMTP id z34so287977ugc
        for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:16:04 -0700 (PDT)
Message-ID: <f71a82820706121316i2ff46ca0j70ea3076569feef5@mail.gmail.com>
Date: Wed, 13 Jun 2007 05:16:04 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: Can't login in F7 strict
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov, cpebenito@tresys.com
In-Reply-To: <466E90C7.5090407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
	 <f71a82820706051436x58c0c4daodb32610866c4a529@mail.gmail.com>
	 <1181132472.3699.6.camel@moss-spartans.epoch.ncsc.mil>
	 <f71a82820706061427u2fd09352k227f5cda439abee4@mail.gmail.com>
	 <f71a82820706070311p12b8cb33x6103d9c6fb1d5292@mail.gmail.com>
	 <466D8620.10301@redhat.com>
	 <f71a82820706111445k2e144280h25f220dc917b3240@mail.gmail.com>
	 <466E90C7.5090407@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you very much for your kind advices.

I will relabel my system and regenerate my own policy
 with the latest selinux-policy properly.
Especially I will check something should not be allowed from initrc_t...
And delete lines setfiles (I restoreconed my home directory for the
use of stuff_u) stuff.

Thanks !

##################################################

Officer, System-Informations, Signal School, JGSDF

###################################################


2007/6/12, Daniel J Walsh <dwalsh@redhat.com>:
> Shintaro Fujiwara wrote:
> > There really aren't any denied messages concerning it ...
> > There really are no problem if I attach my log allright, but no use...
> > But I copied .te files I made from both logs (audit.log and messages).
> > Are there any clue in here ?
> > Or,
> > Should I install enableaudit.pp and listen to all the log or not ?
> >
> >
> > ##########here's module i made from audit.log##############
> > module localaudit 1.0;
> >
> > require {
> >        type default_t;
> >        type system_cron_spool_t;
> >        type local_login_t;
> >        type system_dbusd_var_run_t;
> >        type sysadm_su_t;
> >        type crond_t;
> >        class capability { setuid setgid };
> >        class dir { read search };
> > }
> >
> > #============= crond_t ==============
> > allow crond_t system_cron_spool_t:dir read;
> >
> > #============= local_login_t ==============
> > allow local_login_t default_t:dir search;
> default_t is caused by a mislabeled /root.  restorecon -R -v /root
> > allow local_login_t system_dbusd_var_run_t:dir search;
> >
> > #============= sysadm_su_t ==============
> > allow sysadm_su_t default_t:dir search;
> > allow sysadm_su_t self:capability { setuid setgid };
> >
> Latest policy should have this.
> >
> > ##########here's module i made from /var/log/messages##############
> > module localmessages 1.0;
> >
> > require {
> >        type default_t;
> >        type sysctl_net_unix_t;
> >        type init_t;
> >        type initrc_t;
> >        type file_t;
> >        type restorecon_t;
> >        type sysctl_vm_t;
> >        type kernel_t;
> >        type lvm_control_t;
> >        type loadkeys_t;
> >        type proc_kcore_t;
> >        type sysctl_irq_t;
> >        type sysctl_net_t;
> >        type sysctl_hotplug_t;
> >        type mount_t;
> >        type nscd_var_run_t;
> >        type setfiles_t;
> >        type proc_xen_t;
> >        type proc_kmsg_t;
> >        type proc_mdstat_t;
> >        type sysctl_modprobe_t;
> >        type sysctl_dev_t;
> >        type fsadm_t;
> >        type udev_t;
> >        type lvm_t;
> >        type sysctl_kernel_t;
> >        type proc_net_t;
> >        type local_login_t;
> >        type sshd_t;
> >        class capability { audit_write audit_control };
> >        class chr_file write;
> >        class lnk_file getattr;
> >        class dir { getattr read search };
> >        class file { read lock getattr unlink };
> >        class netlink_audit_socket { create ioctl setattr getattr
> > append write nlmsg_relay nlmsg_read create read bind connect setopt
> > getopt shutdown };
> > }
> >
> > #============= initrc_t ==============
> > allow initrc_t lvm_control_t:chr_file write;
> >
> What program caused this?  Should probably be labeled lvm_exec_t
> > #============= loadkeys_t ==============
> > allow loadkeys_t nscd_var_run_t:dir search;
> >
> > #============= udev_t ==============
> > allow udev_t default_t:dir search;
> > #============= fsadm_t ==============
> > allow fsadm_t file_t:file { read getattr };
> These should not exist file_t means you have unlabled files on your system
> >
> > #============= init_t ==============
> > allow init_t file_t:file { read lock getattr };
> >
> > #============= initrc_t ==============
> > allow initrc_t file_t:file read;
> >
> > #============= lvm_t ==============
> > allow lvm_t file_t:file { read getattr };
> >
> > #============= mount_t ==============
> > allow mount_t file_t:file unlink;
> >
> > #============= restorecon_t ==============
> > allow restorecon_t file_t:file read;
> >
> > #============= setfiles_t ==============
> > allow setfiles_t file_t:file read;
> > allow setfiles_t init_t:dir { read getattr search };
> > allow setfiles_t init_t:file getattr;
> > allow setfiles_t init_t:lnk_file getattr;
> > allow setfiles_t initrc_t:dir { read getattr search };
> > allow setfiles_t initrc_t:file getattr;
> > allow setfiles_t initrc_t:lnk_file getattr;
> > allow setfiles_t kernel_t:dir { read getattr search };
> > allow setfiles_t kernel_t:file getattr;
> > allow setfiles_t kernel_t:lnk_file getattr;
> > allow setfiles_t proc_kcore_t:file getattr;
> > allow setfiles_t proc_kmsg_t:file getattr;
> > allow setfiles_t proc_mdstat_t:file getattr;
> > allow setfiles_t proc_net_t:dir { read getattr search };
> > allow setfiles_t proc_net_t:file getattr;
> > allow setfiles_t proc_xen_t:dir { read getattr search };
> > allow setfiles_t proc_xen_t:file getattr;
> Should all be dontaudit, this is caused by running restorecon or
> setfiles on /proc
> > ###############edited by me################################
> > #allow setfiles_t self:capability audit_write;
> > #allow setfiles_t self:netlink_audit_socket { write nlmsg_relay create
> > read };
> > ###########################################################
> > allow setfiles_t sysctl_dev_t:dir { read getattr search };
> > allow setfiles_t sysctl_dev_t:file getattr;
> > allow setfiles_t sysctl_hotplug_t:file getattr;
> > allow setfiles_t sysctl_irq_t:dir { read getattr search };
> > allow setfiles_t sysctl_irq_t:file getattr;
> > allow setfiles_t sysctl_kernel_t:dir { read getattr search };
> > allow setfiles_t sysctl_kernel_t:file getattr;
> > allow setfiles_t sysctl_modprobe_t:file getattr;
> > allow setfiles_t sysctl_net_t:dir { read getattr search };
> > allow setfiles_t sysctl_net_t:file getattr;
> > allow setfiles_t sysctl_net_unix_t:dir { read getattr search };
> > allow setfiles_t sysctl_net_unix_t:file getattr;
> > allow setfiles_t sysctl_vm_t:dir { read getattr search };
> > allow setfiles_t sysctl_vm_t:file getattr;
> > allow setfiles_t udev_t:dir { read getattr search };
> > allow setfiles_t udev_t:file getattr;
> > allow setfiles_t udev_t:lnk_file getattr;
> >
> > #============= udev_t ==============
> > allow udev_t file_t:file { read getattr };
> >
> > ###############added by me################################
> >
> > #============= local_login_t ==============
> > logging_send_audit_msg(local_login_t)
> > logging_set_loginuid(local_login_t)
> Latest policy should have these
> >
> > #============= sshd_t ==============
> > logging_send_audit_msg(sshd_t)
> > logging_set_loginuid(sshd_t)
> >
> >
> > 2007/6/12, Daniel J Walsh <dwalsh@redhat.com>:
> >> Shintaro Fujiwara wrote:
> >> > With the latest policy, I could install and could login my machine.
> >> >
> >> > Thanks !
> >> >
> >> > But another problem...
> >> >
> >> > Keymap(jp106) fails...
> >> >
> >> > Is this the only problem for not English speaking people and how
> >> > should we fix it ?
> >> > I can use my jp106 keybord as US keybord but invconvinient...
> >> >
> >> > Is there still bug in policy or not ?
> >> >
> >> Most likely a bug in policy,  Please report it and attach your audit.log
> >>
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
