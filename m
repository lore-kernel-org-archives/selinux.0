Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB7I2Vam016577
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2011 13:02:31 -0500
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB7I2Ucl023239
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2011 18:02:30 GMT
Message-ID: <4EDFAA35.3060309@tresys.com>
Date: Wed, 7 Dec 2011 13:02:29 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: CIL/SELinux Userspace Integration
References: <1323277315.14808.YahooMailClassic@web87008.mail.ird.yahoo.com>
In-Reply-To: <1323277315.14808.YahooMailClassic@web87008.mail.ird.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/07/2011 12:01 PM, Richard Haines wrote:
> Thanks for the updates The deny_unknown, permissionset and generating policy.conf all worked okay.
>
> I've had a couple of other minor problems:
>
> 1) I added a 'policycap' statement in a block. secilc processed the CIL statements but failed to gen the policy. I then moved it to the global namespace and then worked okay. I assume that policycap must always be in the global namespace.
>

There isn't anything in theory that requires the policycap statement to 
be global. However, putting a policycap in a block will namespace it, so 
this:

   (block foo
       (policycap bar))

results in the policy capability "foo.bar". Right now, the only valid 
policy capabilities are "network_peer_controls" and "open_perms". So 
"foo.bar" as well as any namespaced policy cap will never work in 
practice. However, there is a bug that this error isn't check at the 
right spot. I've fixed this, so you should at least get a better error 
message now.

> 2) Are there any known issues regarding typetransition rules as I'm having problems generating a policy. For example secilc will throw 'Error: Duplicate rule defined (line: xxx)'. I then comment out the typetransition statement (that actually looks okay) and it fails with another one, however semodule -i .. will compile it okay. In the end I can get both secilc and semodule to build the binary policy once I remove enough typetransition statements to keep both of them happy. (both seem to be happy with about 16 typetransition statements in policy but semodule can take a few more !!!)
>

No known issues with typetransitions. Can you send the policy you're 
having trouble with and I'll take a look?

> The policy consists of 10 CIL modules (files) with about 1,200 lines of CIL statements - but nothing complex just the SELinux Notebook moules I'm converting to CIL as an exercise.
>
> I've had both problems on the original integration you sent plus the updates you pushed today (7th Dec).
>
> Richard
>
> --- On Wed, 7/12/11, Steve Lawrence<slawrence@tresys.com>  wrote:
>
>> From: Steve Lawrence<slawrence@tresys.com>
>> Subject: Re: CIL/SELinux Userspace Integration
>> To: "Richard Haines"<richard_c_haines@btinternet.com>
>> Cc: selinux@tycho.nsa.gov
>> Date: Wednesday, 7 December, 2011, 13:32
>> On 12/03/2011 11:30 AM, Richard
>> Haines wrote:
>>> Steve,
>>>
>>> Thanks for this, it seems to work fine with the policy
>> samples I've been
>>> using. I've had a couple of minor problems though:
>>>
>>> 1) A macro does not work with permissionset as one of
>> the parameters (all
>>>       the other parameters worked
>> okay).
>>>
>>
>> Thanks for finding this. Just pushed a commit that fixes
>> this.
>>
>>> 2) Macro comments are not permitted. I notice they are
>> not present in the
>>>       test files so has it been
>> dropped.
>>>
>>
>> Yep. Macro comments have been dropped. I've updated it on
>> the wiki.
>>
>>> 3) I could not find a way to generate the policy.conf
>> file. I set the
>>>       DEBUG=1 in the CIL Makefile
>> like I used to but no file.
>>>
>>
>> In selinux userspace, make DEBUG=1 doesn't define the DEBUG
>> macro that
>> the CIL code uses to enable debugging. You'll have to add
>> '-DDEBUG' to
>> the CFLAGS in the userspace Makefile to enable building of
>> the
>> policy.conf file.
>>
>>> 4) To set deny_unknown in secilc.c required a 'U' in
>> the getopt line:
>>>
>>     getopt_long(argc, argv, "hvtU:MDc:",
>> .....
>>>
>>
>> Thanks, fixed and pushed.
>>
>>> 5) I could not load a new policy that had a boolean
>> and supporting
>>>       statements in it. The actual
>> binary policy was fine (using apol), but
>>>       load_policy had problems. I
>> started with a Fedora 16 base and added
>>>       the new Integration code with
>> no problems. Is it a known problem as
>>>       if not I'll check further.
>>>       The errors I had when running
>> semodule with a boolean were (Note: I
>>>       had already built a new base
>> policy (SELINUXTYPE=rch-test1) with no
>>>       problems):
>>
>> Hmmm, this is interesting. Both seinfo and apol are fine
>> with my
>> CIL-generated binary, but fails to load when I add
>> booleans. I also
>> generated a similar mdp policy.conf, ran checkpolicy, and
>> that failed to
>> load as well. sediff also shows the two binaries to be the
>> same.
>>
>> I'll look into this more, but because of that, I'm thinking
>> this is a
>> kernel bug. If anyone else wants to look at it, I've
>> attached a simple
>> file that is the standard mdp.conf with a single boolean
>> defined, and
>> single conditional statement using that boolean. This
>> builds a binary
>> fine, and apol/seinfo have no problem with it, but fails to
>> load with
>> load_policy.
>>
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
