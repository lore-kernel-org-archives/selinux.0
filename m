Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w11HW8HT015061
 for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2018 12:32:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3zXRlm2RhxzLj5s
 for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2018 17:23:16 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3zXRlm1QNnzLj5T
 for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2018 17:23:16 +0000 (UTC)
Received: by mail-pl0-f66.google.com with SMTP id o13so4018345pli.6
 for <selinux@tycho.nsa.gov>; Thu, 01 Feb 2018 09:23:14 -0800 (PST)
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, stable <stable@vger.kernel.org>,
 James Morris <jmorris@namei.org>
References: <20180201153708.63506-1-salyzyn@android.com>
 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
 <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
 <1517504530.1750.55.camel@tycho.nsa.gov>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <1445a6b4-1c4e-b684-62f6-1a6ff4af3fed@android.com>
Date: Thu, 1 Feb 2018 09:23:10 -0800
MIME-Version: 1.0
In-Reply-To: <1517504530.1750.55.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/01/2018 09:02 AM, Stephen Smalley wrote:
> On Thu, 2018-02-01 at 08:20 -0800, Mark Salyzyn wrote:
>> On 02/01/2018 08:00 AM, Paul Moore wrote:
>>> On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com>
>>> wrote:
>>>> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE
>>>> socket
>>>> flag") and all the associated infrastructure changes to take
>>>> advantage
>>>> of a RCU grace period before freeing, there is a heightened
>>>> possibility that a security check is performed while an ill-timed
>>>> setsockopt call races in from user space.  It then is prudent to
>>>> null
>>>> check sk_security, and if the case, reject the permissions.
>>>>
>>>> . . .
>>>> ---[ end trace 7b5aaf788fef6174 ]---
>>>>
>>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>>> Signed-off-by: Paul Moore <paul@linuxfoundation.org>
>>> No, in the previous thread I gave my ack, not my sign-off; please
>>> be
>>> more careful in the future.  It may seem silly, especially in this
>>> particular case, but it is an important distinction when things
>>> like
>>> the DCO are concerned.
>>>
>>> Anyway, here is my ack again.
>>>
>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>
>> Ok, both Greg KH and yours should be considered Acked-By. Been
>> overstepping this boundary for _years_. AFAIK Signed-off-by is still
>> pending from Stephen Smalley <sds@tycho.nsa.gov> before this can roll
>> in.
>>
>> Lesson lurned
> No, Paul's Acked-by is sufficient, and at most, I would only add
> another Acked-by or Reviewed-by, not a Signed-off-by.  Signed-off-by is
> only needed when one had something to do with the writing of the patch
> or was in the path by which it was merged.
>
> I don't object to this patch but I have a hard time adding another ack
> because I don't truly understand the root cause or how this fixes it.
> Let's say sk_prot_free() calls security_sk_free() calls
> selinux_sk_free_security() which sets sk->sk_security to NULL, and then
> we proceed to free the sksec and then sk_prot_free() frees the sk
> itself.  Now another sock is allocated (or perhaps a different object
> altogether), reuses that memory, and whatever sk->sk_security happens
> to contain is set to non-NULL.  We'll just blithely proceed past your
> check and who knows what will happen from that point onward.
>
The way I read this is this is part of an RCU operation. Multiple 
readers are holding on to the object, but as soon as a new writer comes 
in it _immediately_ frees the sk_security of the 'old' reader copies in 
order to make the 'new' writer copy. Any pending readers continue 
operations until they get tripped on the too aggressively released NULL 
sk_security reference.

Commits came in between 4.4 and 4.9 (edumazet@google.com) to restructure 
and fix this and add the appropriate RCU grace period to the 'old' 
reader copies for the sk_security resource so that it would be freed 
after all the readers had exited. Problem goes away.

My proposal will break any 'old' readers by blocking their access during 
the transition rather than panic the kernel. New readers coming in after 
the writer will progress fine.

This is not a 'bug' in the security layer, this is a bandaid to the 
security layer regarding the bad behavior of the callers.

I have not analyzed the code enough to 100% prove my assertion above, in 
part because I can not duplicate the problem w/o kasan+fuzzing, so still 
treat this as a hunch.

-- Mark
