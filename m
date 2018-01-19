Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0JHYfpa018847
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 12:34:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zNScw428Jz18llQ
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 17:34:40 +0000 (UTC)
Received: from UPDC3CPA05.eemsg.mil (unknown [192.168.18.12])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zNScw2V3jz18llN
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 17:34:40 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id t5so1861833pfi.0
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 09:34:39 -0800 (PST)
To: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, stable@vger.kernel.org
References: <20180118215853.228182-1-salyzyn@android.com>
 <1516382386.2560.11.camel@tycho.nsa.gov>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <fe1be13d-3242-8f60-aa53-71e2548b7858@android.com>
Date: Fri, 19 Jan 2018 09:34:36 -0800
MIME-Version: 1.0
In-Reply-To: <1516382386.2560.11.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/19/2018 09:19 AM, Stephen Smalley wrote:
> On Thu, 2018-01-18 at 13:58 -0800, Mark Salyzyn wrote:
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> . . .
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 8644d864e3c1..95d7c8143373 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4342,7 +4342,7 @@ static int sock_has_perm(struct sock *sk, u32
>> perms)
>>   	struct common_audit_data ad;
>>   	struct lsm_network_audit net = {0,};
>>   
>> -	if (sksec->sid == SECINITSID_KERNEL)
>> +	if (!sksec || sksec->sid == SECINITSID_KERNEL)
>>   		return 0;
> The patch description says "null check the sk_security, and if the
> case, reject the permissions."  The patch code instead has it return
> 0/success, i.e. permission granted.  Which one is correct?
<oops> -EACCESS would be advised, yes. THANKS.

<please remove my mistake from my permanent record ;-} >
> If we
> return -EACCES, then we might break userspace; if we return 0, we might
> be allowing an operation that should have been denied.  Both seem like
> losing propositions.
if the sk_security is NULL, it is in-effect a form of UAF, so kernel 
_and_ user space is already 'sick'. I think it is a significantly larger 
losing proposition to panic the kernel? Reporting -EACCESS (as was 
proper) is a error propagation way to let user space deal with the 
erroneous condition.

>
> Could we instead have selinux_sk_free_security() defer freeing of the
> sock security blob to a call_rcu(), like we did for
> inode_free_security, or change the caller of it to not free it until
> the sock is truly freed?

AFAIK the upper issue is the premature closing on an RCU protected 
object, and the _right_ answer is that its call should have been 
properly deferred to a synchronization or grace period. Having 
sk_free_security be deferred by the grace period runs the risk that it 
is in a race with the proper deletion of a languishing read object in an 
RCU. It is a bug in the upper layers. My proposal in this KISS stability 
patch is to make security deal with those bugs gracefully until all 
those issues are fixed (in ToT).

-- Mark
