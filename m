Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55LaKGm026898
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 17:36:20 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l55LaI8Y001029
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 21:36:19 GMT
Received: by ug-out-1314.google.com with SMTP id z34so356005ugc
        for <selinux@tycho.nsa.gov>; Tue, 05 Jun 2007 14:36:12 -0700 (PDT)
Message-ID: <f71a82820706051436x58c0c4daodb32610866c4a529@mail.gmail.com>
Date: Wed, 6 Jun 2007 06:36:11 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Can't login in F7 strict
Cc: sds@tycho.nsa.gov, cpebenito@tresys.com, dwalsh@redhat.com
In-Reply-To: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I used interfaces, still error occurs when I install localaudit.pp.

libsepol.permission_copy_callback: Module localaudit depends on
permission nlsms_relay in class netlink_audit_socket, not satisfied
libsemanage.semanage_link_sandbox; Link packages failed
semodule: Failed !

module localaudit 1.0;

require {
    type local_login_t
    ....
    class netlink_audio_socket { ......nlsms_relay .....};
    ....
}
logging_send_audit_msg(local_login_t)
logging_set_loginuid(local_login_t)

Almost, but anyway, still I can not install my module (very basic one
I guess...;)


2007/6/3, Shintaro Fujiwara <shintaro.fujiwara@gmail.com>:
> Hello.
>
> I'm trying to work out on F7 strict policy.
> My server is now FC6, so I'm trying to change it 7.
>
> I yum installed every selinux related packages.
> I made localaudit.pp typing
> #audit2allow -i /var/log/audit/audit.log -m localaudit > localaudit.te
> at /usr/share/selinux/devel
> #semodule -i localaudit.pp
> violation reported by libsepol.chek_assertions
>
> local_login_t local_login_t:netlink_audit_socket { nlmsg_relay };
> local_login_t local_login_t:capability { audit_write };
> local_login_t local_login_t:capability { audit_control };
>
> So,I commented those lines on localaudit.te including require brace.
> This time I succeeded installing localaudit.pp.
>
> I restarted my machine setting Enforcing/strict.
> During the startup process, I could see Keymap had failed.
> I can't login from console.
> I typed like a US key not jp106, still I can't.
>
> You made strict policy not logging in from console?
> What should I do?
>
>
> homepage http://intrajp.no-ip.com/
> SELinux Forum JP http://intrajp.no-ip.com/xoops
> SELinux Wiki JP http://intrajp.no-ip.com/pukiwiki
> my blog JP http://intrajp.no-ip.com/nucleus
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
