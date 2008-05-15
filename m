Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4F0c95g026998
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 20:38:09 -0400
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4F0c74Y021268
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2008 00:38:08 GMT
Date: Thu, 15 May 2008 10:37:47 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: keep the code clean formating and syntax
In-Reply-To: <1210778865.3216.13.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0805151037340.21686@us.intercode.com.au>
References: <1210778865.3216.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 May 2008, Eric Paris wrote:

> Formatting and syntax changes
> 
> whitespace, tabs to spaces, trailing space
> put open { on same line as struct def
> remove unneeded {} after if statements
> change printk("Lu") to printk("llu")
> convert asm/uaccess.h to linux/uaacess.h includes
> remove unnecessary asm/bug.h includes
> convert all users of simple_strtol to strict_strtol
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to for-akpm.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
