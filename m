Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h712CLHa006843
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 22:12:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h712CKDW002331
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 02:12:20 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h712CIeN002323 for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 02:12:20 GMT
Message-Id: <200308010212.AA01029@ilios104.ori.hitachi-sk.co.jp>
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Date: Fri, 01 Aug 2003 11:12:04 +0900
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov, ynakam@ori.hitachi-sk.co.jp
Subject: Re: macro about network
In-Reply-To: <200307311437.21069.russell@coker.com.au>
References: <200307311437.21069.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>However I suggest that we get the port binding done properly first.
>Currently even my tree doesn't have the bind permissions changes complete, and in the NSA tree every domain can 
bind to every port.
 
I agree this.
In current policy,can_network macro allow domain to bind to port_t.

>I encourage you to investigate my policy in 
>http://www.coker.com.au/selinux/policy.tgz and let me know of any 
>improvements that can be made to the port binding rules.

I looked over your policy.
In your policy, only 7 domains are allowed to bind to port_t.
It is very good.

However,it may not be easy for user to understand whether a domain is allowed to use only unreserved ports over 
1024 or all unreserved ports. 

For example, in rpcd_t.te it would be better to describe like this.
########### your original policy:
# Use capabilities.
allow rpcd_t self:capability { net_bind_service dac_override setgid setuid };
# bind to arbitary unused ports
allow rpcd_t port_t:{ tcp_socket udp_socket } name_bind;

########### my suggestion:
# Use capabilities.
allow rpcd_t self:capability { dac_override setgid setuid };
# bind to arbitary unused ports,including well-known ports.
allow rpcd_t self:capability { net_bind_service }; #use well-known ports
allow rpcd_t port_t:{ tcp_socket udp_socket } name_bind;

It may be good to make macro,like this.
#can bind to unreserved ports over 1024
#class:tcp_socket/udp_socket
can_bind_unpriv_port(domain,class) 
#can bind to all unreserved ports including well-known port
can_bind_all_unreserved_port(domain,class)

>One issue that I am currently considering is how to label ports for X to bind 
>to.  Ports 6000..6009 need to be reserved for the X servers, and 6010..6030 
>are commonly used by sshd for X proxying.  I am thinking of having a 
>configuration option for ssh to determine whether sshd is allowed to run X 
>proxying, and if so those ports would be reserved for it.
>What do you think?

Some "define" statement in sshd.te will be necessary, 
but I don't have good idea about this now ,sorry. 
I have not tried X forwarding in SELinux yet.

Thank you.

Russell Coker Wrote:
>On Tue, 29 Jul 2003 19:49, Yuichi Nakamura wrote:
>> In "can_network" macro,
>> "allow $1 netmsg_type:tcp_socket { connectto acceptfrom };"
>> exists.
>>
>> I think in some case "connectto" permission is not neccesary.
>
>That sounds reasonable.  However I suggest that we get the port binding done 
>properly first.
>
>Currently even my tree doesn't have the bind permissions changes complete, and 
>in the NSA tree every domain can bind to every port.
>
>I encourage you to investigate my policy in 
>http://www.coker.com.au/selinux/policy.tgz and let me know of any 
>improvements that can be made to the port binding rules.
>
>One issue that I am currently considering is how to label ports for X to bind 
>to.  Ports 6000..6009 need to be reserved for the X servers, and 6010..6030 
>are commonly used by sshd for X proxying.  I am thinking of having a 
>configuration option for ssh to determine whether sshd is allowed to run X 
>proxying, and if so those ports would be reserved for it.
>
>What do you think?
>
>-- 
>http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
>http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
>http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
>http://www.coker.com.au/~russell/  My home page
>
>

--------------------
Yuichi Nakamura
Research&Development Department
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp
http://www.selinux.hitachi-sk.co.jp/en/(SELinux Policy Editor)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
