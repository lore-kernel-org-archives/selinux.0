Message-ID: <1382727323.3041.176.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Fri, 25 Oct 2013 20:55:23 +0200
In-Reply-To: <526ABB18.2070008@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov> <1382723585.3041.169.camel@d30>
	 <526ABB18.2070008@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-25 at 14:40 -0400, James Carter wrote:

> 
> This looks correct and the branch is enabled. I don't know why it is not 
> working. I will take a look.
> 
> >> # ausearch -m user_avc,avc,selinux_err -ts 19:35 -i | grep sys_module | audit2why
> >> type=AVC msg=audit(10/25/2013 19:35:43.392:140) : avc:  denied  { sys_module } for  pid=494 comm=modprobe capability=sys_module  scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:system_r:kernel_t:s0 tclass=capability
> >>
> >>          Was caused by:
> >>          The boolean secure_mode_policyload was set incorrectly.
> >>          Description:
> >>          Allow secure to mode policyload
> >>
> >>          Allow access by executing:
> >>          # setsebool -P secure_mode_policyload 1

By the way look at that audit2why output, its talking about a whole
different boolean there since its not secure_mode_policyload, but rather
secure_mode_insmod...

The point is that i am getting this avc denial at boot, and audit2allow
say's it would have been allowed by current policy.

Almost just like my other dbus issue, very strange (showing avc denials
for things that are allowed in policy)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
