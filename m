Message-ID: <45B0C712.3090802@nagafix.co.uk>
Date: Fri, 19 Jan 2007 13:26:42 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        James Morris <jmorris@namei.org>
Subject: Re: 2.6.19.2 Oops
References: <45B09CFA.5070805@nagafix.co.uk> <1169212684.22731.488.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169212684.22731.488.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Looks like the patch below introduced a bug in the !mls_enabled case for
> mls_export_cat(), where it unconditionally sets *high and *high_len but
> selinux_netlbl_socket_setsid() calls it with NULL arguments there:
> http://marc.theaimsgroup.com/?l=git-commits-head&m=116101502503654&w=2
> 
> Seems to be obsoleted by:
> http://marc.theaimsgroup.com/?l=git-commits-head&m=116516927321105&w=2
> 
> Unless you need NetLabel (i.e. CIPSO labeling of packets, MLS only), you
> can workaround it by disabling CONFIG_NETLABEL (under Networking
> options) in your kernel config.
I don't use Netlabel atm, so I'll disable it and report back.
(it will take a while as the reboot needs to be scheduled)

Thanks!
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
