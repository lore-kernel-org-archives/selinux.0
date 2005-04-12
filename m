Message-ID: <425BCF41.80403@redhat.com>
Date: Tue, 12 Apr 2005 09:38:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux@tycho.nsa.gov
Subject: Re: named policy patch
References: <200504122326.33930.russell@coker.com.au>
In-Reply-To: <200504122326.33930.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>The attached patch allows named to correctly start on FC4T2 with the strict 
>policy when unlimitedRC is commented.
>
>  
>
>------------------------------------------------------------------------
>
>diff -u old/named.fc new/named.fc
>--- old/named.fc	2005-04-12 23:24:32.000000000 +1000
>+++ new/named.fc	2005-04-12 23:24:23.000000000 +1000
>@@ -16,6 +16,7 @@
> /etc/rndc.*		--	system_u:object_r:named_conf_t
> /etc/rndc.key  		-- 	system_u:object_r:dnssec_t
> /usr/sbin/named      	--	system_u:object_r:named_exec_t
>+/usr/sbin/named-checkconf --	system_u:object_r:named_checkconf_exec_t
> /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
> /var/run/ndc		-s	system_u:object_r:named_var_run_t
> /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
>diff -u old/named.te new/named.te
>--- old/named.te	2005-04-12 23:24:39.000000000 +1000
>+++ new/named.te	2005-04-12 23:24:45.000000000 +1000
>@@ -15,6 +15,9 @@
> daemon_domain(named, `, nscd_client_domain')
> tmp_domain(named)
> 
>+type named_checkconf_exec_t, file_type, exec_type, sysadmfile;
>+domain_auto_trans(initrc_t, named_checkconf_exec_t, named_t)
>+
> # For /var/run/ndc used in BIND 8
> file_type_auto_trans(named_t, var_run_t, named_var_run_t, sock_file)
> 
>  
>
Why not just label chckconf as named_exec_t?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
