Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7T4HBcb032518
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 00:17:11 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7T4HBJB020629
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 04:17:11 GMT
Message-ID: <46D4F337.1030704@manicmethod.com>
Date: Wed, 29 Aug 2007 00:16:55 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        sailer@us.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
References: <1188340501.11528.14.camel@localhost.localdomain>
In-Reply-To: <1188340501.11528.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mimi Zohar wrote:
> This is a second attempt to verify and measure file integrity, by
> adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> This posting addresses comments previously made on this list. 
> I will also post the current set of LIM patches, as well as an
> initial integrity.te example. 
>
> The integrity of the SELinux metadata is verified when the xattr
> is initially retrieved.  On an integrity failure, normal selinux 
> error processing occurs.
>
> This patch defines a new 'integrity' class with the permission 
> 'measure'.  Measurement calls are made in selinux_file_mmap(), 
> selinux_bprm_check_security, and selinux_inode_permission(),
> based on policy.  (Additional calls might be required.)
>
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> <snip>
>  
> Index: linux-2.6.23-rc3-mm1/security/selinux/include/av_permissions.h
> ===================================================================
> --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/av_permissions.h
> +++ linux-2.6.23-rc3-mm1/security/selinux/include/av_permissions.h
> @@ -824,3 +824,4 @@
>  #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
>  #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
>  #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
> +#define INTEGRITY__MEASURE                        0x00000001UL
> Index: linux-2.6.23-rc3-mm1/security/selinux/include/av_perm_to_string.h
> ===================================================================
> --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/av_perm_to_string.h
> +++ linux-2.6.23-rc3-mm1/security/selinux/include/av_perm_to_string.h
> @@ -159,3 +159,4 @@
>     S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
>     S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
>     S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
> +   S_(SECCLASS_INTEGRITY, INTEGRITY__MEASURE, "measure")
>   

Do you really need another object class for this? What is wrong with the 
file object class? eg., a rule like:

allow insmod_t modules_object_t : file { read measure };
would require a measurement.

> Index: linux-2.6.23-rc3-mm1/security/selinux/include/flask.h
> ===================================================================
> --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/flask.h
> +++ linux-2.6.23-rc3-mm1/security/selinux/include/flask.h
> @@ -50,6 +50,7 @@
>  #define SECCLASS_KEY                                     58
>  #define SECCLASS_DCCP_SOCKET                             60
>  #define SECCLASS_MEMPROTECT                              61
> +#define SECCLASS_INTEGRITY                               62
>  
>  /*
>   * Security identifier indices for initial entities
> Index: linux-2.6.23-rc3-mm1/security/selinux/include/class_to_string.h
> ===================================================================
> --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/class_to_string.h
> +++ linux-2.6.23-rc3-mm1/security/selinux/include/class_to_string.h
> @@ -64,3 +64,4 @@
>      S_(NULL)
>      S_("dccp_socket")
>      S_("memprotect")
> +    S_("integrity")
> Index: linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> ===================================================================
> --- linux-2.6.23-rc3-mm1.orig/security/selinux/ss/services.c
> +++ linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> @@ -305,12 +305,12 @@ static int context_struct_compute_av(str
>  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
>  			tclass = SECCLASS_NETLINK_SOCKET;
>  
> -	if (!tclass || tclass > policydb.p_classes.nprim) {
> -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> -		       tclass);
> -		return -EINVAL;
> -	}
> -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +//	if (!tclass || tclass > policydb.p_classes.nprim) {
> +//		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> +//		       tclass);
> +//		return -EINVAL;
> +//	}
> +//	tclass_datum = policydb.class_val_to_struct[tclass - 1];
>  
>   

Err? Did you mean to submit it like this? This should be fixed by Eric's 
patch to handle unknown classes anyway.

>  	/*
>  	 * Initialize the access vectors to the default values.
> @@ -321,6 +321,10 @@ static int context_struct_compute_av(str
>  	avd->auditdeny = 0xffffffff;
>  	avd->seqno = latest_granting;
>  
> +	if (!tclass || tclass > policydb.p_classes.nprim)
> +		return 0;
> +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +
>   

Ditto.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
