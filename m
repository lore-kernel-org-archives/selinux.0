Subject: Re: Security Context Type Changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
References: 
	 <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jan 2010 09:15:14 -0500
Message-Id: <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-06 at 16:34 -0600, Tomas, Gregg A (IS) wrote:
> Hi
> 
>  
> 
> We are currently integrating our SELinux Policy on a RHEL5 machine.
> However, we are having difficulty in restricting our application
> within a specific directory because “something” changes our security
> context type of our users to init_t instead of unconfined_t. Root gets
> changed to (i.e. <user>:<role>:init_t). We are running with init level
> 4. We must have tried everything in the book to determine what changes
> the security context type of our users. Would anyone have any tips?
> 
>  
> 
> We did change inittab to run init level 5, touch /.autorelabel,
> rebooted, checked id –Z  and it is unconfined_t. However, ultimately
> we would like to run with init 4.

What is your /etc/inittab configuration for run level 4?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
