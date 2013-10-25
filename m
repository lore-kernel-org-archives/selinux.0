Message-ID: <1382726447.3041.171.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Fri, 25 Oct 2013 20:40:47 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

Here is one last weird thing i am facing before the weekend:


> [root@localhost support]# ausearch -m avc,user_avc,selinux_err -ts 20:37
> <no matches>
> [root@localhost support]# seinfo -xcdbus
>    dbus
>       acquire_svc
>       send_msg
> [root@localhost support]# sesearch -A -s systemd_t -t systemd_t | grep dbus
>    allow dbusunconfined domaintype : dbus { acquire_svc send_msg } ; 
> [root@localhost support]# load_policy
> [root@localhost support]# ausearch -m avc,user_avc,selinux_err -ts 20:37 | grep dbus
> type=USER_AVC msg=audit(1382726311.163:635): pid=478 uid=81 auid=4294967295 ses=4294967295  subj=system_u:system_r:systemd_t:s0 msg='avc:  denied  { send_msg } for msgtype=method_call interface=org.freedesktop.DBus member=AddMatch dest=org.freedesktop.DBus spid=530 scontext=system_u:system_r:systemd_t:s0 tcontext=system_u:system_r:systemd_t:s0 tclass=dbus  exe="/usr/bin/dbus-daemon" sauid=81 hostname=? addr=? terminal=?'


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
