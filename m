Message-Id: <200211072021.PAA07355@moss-shockers.ncsc.mil>
Date: Thu, 7 Nov 2002 15:21:21 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: default_context file
To: carstengrohmann@gmx.de, SELinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> From: Russell Coker <russell@coker.com.au>
> To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
>
> Actually the new setup for cron seems less capable than the old.
> 
> For example in the old setup I could setup an account bofh to have context 
> bofh:user_r:user_crond_t for cron even though that user may be authorised for 
> multiple roles.
> 
> If a hostile user manages to create a crontab file for the user then under the 
> old system the cron job just wouldn't be run because it would be in the wrong 
> context.  Under the new system the cron job would be run under the UID of the 
> victim user but with the security context of the attacking user, if the 
> attacking user is not permitted to change UID then this can give access to 
> the UID of the victim user which may allow undesired access.
> 
> So I think that the new system is easier to setup, but offers less control.

I'm not sure I follow you.  crond still performs a check between the user
context that will be used for the cron job process [obtained by asking the
security server for a set of legal SIDs for the user that can be reached
from crond's SID and then ordering based on default_contexts] and the file
context on the crontab spool file.  The crontab spool file is still labeled
based on the context of the creating process using a type transition rule.
If a hostile user in one domain manages to insert a crontab file for another 
user who is authorized for a different domain, the cron jobs from that crontab 
file still won't be executed in that other domain.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
