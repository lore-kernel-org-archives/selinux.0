Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56LRMfe005614
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 17:27:22 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l56LRKXZ001798
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 21:27:21 GMT
Received: by ug-out-1314.google.com with SMTP id z34so647101ugc
        for <selinux@tycho.nsa.gov>; Wed, 06 Jun 2007 14:27:20 -0700 (PDT)
Message-ID: <f71a82820706061427u2fd09352k227f5cda439abee4@mail.gmail.com>
Date: Thu, 7 Jun 2007 06:27:19 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Can't login in F7 strict
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com, dwalsh@redhat.com
In-Reply-To: <1181132472.3699.6.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
	 <f71a82820706051436x58c0c4daodb32610866c4a529@mail.gmail.com>
	 <1181132472.3699.6.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This morning, (in Japan) I could yum update selinux policies to 2.6.4-13.fc7 .
During the process,

security:context sysadm_u:sysadm_r:initrc_t:s0 is invalid
libsepol.context_from_record:type unconfined_execmem_ecec_t is not defined
libsepol.context_from_record:could not create context structure
libsepol.context_from_string:could not create context structure
libsepol.sepol_context_to_sid:could not convert
system_u:object_r:unconfined_execmem_exec_t:s0 to sid
/etc/selinux/strict/contexts/files/file_contexts: line 597 has invalid
context system_u:object_r:unconfined_execmem_exec_t:s0
libsemanage.semanage_install_active:setfiles returned error code 1.
libsepol.sepol_genbools_array:boolean httpd_can_sendmail no longer in policy
security:context sysadm_u:sysadm_r:initrc_t:s0 is invalid
semodule: Failed!

Is this another bug on 2.6.4-13 ?


Thank you very much for your endevours.



2007/6/6, Stephen Smalley <sds@tycho.nsa.gov>:
> On Wed, 2007-06-06 at 06:36 +0900, Shintaro Fujiwara wrote:
> > I used interfaces, still error occurs when I install localaudit.pp.
> >
> > libsepol.permission_copy_callback: Module localaudit depends on
> > permission nlsms_relay in class netlink_audit_socket, not satisfied
> > libsemanage.semanage_link_sandbox; Link packages failed
> > semodule: Failed !
> >
> > module localaudit 1.0;
> >
> > require {
> >     type local_login_t
> >     ....
> >     class netlink_audio_socket { ......nlsms_relay .....};
> >     ....
> > }
> > logging_send_audit_msg(local_login_t)
> > logging_set_loginuid(local_login_t)
> >
> > Almost, but anyway, still I can not install my module (very basic one
> > I guess...;)
>
> >From other discussions on fedora-selinux-list, it seems that there are
> some bugs in that policy; try updating to the latest one in
> updates-testing.
>
> >
> >
> > 2007/6/3, Shintaro Fujiwara <shintaro.fujiwara@gmail.com>:
> > > Hello.
> > >
> > > I'm trying to work out on F7 strict policy.
> > > My server is now FC6, so I'm trying to change it 7.
> > >
> > > I yum installed every selinux related packages.
> > > I made localaudit.pp typing
> > > #audit2allow -i /var/log/audit/audit.log -m localaudit > localaudit.te
> > > at /usr/share/selinux/devel
> > > #semodule -i localaudit.pp
> > > violation reported by libsepol.chek_assertions
> > >
> > > local_login_t local_login_t:netlink_audit_socket { nlmsg_relay };
> > > local_login_t local_login_t:capability { audit_write };
> > > local_login_t local_login_t:capability { audit_control };
> > >
> > > So,I commented those lines on localaudit.te including require brace.
> > > This time I succeeded installing localaudit.pp.
> > >
> > > I restarted my machine setting Enforcing/strict.
> > > During the startup process, I could see Keymap had failed.
> > > I can't login from console.
> > > I typed like a US key not jp106, still I can't.
> > >
> > > You made strict policy not logging in from console?
> > > What should I do?
> > >
> > >
> > > homepage http://intrajp.no-ip.com/
> > > SELinux Forum JP http://intrajp.no-ip.com/xoops
> > > SELinux Wiki JP http://intrajp.no-ip.com/pukiwiki
> > > my blog JP http://intrajp.no-ip.com/nucleus
> > >
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
