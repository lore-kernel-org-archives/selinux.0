From: carstengrohmann@gmx.de
Date: Mon, 4 Nov 2002 09:48:29 +0100 (MET)
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
References: <200211040048.50097.russell@coker.com.au>
Subject: Re: default_context file
Message-ID: <29857.1036399709@www54.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That's clear, but I give the crond two partial context. But I don't
understand who select crond the right context for the acutell user. Try crond the
first partial context for the user and after it failed the next and so on? 

> On Sun, 3 Nov 2002 19:47, Carsten Grohmann wrote:
> > I've don't understand the new default_context file. Could anybody
> explain
> > it? I understand the entries for login and ssh, but the line for the
> crond
> > I to stupid.
> > The crond can use both partial context (user_r:user_crond_t and
> > system_r:system_crond_t) but I don't unterstand the selection mechanism.
> 
> Actually the new setup for cron seems less capable than the old.
> 
> For example in the old setup I could setup an account bofh to have context
> 
> bofh:user_r:user_crond_t for cron even though that user may be authorised
> for 
> multiple roles.
> 
> If a hostile user manages to create a crontab file for the user then under
> the 
> old system the cron job just wouldn't be run because it would be in the
> wrong 
> context.  Under the new system the cron job would be run under the UID of
> the 
> victim user but with the security context of the attacking user, if the 
> attacking user is not permitted to change UID then this can give access to
> 
> the UID of the victim user which may allow undesired access.
> 
> So I think that the new system is easier to setup, but offers less
> control.

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
