Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBKGLHnL013552
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 11:21:19 -0500
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: =?UTF-8?Q?Jos=c3=a9_Bollo?= <jobol@nonadev.net>,
 John Johansen <john.johansen@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <8e8baad3-f39e-8d3a-661d-3302a96d43f1@canonical.com>
 <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
 <1482244841.2203.5.camel@nonadev.net>
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <77fecdfb-d49d-a9fb-bdd0-bde97032015f@schaufler-ca.com>
Date: Tue, 20 Dec 2016 08:21:06 -0800
MIME-Version: 1.0
In-Reply-To: <1482244841.2203.5.camel@nonadev.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/20/2016 6:40 AM, José Bollo wrote:
> Le lundi 19 décembre 2016 à 13:25 -0800, Casey Schaufler a écrit :
>
> snip
>> A brief look at the existing modules leads me to believe that
>> everyone ought to be happier if we moved the LSM task blob out
>> of the cred structure. SELinux keeps a small (6xu32) task blob
>> that has no reason to share and refcount. Smack has a couple of
>> lists in the task blob that really shouldn't be in the cred.
>> There would have to be some rework of the task_alloc and task_free
>> hooks to get the life of the blobs correct, but I think on the
>> whole it would be lots cleaner.
>>
> Hi Casey,
>
> Let suppose that creds is, in effect, the wrong place for implementing
> PTAGS and let suppose that the correct way is to add a t_ptags element
> in the task structure.
>
> How to use task_alloc and task_free? There is nothing there. Is it just
> possible to inherit or copy the parent attributes? no.
>
> So there is a need to define a hook to copy or do something for the
> child based on the parent. A new hook, a kind of 'task_child_init'
> whose argument would be the task to init.
>
> Is it it?
>
> Best regards
> José Bollo

My suggestion at this point is that we introduce a "t_security"
field to task_struct (in include/linux/sched.h) under #CONFIG_SECURITY.
There is already a task_free hook that should suffice, but the existing
task_create hook will either need to be changed to get passed the
task_struct or supplemented with a task_alloc hook. A copy_task hook
may prove necessary, but we'll have to look into that. Security module
data that belongs associated with the task needs to get moved, but that
can be done by the module maintainers. It doesn't sound like there
would be resistance to this from the security side of the house, but
it needs to get run past the task management maintainers. A patch set,
used by an existing module would be the best approach for that. I
do not think that Smack is a good example as it is the one module that
would probably be best served by having some data in both places.
