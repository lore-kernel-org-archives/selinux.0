Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Date: Mon, 22 Apr 2002 23:37:54 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524354@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524354@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020422213755.3317C1862@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Apr 2002 14:40, Westerman, Mark wrote:
> Current SELinux package
> 	selinux-<kernel version>-<NSA Release number>
> 	Current planed release:
> 		selinux-2.4.18-2002031409.i386.rpm
> 		selinux-dev-2.4.18-2002031409.i838.rpm

Why have the kernel version in the package name?  The NSA is only making 
releases for the latest kernel.  I've backported a couple of the changes to 
an older kernel, but AFAIK no-one else is doing so.

Also the relevant thing is not the kernel version but the policy version.  

What we need to eventually do is split checkpolicy out into a separate 
package so we can have multiple versions installed, then we need to have the 
ability to compile multiple versions and load the version that matches the 
kernel (how do we determine the policy version in the running kernel?).

Maybe the load_policy program should be able to look at a directory full of 
policy files and load the one that matches the kernel policy version?

> If future releases of selinux I think we should sub-divided into
> more packages
> 	selinux-kernel-<kernel version>-<NSA Release number>
> 	selinux-policy-<version number>-<release>
> 	selinxu-utils-<version number>-<release>
> 		To include newrole, run_init and ......
> 		Or a separate rpm for utility ?

Why split the sample policy from the utilities?  Why would you use one 
without the other?

> Currently there is a question if any package should rebuild the
> policy. The current rpm I am building will only build a policy
> if /etc/selinux/policy does not exist. It created it and installs
> the example policy. Other wise if /etc/selinux/policy exist the
> install will not touch the policy.

Same here.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
