Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAHKD8Ii009359
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 15:13:08 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAHKBfkh027362
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 20:11:41 GMT
Subject: Re: Patches without the can_network patch.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4192A029.5050909@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
Content-Type: text/plain
Message-Id: <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 17 Nov 2004 15:15:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with some changes.
- Changed the attribute $1_homedirfile to $1_file_type
- Removed the attribute homedirfile since it is not being used.
- Moved can_kerberos to a new file named kerberos_macros.te instead of
network_macros.te
- Added "ifdef(`kerberos.te', `" to the can_kerberos macro.
- Did not remove the "ifdef`kerberos.te', `" in net_contexts.

On Wed, 2004-11-10 at 18:11, Daniel J Walsh wrote:
> Removal of alot of kerberos and can_ypbind calls.  (Centralized under 
> the auth call).
> 
> Several apache fixes to make squirrelmail work as well as mod_perl and 
> mod_python.
> 
> Fixes to dovecot to get it to work with squirrelmail
> 
> Fixes to hal to allow it to create a chr_file device for pcmcia card 
> communication.
> 
> Added lockdev policy
> 
> Fixes for mailman policy
> 
> A few more nscd_client_domains
> 
<snip>
> diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.19.1/macros/network_macros.te
> --- nsapolicy/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
> +++ policy-1.19.1/macros/network_macros.te	2004-11-10 17:50:28.419688186 -0500
> @@ -0,0 +1,5 @@
> +define(`can_kerberos',`
> +can_network($1)
> +dontaudit $1 krb5_conf_t:file write;
> +allow $1 krb5_conf_t:file { getattr read };
> +')
<snip>
> diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.19.1/net_contexts
> --- nsapolicy/net_contexts	2004-11-09 13:35:11.000000000 -0500
> +++ policy-1.19.1/net_contexts	2004-11-10 17:30:03.500879161 -0500
> @@ -113,7 +113,6 @@
>  portcon tcp 631 system_u:object_r:ipp_port_t
>  portcon udp 631 system_u:object_r:ipp_port_t
>  ')
> -ifdef(`kerberos.te', `
>  portcon tcp 88 system_u:object_r:kerberos_port_t
>  portcon udp 88 system_u:object_r:kerberos_port_t
>  portcon tcp 749 system_u:object_r:kerberos_admin_port_t
> @@ -121,7 +120,6 @@
>  portcon udp 750 system_u:object_r:kerberos_port_t
>  portcon tcp 4444 system_u:object_r:kerberos_master_port_t
>  portcon udp 4444 system_u:object_r:kerberos_master_port_t
> -')
>  ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
>  ifdef(`rsync.te', `
>  portcon tcp 873 system_u:object_r:rsync_port_t

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
