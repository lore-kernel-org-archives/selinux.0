Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB2EGPIi001871
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 09:16:25 -0500 (EST)
Message-ID: <41AF23B0.4020100@redhat.com>
Date: Thu, 02 Dec 2004 09:16:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Reissue previous patch
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <4192A029.5050909@redhat.com>	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>	 <419CB2A8.7020504@redhat.com>	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>	 <41A4B54F.3070709@redhat.com>	 <1101325733.12859.37.camel@moss-lions.epoch.ncsc.mil>	 <41ACE3E6.5030801@redhat.com> <1101995669.8032.20.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1101995669.8032.20.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>Merged with some changes.
>
>On Tue, 2004-11-30 at 16:19, Daniel J Walsh wrote:
>  
>
>>Several can_network_clients were wrong
>>    
>>
><snip>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.19.7/domains/program/mount.te
>>--- nsapolicy/domains/program/mount.te	2004-11-09 13:35:12.000000000 -0500
>>+++ policy-1.19.7/domains/program/mount.te	2004-11-30 06:18:45.000000000 -0500
>>@@ -64,7 +64,7 @@
>> 
>> ifdef(`portmap.te', `
>> # for nfs
>>-can_network(mount_t)
>>+can_network_server(mount_t)
>> can_ypbind(mount_t)
>> allow mount_t port_t:{ tcp_socket udp_socket } name_bind;
>> allow mount_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
>>    
>>
>
>Left it as can_network(), otherwise, I can't mount a NFS partition.  May
>be able to separate the NFS client and server usages, by I haven't
>looked into it.
>
><snip>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/howl.te policy-1.19.7/domains/program/unused/howl.te
>>--- nsapolicy/domains/program/unused/howl.te	2004-10-13 22:41:57.000000000 -0400
>>+++ policy-1.19.7/domains/program/unused/howl.te	2004-11-30 06:18:45.000000000 -0500
>>@@ -5,7 +5,7 @@
>> 
>> daemon_domain(howl)
>> allow howl_t proc_t:file { getattr read };
>>-can_network(howl_t)
>>+can_network_server(howl_t)
>> can_ypbind(howl_t)
>> allow howl_t self:capability { kill net_admin };
>> 
>>    
>>
>
>I used:
>-allow howl_t proc_t:file { getattr read };
>-can_network(howl_t)
>+allow howl_t proc_net_t:dir search;
>+allow howl_t proc_net_t:file {getattr read };
>+can_network_server(howl_t)
>
><snip>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.19.7/macros/program/ssh_macros.te
>>--- nsapolicy/macros/program/ssh_macros.te	2004-11-30 05:59:40.000000000 -0500
>>+++ policy-1.19.7/macros/program/ssh_macros.te	2004-11-30 06:18:45.000000000 -0500
>>@@ -82,7 +82,7 @@
>> 
>> # Grant permissions needed to create TCP and UDP sockets and
>> # to access the network.
>>-can_network($1_ssh_t)
>>+can_network_client_tcp($1_ssh_t)
>> can_ypbind($1_ssh_t)
>> 
>> # Use capabilities.
>>    
>>
>
>I used can_network_client() instead.
>
>The following was needed by ssh during my normal usage of it (like
>updating the CVS tree on sourceforge.)
>
>allow user_ssh_t self:udp_socket create
>
>  
>
I think this is caused by the resolver.  This is why I would like to get 
to the point of using
can_resolve() where we specify the exact port that you can connect to.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
