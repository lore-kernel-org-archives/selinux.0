Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEGWeI012911
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:16:32 -0400
Received: by oiww2 with SMTP id w2so12039666oiw.0
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:16:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555DD091.8060307@tycho.nsa.gov>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl> <555DD091.8060307@tycho.nsa.gov>
Date: Thu, 21 May 2015 10:16:31 -0400
Message-ID: <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 21, 2015 at 8:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/20/2015 05:22 PM, Paul Moore wrote:
>>> @@ -64,6 +66,16 @@ struct avc_cache {
>>>      u32                     latest_notif;   /* latest revocation notification */
>>>  };
>>>
>>> +struct avc_operation_decision_node {
>>> +    struct operation_decision od;
>>> +    struct list_head od_list;
>>> +};
>>
>> Making this more generic may mean adding an extra field here to specify the
>> type of extension, e.g. ioctl commands.
>>
>>> +struct avc_operation_node {
>>> +    struct operation ops;
>>> +    struct list_head od_head; /* list of operation_decision_node */
>>> +};
>>
>> As mentioned earlier, I think "operation" needs a name change; I tend to like
>> "extop" better, e.g. "avc_extop_decision_node" and "avc_extop_node".  Feel
>> free to suggest others.
>>
>> The "operation" struct is named poorly as well; even if we stick with
>> "operation" elsewhere we really need to name this one better, it's way too
>> generic.
>
> Don't want to bikeshed here, but I think "operation" is more readable
> then "extop" (not evident what that means or even whether it is supposed
> to be read as "ex-top" or "ext-op" or what).  "operation" at least is
> meaningful and is a suitable generalization of "ioctl command".

I agree we're (okay, me) being a bit nitpicky here regarding names,
but I really don't like "operation".  I'd much prefer if we could find
something else that implies an extension to the existing 32
permissions, maybe "extperm" or similar?

As I said earlier, I'm open to suggestions so long as they aren't "operation" :)

-- 
paul moore
www.paul-moore.com
