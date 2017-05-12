Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4CMMakW032544
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 18:22:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id h4so1116449lfj.3
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 15:22:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5d7a2409-db08-b142-c71b-a7a38ecc175d@schaufler-ca.com>
References: <1494507551-4643-1-git-send-email-sbuisson@ddn.com>
 <2161c45f-dd29-8269-2bb1-5d5afa78104b@schaufler-ca.com>
 <1494534152.10447.11.camel@tycho.nsa.gov>
 <5d7a2409-db08-b142-c71b-a7a38ecc175d@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 May 2017 18:22:32 -0400
Message-ID: <CAHC9VhSuB2MNS_LQBGQjJHAY0LKx3A9hh7Cq4a_RbD_uqNbeuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: add brief info to policydb
To: Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, Sebastien Buisson <sbuisson@ddn.com>,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 11, 2017 at 4:45 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/11/2017 1:22 PM, Stephen Smalley wrote:
>> On Thu, 2017-05-11 at 08:56 -0700, Casey Schaufler wrote:
>>> On 5/11/2017 5:59 AM, Sebastien Buisson wrote:
>>>> Add policybrief field to struct policydb. It holds a brief info
>>>> of the policydb, in the following form:
>>>> <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
>>>> Policy brief is computed every time the policy is loaded, and when
>>>> enforce or checkreqprot are changed.
>>>>
>>>> Add security_policy_brief hook to give access to policy brief to
>>>> the rest of the kernel. Lustre client makes use of this information
>>>> to detect changes to the policy, and forward it to Lustre servers.
>>>> Depending on how the policy is enforced on Lustre client side,
>>>> Lustre servers can refuse connection.
>>>>
>>>> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
>>>> ---
>>>>  include/linux/lsm_hooks.h           | 16 ++++++++
>>>>  include/linux/security.h            |  7 ++++
>>>>  security/security.c                 |  6 +++
>>>>  security/selinux/hooks.c            |  7 ++++
>>>>  security/selinux/include/security.h |  2 +
>>>>  security/selinux/selinuxfs.c        |  2 +
>>>>  security/selinux/ss/policydb.c      | 76
>>>> +++++++++++++++++++++++++++++++++++++
>>>>  security/selinux/ss/policydb.h      |  2 +
>>>>  security/selinux/ss/services.c      | 62
>>>> ++++++++++++++++++++++++++++++
>>>>  9 files changed, 180 insertions(+)
>>>>
>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>> index 080f34e..9cac282 100644
>>>> --- a/include/linux/lsm_hooks.h
>>>> +++ b/include/linux/lsm_hooks.h
>>>> @@ -1336,6 +1336,20 @@
>>>>   * @inode we wish to get the security context of.
>>>>   * @ctx is a pointer in which to place the allocated
>>>> security context.
>>>>   * @ctxlen points to the place to put the length of @ctx.
>>>> + *
>>>> + * Security hooks for policy brief
>>>> + *
>>>> + * @policy_brief:
>>>> + *
>>>> + * Returns a string containing a brief info of the
>>>> policydb, in the
>>>> + * following form:
>>>> + * <0 or 1 for enforce>:<0 or 1 for
>>>> checkreqprot>:<hashalg>=<checksum>
>>>
>>> This sure looks like SELinux specific information. If the Spiffy
>>> security module has multiple values for enforcement (e.g. off,
>>> soft and hard) this interface definition does not work. What is a
>>> "checkreqprot", and what is it for?
>>>
>>> I expect that you have no interest (or incentive) in supporting
>>> security modules other than SELinux, and that's OK. What's I'm
>>> after is an interface that another security module could use if
>>> someone where interested (or inspired) to do so.
>>>
>>> Rather than a string with predefined positional values (something
>>> I was taught not to do when 1 MIPS and 1 MEG was a big computer)
>>> you might use
>>> "enforce=<value>:checkreqprot=<value>:hashalg=<checksum>"
>>
>> No objection to the above, although it makes his updating code for
>> enforce/checkreqprot a bit uglier.
>
> Sure, but can you imagine trying to use find(1) if the
> options where positional?

Perhaps I'm suffering from audit induced PTSD, but I think we need to
operate under the assumption that we are going to need to augment this
at some point in the future (no good feature goes un-abused) and I'd
much rather have some sort of name-value pairing to keep my sanity.  I
also feel rather strongly that we should make it very explicit in the
comments that the ordering of the fields in the string may change.

>>> for SELinux and define @policy_brief as
>>>
>>>      A string containing colon separated name and value pairs
>>>      that will be parsed and interpreted by the security module
>>>      or modules.
>>
>> Actually, I'm not clear it will be parsed or interpreted by the
>> security module(s).  I think he is just fetching it and then doing a
>> simple comparison to check for inconsistencies between clients and the
>> server, and optionally admins/users can read it and interpret it as
>> they see fit.
>
> OK, in which case human eyes *need* the name as well as the value.
> That, and strcmp(value, "enforce=0") is no harder than strcmp(value, "0").

The initial use case may not require parsing the string, but who knows
what will end up using this five years from now.  Once again, I agree
with Casey, let's make sure it easily parsed and readable by admins;
imagine this as the output of a file under /proc or /sys.

>>> You already have it right for the "hashalg" field. If you want to
>>> be really forward looking you could use names field names that
>>> identify the security module that uses them, such as
>>>
>>>      "selinux/enforce=1:selinux/checkreqprot=0:selinux/MD5=8675309"
>> That seems a bit verbose, particularly the duplicated selinux/ bit.
>
> True that, on the other hand
>
>         "selinux(enforce=1:checkreqprot=0:MD5=8675309)"
>
> would be harder to parse. Either works for me.

I'm not sure I care too much about how the name-value pairs get
namespaced, but considering the LSM stacking work that is happening,
we should namespace it somehow.

-- 
paul moore
www.paul-moore.com
