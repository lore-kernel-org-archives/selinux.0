Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: default_context file
Date: Mon, 4 Nov 2002 00:48:49 +0100
References: <200211031746.RAA13749@jazzband.ncsc.mil>
In-Reply-To: <200211031746.RAA13749@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211040048.50097.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 3 Nov 2002 19:47, Carsten Grohmann wrote:
> I've don't understand the new default_context file. Could anybody explain
> it? I understand the entries for login and ssh, but the line for the crond
> I to stupid.
> The crond can use both partial context (user_r:user_crond_t and
> system_r:system_crond_t) but I don't unterstand the selection mechanism.

Actually the new setup for cron seems less capable than the old.

For example in the old setup I could setup an account bofh to have context 
bofh:user_r:user_crond_t for cron even though that user may be authorised for 
multiple roles.

If a hostile user manages to create a crontab file for the user then under the 
old system the cron job just wouldn't be run because it would be in the wrong 
context.  Under the new system the cron job would be run under the UID of the 
victim user but with the security context of the attacking user, if the 
attacking user is not permitted to change UID then this can give access to 
the UID of the victim user which may allow undesired access.

So I think that the new system is easier to setup, but offers less control.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
