Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA35phXZ012698
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 00:51:44 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA35oK4w025931
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 05:50:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Date: Wed, 3 Nov 2004 16:41:59 +1100
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com>
In-Reply-To: <4187AE44.40204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411031641.59816.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 November 2004 02:56, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Updated with Russell's "daemon" change and other fixes.
>
> How does this look?

+can_network($1_login_t) 
+allow $1_login_t self:{ tcp_socket udp_socket } connect;

local_login_t does not need network access unless you use NIS or similar.  
can_ypbind() may be appropriate, but no other rules for network access for 
$1_login_t.

Your patch is allowing many domains access to { tcp_socket udp_socket } 
connect which have no need for network connections other than ypbind.  It's 
probably best to just add this to can_ypbind and not add it to ANY daemon 
policy except for daemons which obviously need it.  Otherwise this change 
will make the policy weaker overall by explicitely adding permissions where 
they are not needed.  If we don't have the time to do this properly right now 
then we should leave can_network as it is until we have more time to work on 
it.

Probably the best thing to do is to merge a patch that doesn't allow such 
access to any daemon apart from the most obvious cases (EG allowing a mail 
server to make TCP connections).  Things will work for the binary policy in 
Fedora as NIS support is enabled.  Then we can spend the next couple of 
months testing out all the daemons and submitting patches for exactly the 
connection access that is required.


+mount_domain(sysadm, mount, `, fs_domain, nscd_client_domain')

What does mount do that requires nscd access?

Why does user_ssh_t require kill capability?

Does dhcpc_t require TCP connection access when there is no NIS?

Does innd_t require UDP connection access when there is no NIS?


sys_tty_config capability is another thing that should go into 
daemon_base_domain(), but as a dontaudit.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
