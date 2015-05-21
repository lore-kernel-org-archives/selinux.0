Message-ID: <555DEA32.4080205@tycho.nsa.gov>
Date: Thu, 21 May 2015 10:22:42 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
References: <1430337372-7758-1-git-send-email-jeffv@google.com>	<3147722.RboehMiu35@sifl>	<555DD091.8060307@tycho.nsa.gov>
 <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
In-Reply-To: <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2015 10:16 AM, Paul Moore wrote:
> On Thu, May 21, 2015 at 8:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/20/2015 05:22 PM, Paul Moore wrote:
>>>> @@ -64,6 +66,16 @@ struct avc_cache {
>>>>      u32                     latest_notif;   /* latest revocation notification */
>>>>  };
>>>>
>>>> +struct avc_operation_decision_node {
>>>> +    struct operation_decision od;
>>>> +    struct list_head od_list;
>>>> +};
>>>
>>> Making this more generic may mean adding an extra field here to specify the
>>> type of extension, e.g. ioctl commands.
>>>
>>>> +struct avc_operation_node {
>>>> +    struct operation ops;
>>>> +    struct list_head od_head; /* list of operation_decision_node */
>>>> +};
>>>
>>> As mentioned earlier, I think "operation" needs a name change; I tend to like
>>> "extop" better, e.g. "avc_extop_decision_node" and "avc_extop_node".  Feel
>>> free to suggest others.
>>>
>>> The "operation" struct is named poorly as well; even if we stick with
>>> "operation" elsewhere we really need to name this one better, it's way too
>>> generic.
>>
>> Don't want to bikeshed here, but I think "operation" is more readable
>> then "extop" (not evident what that means or even whether it is supposed
>> to be read as "ex-top" or "ext-op" or what).  "operation" at least is
>> meaningful and is a suitable generalization of "ioctl command".
> 
> I agree we're (okay, me) being a bit nitpicky here regarding names,
> but I really don't like "operation".  I'd much prefer if we could find
> something else that implies an extension to the existing 32
> permissions, maybe "extperm" or similar?
> 
> As I said earlier, I'm open to suggestions so long as they aren't "operation" :)

Well, let 's see what these values could possibly represent.  Presently
they are "ioctl commands".  "Netlink message types" are a possible use
case.  System call numbers would be a closer analogy than permissions,
as effectively this is a one-to-one mapping for kernel operations (oh,
whoops, there is that word again), so if we were doing this for normal
permission checking, we would be encoding the system call number instead.

Now, what word can be used to describe all of those things?  I have no
idea.  Operation seemed pretty close to me.
