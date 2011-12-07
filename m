Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB7KFghK018807
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2011 15:15:42 -0500
Received: from mail-vx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB7KFfAH012554
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2011 20:15:41 GMT
Received: by vcbfl17 with SMTP id fl17so935487vcb.12
        for <selinux@tycho.nsa.gov>; Wed, 07 Dec 2011 12:15:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACLa4ptSZ9u6NSe=uiARYZZNA3a1cJAnAyGEy2EGms47_7ak8A@mail.gmail.com>
References: <1322929819.82046.YahooMailClassic@web87016.mail.ird.yahoo.com>
	<4EDF6AEC.1070606@tresys.com>
	<CACLa4ptqS=hBZUYDp8bjwnLZeuU8yfprDFi5_dxRRDipT3Xtkg@mail.gmail.com>
	<4EDF7258.2070800@tresys.com>
	<CACLa4ptSZ9u6NSe=uiARYZZNA3a1cJAnAyGEy2EGms47_7ak8A@mail.gmail.com>
Date: Wed, 7 Dec 2011 15:15:40 -0500
Message-ID: <CACLa4pumnzC-HXMhm2YKEEx3WJBtSYQpejkEJ-tM8Czm1inqaQ@mail.gmail.com>
Subject: Re: CIL/SELinux Userspace Integration
From: Eric Paris <eparis@parisplace.org>
To: Steve Lawrence <slawrence@tresys.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So the problem comes from the code which creates the files in
/selinux/booleans.  It does an explicit check for a genfs rule for
selinuxfs to label the new inode.  I'm not certain why we need this
bit of code.  Maybe it is there to support labeling of individual
booleans somehow, but I don't see how of why this particular piece of
code is needed.  In any case I believe (Steve tested but I'm not
exactly sure what he did) that you can add a genfs statement for
selinuxfs and it will start working...

On Wed, Dec 7, 2011 at 1:45 PM, Eric Paris <eparis@parisplace.org> wrote:
> I've found and fixed one kernel bug using this policy, but not THE
> kernel bug.  Weeeee
>
> On Wed, Dec 7, 2011 at 9:04 AM, Steve Lawrence <slawrence@tresys.com> wrote:
>> On 12/07/2011 08:54 AM, Eric Paris wrote:
>>>
>>> On Wed, Dec 7, 2011 at 8:32 AM, Steve Lawrence<slawrence@tresys.com>
>>>  wrote:
>>>>
>>>> On 12/03/2011 11:30 AM, Richard Haines wrote:
>>>
>>>
>>>>> 5) I could not load a new policy that had a boolean and supporting
>>>>>    statements in it. The actual binary policy was fine (using apol), but
>>>>>    load_policy had problems. I started with a Fedora 16 base and added
>>>>>    the new Integration code with no problems. Is it a known problem as
>>>>>    if not I'll check further.
>>>>>    The errors I had when running semodule with a boolean were (Note: I
>>>>>    had already built a new base policy (SELINUXTYPE=rch-test1) with no
>>>>>    problems):
>>>>
>>>>
>>>>
>>>> Hmmm, this is interesting. Both seinfo and apol are fine with my
>>>> CIL-generated binary, but fails to load when I add booleans. I also
>>>> generated a similar mdp policy.conf, ran checkpolicy, and that failed to
>>>> load as well. sediff also shows the two binaries to be the same.
>>>>
>>>> I'll look into this more, but because of that, I'm thinking this is a
>>>> kernel
>>>> bug. If anyone else wants to look at it, I've attached a simple file that
>>>> is
>>>> the standard mdp.conf with a single boolean defined, and single
>>>> conditional
>>>> statement using that boolean. This builds a binary fine, and apol/seinfo
>>>> have no problem with it, but fails to load with load_policy.
>>>>
>>>>>
>>>>>                       ------ Start --------------
>>>>> # semodule -i base.cil ext_gateway.cil int_gateway.cil move_file.cil
>>>>>
>>>>> SELinux:  Could not load policy file
>>>>> /etc/selinux/rch-test1/policy/policy.26:  No such file or directory
>>>>> /sbin/load_policy:  Can't load policy:  No such file or directory
>>>>>
>>>>> libsemanage.semanage_reload_policy: load_policy returned error code 2.
>>>>> (No
>>>>> such file or directory).
>>>>> SELinux:  Could not load policy file
>>>>> /etc/selinux/rch-test1/policy/policy.26:  No such file or directory
>>>>> /sbin/load_policy:  Can't load policy:  No such file or directory
>>>>>
>>>>> libsemanage.semanage_reload_policy: load_policy returned error code 2.
>>>>> (No
>>>>> such file or directory).
>>>>> semodule:  Failed!
>>>>>
>>>>>                     ----- End -----------------
>>>
>>>
>>> If you send me the policy.X in question I'll spend a couple minutes
>>> figuring out what the kernel is upset about...
>>
>>
>> policy.24 attached. Thanks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
