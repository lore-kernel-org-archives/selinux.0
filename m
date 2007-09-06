Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86ISXiI012888
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 14:28:33 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l86ISWOd014556
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 18:28:32 GMT
Subject: Re: [PATCH] refpolicy: services_networkmanager changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022049.l72KnVPT000397@redsox.boston.devel.redhat.com>
References: <200708022049.l72KnVPT000397@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 14:27:10 -0400
Message-Id: <1189103230.3664.26.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:49 -0400, dwalsh@redhat.com wrote:
> Change wpa_supplicant to run as network manager

Merged.

> --- nsaserefpolicy/policy/modules/services/networkmanager.fc    2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/networkmanager.fc 2007-08-02 11:02:02.000000000 -0400
> @@ -1,5 +1,6 @@
> 
>  /usr/(s)?bin/NetworkManager    --      gen_context(system_u:object_r:NetworkManager_exec_t,s0)
> +/usr/(s)?bin/wpa_supplicant    --      gen_context(system_u:object_r:NetworkManager_exec_t,s0)
>  /var/run/NetworkManager\.pid   --      gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
>  /var/run/NetworkManager(/.*)?          gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
>  /var/run/wpa_supplicant(/.*)?          gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
> --- nsaserefpolicy/policy/modules/services/networkmanager.te    2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/networkmanager.te 2007-08-02 11:02:02.000000000 -0400
> @@ -41,6 +41,8 @@
>  kernel_read_kernel_sysctls(NetworkManager_t)
>  kernel_load_module(NetworkManager_t)
> 
> +can_exec(NetworkManager_t, NetworkManager_exec_t)
> +
>  corenet_all_recvfrom_unlabeled(NetworkManager_t)
>  corenet_all_recvfrom_netlabel(NetworkManager_t)
>  corenet_tcp_sendrecv_all_if(NetworkManager_t)
> @@ -136,6 +138,7 @@
>         dbus_system_bus_client_template(NetworkManager,NetworkManager_t)
>         dbus_connect_system_bus(NetworkManager_t)
>         dbus_send_system_bus(NetworkManager_t)
> +       userdom_dbus_chat_all_users(NetworkManager_t)
>  ')
> 
>  optional_policy(`
> @@ -152,6 +155,11 @@
>  ')
> 
>  optional_policy(`
> +       openvpn_domtrans(NetworkManager_t)
> +       openvpn_signal(NetworkManager_t)
> +')
> +
> +optional_policy(`
>         ppp_domtrans(NetworkManager_t)
>         ppp_read_pid_files(NetworkManager_t)
>         ppp_signal(NetworkManager_t)
> @@ -166,6 +174,7 @@
>  ')
> 
>  optional_policy(`
> +       unconfined_rw_pipes(NetworkManager_t)
>         # Read gnome-keyring
>         unconfined_read_home_content_files(NetworkManager_t)
>  ')
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
