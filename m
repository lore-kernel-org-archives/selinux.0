From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "lky" <lky77@sjtu.edu.cn>, "SELINUX" <SELinux@tycho.nsa.gov>
Subject: Re: questions about sysadm
Date: Wed, 12 Nov 2003 08:05:33 +1100
References: <000a01c3a892$805101f0$5d38a8c0@lky>
In-Reply-To: <000a01c3a892$805101f0$5d38a8c0@lky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200311120805.33472.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Nov 2003 07:29, lky wrote:
> Hi,I don't know why thers is sysadm in SELinux. Because it can do
> everything just like root of the traditional Linux.Is it secure?

It can't do everything that root can do.  Try creating device nodes, piping 
fsck output to a file, directly accessing block devices, etc.

> So I want to add a security administrator to the SELinux system and delete
> the security administration right from the sysadm. I add a user named
> secadm with the role secadm_r the type secadm_t as the securiry
> administrator. Secadm can access the contents under /etc/security/selinux
> and forbid sysadm to access it. Now I think I can do that.But the problem
> is that I can't run 'make reload' or 'make relabel' as secadm.When I run
> 'make reload' the errors as below:

Edit load_policy.te appropriately and change the lines referring to sysadm_r 
and sysadm_t.

But this is not all you need.  sysadm_t can still modify almost every file on 
the system, so it will be easy for them to get secadm_r if they want.

Implementing a sysadm vs secadm split will be really difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
