Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LFEMM4017823
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 11:14:22 -0400
Received: by oihb142 with SMTP id b142so557860oih.3
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 08:14:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQSA7KuDwL3x45iShSGgsd11Yv3vS=_O4BN_S=fhvrQgg@mail.gmail.com>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl> <555DD091.8060307@tycho.nsa.gov>
 <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
 <555DEA32.4080205@tycho.nsa.gov>
 <CAHC9VhQSA7KuDwL3x45iShSGgsd11Yv3vS=_O4BN_S=fhvrQgg@mail.gmail.com>
Date: Thu, 21 May 2015 08:14:18 -0700
Message-ID: <CABXk95ARYdCokbGYLW8REPjx_qH-X--xsZcCmLnRoGU7KP+nZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I selected operation because it is not ioctl specific. Stephen and I
had discussed the possibility of this being used for other things but
ultimately decided to focus on ioctls because that was my intended
use-case. I would be ok with other names, but I also thing the naming
could be kept the same and I could add clearer in-code comments to
better convey the extended operations or extended permissions idea.

On Thu, May 21, 2015 at 7:39 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, May 21, 2015 at 10:22 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/21/2015 10:16 AM, Paul Moore wrote:
>>> On Thu, May 21, 2015 at 8:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 05/20/2015 05:22 PM, Paul Moore wrote:
>>>>>> @@ -64,6 +66,16 @@ struct avc_cache {
>>>>>>      u32                     latest_notif;   /* latest revocation notification */
>>>>>>  };
>>>>>>
>>>>>> +struct avc_operation_decision_node {
>>>>>> +    struct operation_decision od;
>>>>>> +    struct list_head od_list;
>>>>>> +};
>>>>>
>>>>> Making this more generic may mean adding an extra field here to specify the
>>>>> type of extension, e.g. ioctl commands.
>>>>>
>>>>>> +struct avc_operation_node {
>>>>>> +    struct operation ops;
>>>>>> +    struct list_head od_head; /* list of operation_decision_node */
>>>>>> +};
>>>>>
>>>>> As mentioned earlier, I think "operation" needs a name change; I tend to like
>>>>> "extop" better, e.g. "avc_extop_decision_node" and "avc_extop_node".  Feel
>>>>> free to suggest others.
>>>>>
>>>>> The "operation" struct is named poorly as well; even if we stick with
>>>>> "operation" elsewhere we really need to name this one better, it's way too
>>>>> generic.
>>>>
>>>> Don't want to bikeshed here, but I think "operation" is more readable
>>>> then "extop" (not evident what that means or even whether it is supposed
>>>> to be read as "ex-top" or "ext-op" or what).  "operation" at least is
>>>> meaningful and is a suitable generalization of "ioctl command".
>>>
>>> I agree we're (okay, me) being a bit nitpicky here regarding names,
>>> but I really don't like "operation".  I'd much prefer if we could find
>>> something else that implies an extension to the existing 32
>>> permissions, maybe "extperm" or similar?
>>>
>>> As I said earlier, I'm open to suggestions so long as they aren't "operation" :)
>>
>> Well, let 's see what these values could possibly represent.  Presently
>> they are "ioctl commands".  "Netlink message types" are a possible use
>> case.  System call numbers would be a closer analogy than permissions,
>> as effectively this is a one-to-one mapping for kernel operations (oh,
>> whoops, there is that word again), so if we were doing this for normal
>> permission checking, we would be encoding the system call number instead.
>
>  :)
>
>> Now, what word can be used to describe all of those things?  I have no
>> idea.  Operation seemed pretty close to me.
>
> How about you Jeff, any ideas?
>
> --
> paul moore
> www.paul-moore.com
