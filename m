Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0CH0Xtu027191
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 12:00:34 -0500
Received: by mail-vk0-f65.google.com with SMTP id r136so1860721vke.1
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 09:00:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a8eb15b3-cef1-8b55-e757-102f4ccd04fc@schaufler-ca.com>
References: <1484069312-26653-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhSbwTsR0QhGA8+JGX1EQ+Z73S-iD1Ys-XjQjh3jbvVtxA@mail.gmail.com>
 <a8eb15b3-cef1-8b55-e757-102f4ccd04fc@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Jan 2017 12:00:28 -0500
Message-ID: <CAHC9VhQNtX4k-mwHweV=4osaYCv=0HcxxwWRPZu_7ruTT1f7tA@mail.gmail.com>
Subject: Re: [PATCH] security,selinux,smack: kill security_task_wait hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 yangshukui@huawei.com, oleg@redhat.com,
 linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 12, 2017 at 11:49 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 1/12/2017 8:03 AM, Paul Moore wrote:
>> On Tue, Jan 10, 2017 at 12:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> As reported by yangshukui, a permission denial from security_task_wait()
>>> can lead to a soft lockup in zap_pid_ns_processes() since it only expects
>>> sys_wait4() to return 0 or -ECHILD. Further, security_task_wait() can
>>> in general lead to zombies; in the absence of some way to automatically
>>> reparent a child process upon a denial, the hook is not useful.  Remove
>>> the security hook and its implementations in SELinux and Smack.  Smack
>>> already removed its check from its hook.
>>>
>>> Reported-by: yangshukui <yangshukui@huawei.com>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> In case you miss my earlier Ack.

Yep, already go it.  I just wanted to try and avoid the situation
where both of us push this patch up to James for the next merge
window.

>>> ---
>>>  include/linux/lsm_hooks.h  |  7 -------
>>>  include/linux/security.h   |  6 ------
>>>  kernel/exit.c              | 19 ++-----------------
>>>  security/security.c        |  6 ------
>>>  security/selinux/hooks.c   |  7 -------
>>>  security/smack/smack_lsm.c | 20 --------------------
>>>  6 files changed, 2 insertions(+), 63 deletions(-)
>> Looks good to me and I'm not seeing any objections so I'll go ahead
>> and merge this into the selinux/next branch today unless Casey already
>> merged this into the Smack tree - Casey?
>
> Please go ahead and merge into the SELinux tree.
> It makes sense to do this atomically.
> Thank you.

Agreed.  It should be in selinux/next now if you want to play.

-- 
paul moore
www.paul-moore.com
