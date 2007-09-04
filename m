Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84IpPWF027155
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 14:51:25 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l84IpKFI021660
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 18:51:20 GMT
Subject: Re: [PATCH] refpolicy: system_netlabel changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022018.l72KIh0n030143@redsox.boston.devel.redhat.com>
References: <200708022018.l72KIh0n030143@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 14:49:41 -0400
Message-Id: <1188931781.30065.8.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:18 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/netlabel.te    2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/netlabel.te 2007-08-02
> 11:02:02.000000000 -0400
> @@ -19,6 +19,8 @@
>  allow netlabel_mgmt_t self:capability net_admin;
>  allow netlabel_mgmt_t self:netlink_socket create_socket_perms;
> 
> +files_read_etc_files(netlabel_mgmt_t)
> +
>  kernel_read_network_state(netlabel_mgmt_t)
> 
>  libs_use_ld_so(netlabel_mgmt_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
