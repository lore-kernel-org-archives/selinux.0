Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEBXGb012459
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:11:33 -0400
Received: by oiww2 with SMTP id w2so11916063oiw.0
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:11:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555DD091.8060307@tycho.nsa.gov>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl> <555DD091.8060307@tycho.nsa.gov>
Date: Thu, 21 May 2015 10:11:31 -0400
Message-ID: <CAHC9VhSvE-ajq16kaFufaeFnYGkdT=Fyb+nR_zKPjhjRuqSktw@mail.gmail.com>
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
>>> @@ -429,11 +456,15 @@ int avtab_read_item(struct avtab *a, void *fp, struct
>>> policydb *pol, printk(KERN_ERR "SELinux: avtab: entry has both access
>>> vectors and types\n"); return -EINVAL;
>>>              }
>>> +            if (val & AVTAB_OP) {
>>> +                    printk(KERN_ERR "SELinux: avtab: entry has operations\n");
>>> +                    return -EINVAL;
>>> +            }
>>
>> Another "operations" vs. "extop" or similar.  If we generalize, it would also
>> be nice to know what kind of extended operations, e.g. ioctl commands.
>>
>> Further, beyond the extension type (ioctl), I think it would be nice to
>> include a size value in the binary policy.  With the current ioctl code it
>> would be 8/256, but we might want to make this variable in the future and it
>> would be nice not to have to bump the policy format again.
>
> Not sure we can avoid changing the format version again regardless.
> Note that we didn't even strictly need to increment the version this
> time, as the new structure is only included in the binary policy if one
> of the newly defined AVTAB_OP flag bits is set for the entry, but it was
> still useful to define a new version so that userspace can tell whether
> the kernel supports the extension and decide how to handle it if the
> policy defined these operations but the kernel doesn't support enforcing
> them. The same would be true of any future extension that used this
> facility.

You are probably right, but I think it might be a good idea just the same.

-- 
paul moore
www.paul-moore.com
