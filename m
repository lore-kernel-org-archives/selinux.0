Subject: Re: checkpolicy constraints bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200508102332.48483.russell@coker.com.au>
References: <200508102332.48483.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 11:16:41 -0400
Message-Id: <1123687001.3018.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-10 at 23:32 +1000, Russell Coker wrote:
> constrain process transition
>       ( r1 == r2 or ( t1 == privrole and t2 == userdomain )
> ifdef(`crond.te', `
>          or (t1 == crond_t and t2 == user_crond_domain)
> ')
> ifdef(`userhelper.te',
>       `or (t1 == userhelperdomain)')
> ifdef(`postfix.te', `
> ifdef(`direct_sysadm_daemon',
>       `or (t1 == sysadm_mail_t and t2 == system_mail_t and r2 == system_r )')
> ')
>        or (t1 == priv_system_role and r2 == system_r )
>         );
> 
> 
> The above section in the constraints file for the strict policy works with 
> checkpolicy version 1.23.1-1 (FC4 release) but fails with 1.25.3-1 (latest 
> rawhide).

Yes, reproduced it here as well.  Looks like a bug in the module
expansion code for constraint sets.  I have a patch in testing now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
