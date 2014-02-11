Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1B1HpvG014390
 for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2014 20:17:51 -0500
Message-ID: <52F97A62.2090500@windriver.com>
Date: Tue, 11 Feb 2014 09:18:26 +0800
From: Rongqing Li <rongqing.li@windriver.com>
MIME-Version: 1.0
To: bigclouds <bigclouds@163.com>
Subject: Re: how to change the context of running process
References: <7a7a5f0f.8499.1441971524d.Coremail.bigclouds@163.com>
In-Reply-To: <7a7a5f0f.8499.1441971524d.Coremail.bigclouds@163.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 02/10/2014 09:37 AM, bigclouds wrote:
> hi,all
> 1.
> how to change the context of running process.
> 2.
> in my case, libvirtd is initrc_t, how to find  where and which file defines this rule?
> libvirtd should be virtd_t, i want to correct it.

The scontext should be virtd_exec_t, and the process
context should be virtd_t, it is defined in virt.fc.

./policy/modules/contrib/virt.fc:/usr/sbin/libvirtd	-- 
gen_context(system_u:object_r:virtd_exec_t,s0)


Please make sure the libvirtd is installed into correct path.

> 3.audot2allow outputs a rule ,'allow initrc_t svirt_t:process transition'
> is there a comamnd line tool can finish this request?  not to install .pp module?

the correct transition rule should be

./virt.tmp:	allow initrc_t virtd_t:process transition;
./virt.tmp:	type_transition initrc_t virtd_exec_t:process virtd_t;

-Roy

>
> thanks
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>

-- 
Best Reagrds,
Roy | RongQing Li
