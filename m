Subject: Re: How to configure and reload selinux policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Jin, Yihua" <yihua.jin@intel.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A40176C48B@pdsmsx404.ccr.corp.intel.com>
References: 
	 <117E3EB5059E4E48ADFF2822933287A40176C48B@pdsmsx404.ccr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 09:21:49 -0400
Message-Id: <1158844909.3920.21.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 16:59 +0800, Jin, Yihua wrote:
> I used targeted policy 1.17 in RHEL4U4 
> 
> Modify the domain/unconfined_t, added:
> 
> Bool allow_execmem false;
> 
> If ( allow_execmem ) {
> 
>          Allow domain self :process execmem;
> 
> }
> 
> Than I type make reload to load this modified policy, but I find exec
> memory is still allowed by system.
> 
> That is, I check avc_has_perm and it allowed this operation.

Booleans are runtime options.  The value above is just the initial
value.  When you reload the policy on the running system, the boolean
states are preserved, so if allow_execmem was true before, then it would
stay true until you `setsebool allow_execmem 0`.  In addition, you don't
need to rebuild the policy to alter the initial value of the booleans,
you can edit the /etc/selinux/targeted/booleans file.  The values in
this file will be set when the policy is loaded the first time by init.

On a side note, I don't think the RHEL4 kernels have execmem checking,
so this rule has no effect.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
