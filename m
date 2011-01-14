Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0ELlRFI022597
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 16:47:27 -0500
Received: from smtp109.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p0ELlQ32007738
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 21:47:26 GMT
Message-ID: <4D30C468.9040400@schaufler-ca.com>
Date: Fri, 14 Jan 2011 13:47:20 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: mohit verma <mohit89mlnc@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: audit function
References: <AANLkTimFDVmgtFCkUEKV=mUDBCOQMX4-owM+gTes0X7v@mail.gmail.com>
In-Reply-To: <AANLkTimFDVmgtFCkUEKV=mUDBCOQMX4-owM+gTes0X7v@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/14/2011 1:17 AM, mohit verma wrote:
> hi folks,
>  can someone  help me understand the use of  the function
>  selinux_audit_rule_init <http://lxr.linux.no/linux+*/+code=selinux_audit_rule_init>(u32 <http://lxr.linux.no/linux+*/+code=u32> field <http://lxr.linux.no/linux+*/+code=field>, u32 <http://lxr.linux.no/linux+*/+code=u32> op <http://lxr.linux.no/linux+*/+code=op>, char *rulestr <http://lxr.linux.no/linux+*/+code=rulestr>, void **vrule <http://lxr.linux.no/linux+*/+code=vrule>);
>
>
>   does this function gets initialized at initramfs or later on to log the data? i mean i am completely blank at this function.
>
> thanks in advance to elaborate on it.

You will find it called (twice) in kernel/auditfilter.c
as security_audit_rule_init. This is an LSM hook.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
