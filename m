Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3GNrXZ015872
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 11:23:53 -0500 (EST)
Message-ID: <4189060A.1010003@redhat.com>
Date: Wed, 03 Nov 2004 11:23:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com> <200411031641.59816.russell@coker.com.au>
In-Reply-To: <200411031641.59816.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Wednesday 03 November 2004 02:56, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Updated with Russell's "daemon" change and other fixes.
>>
>>How does this look?
>>    
>>
>
>+can_network($1_login_t) 
>+allow $1_login_t self:{ tcp_socket udp_socket } connect;
>
>local_login_t does not need network access unless you use NIS or similar.  
>can_ypbind() may be appropriate, but no other rules for network access for 
>$1_login_t.
>
>Your patch is allowing many domains access to { tcp_socket udp_socket } 
>connect which have no need for network connections other than ypbind.  It's 
>probably best to just add this to can_ypbind and not add it to ANY daemon 
>policy except for daemons which obviously need it.  Otherwise this change 
>will make the policy weaker overall by explicitely adding permissions where 
>they are not needed.  If we don't have the time to do this properly right now 
>then we should leave can_network as it is until we have more time to work on 
>it.
>
>  
>
Not true.  pam_kerberos, pam_ldap require network access.  login already 
has can_ypbind, which
used to be turned on by default.  Now there is a boolean to turn it off. 
and it is off by default, because it
gives too many privs.  The problem is that these other protocols are 
also allowed/required.   So this policy
is actually  tighter since the allow_ypbind is now off.

>Probably the best thing to do is to merge a patch that doesn't allow such 
>access to any daemon apart from the most obvious cases (EG allowing a mail 
>server to make TCP connections).  Things will work for the binary policy in 
>Fedora as NIS support is enabled.  Then we can spend the next couple of 
>months testing out all the daemons and submitting patches for exactly the 
>connection access that is required.
>
>
>+mount_domain(sysadm, mount, `, fs_domain, nscd_client_domain')
>
>What does mount do that requires nscd access?
>
>  
>
NFS Mounts probably.

>Why does user_ssh_t require kill capability?
>
>Does dhcpc_t require TCP connection access when there is no NIS?
>
>  
>
Not sure.

>Does innd_t require UDP connection access when there is no NIS?
>
>
>  
>
Probably not.

>sys_tty_config capability is another thing that should go into 
>daemon_base_domain(), but as a dontaudit.
>
>  
>
Ok.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
