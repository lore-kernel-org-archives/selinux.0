Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AD61I7031004
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:06:01 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AD5vgp027854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:05:59 GMT
Subject: Re: networkmanager now setpgid
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042F76.4010909@redhat.com>
References: <46042F76.4010909@redhat.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 09:06:40 -0400
Message-Id: <1176210400.9840.16.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:50 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/networkmanager.te    2007-03-20 23:38:16.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/networkmanager.te        2007-03-22 15:06:59.000000000 -0400
> @@ -22,7 +22,7 @@
>  # and it receives a unexpected signal (rh bug #204161) 
>  allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service ipc_lock };
>  dontaudit NetworkManager_t self:capability { sys_tty_config sys_ptrace };
> -allow NetworkManager_t self:process { ptrace setcap getsched signal_perms };
> +allow NetworkManager_t self:process { ptrace setcap setpgid getsched signal_perms };
>  allow NetworkManager_t self:fifo_file rw_fifo_file_perms;
>  allow NetworkManager_t self:unix_dgram_socket { sendto create_socket_perms };
>  allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
