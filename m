Message-ID: <1382723585.3041.169.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Fri, 25 Oct 2013 19:53:05 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

Is it me or is the negator "not" not working here:

> (boolean secure_mode_insmod false)

> (booleanif (not secure_mode_insmod)
>   (true
>     (allow loadkernelmodule self (capability (sys_module sys_nice)))
>     (allow loadkernelmodule kernel_t (process (setsched)))))
> 


> (macro kernel_load_module ((type ARG1))
>   (typeattributeset loadkernelmodule ARG1))

> (call kernel_load_module (kernel_t))

> # getsebool -a | grep insmod
> secure_mode_insmod --> off


> # sesearch -ASCT -p sys_module | grep insmod
> ET allow kernel_t kernel_t : capability { sys_module sys_nice } ; [ secure_mode_insmod ! ]

> # ausearch -m user_avc,avc,selinux_err -ts 19:35 -i | grep sys_module | audit2why
> type=AVC msg=audit(10/25/2013 19:35:43.392:140) : avc:  denied  { sys_module } for  pid=494 comm=modprobe capability=sys_module  scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:system_r:kernel_t:s0 tclass=capability 
> 
>         Was caused by:
>         The boolean secure_mode_policyload was set incorrectly. 
>         Description:
>         Allow secure to mode policyload
> 
>         Allow access by executing:
>         # setsebool -P secure_mode_policyload 1




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
