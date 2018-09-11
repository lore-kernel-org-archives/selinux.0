To: Joshua Brindle <joshua.brindle@crunchydata.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <CAGB+Vh5H1bu5vuPgfrj+YgbGGWegjnc4iskpuuHW6xgdWP5c5Q@mail.gmail.com>
 <bb05c207-2c43-5af2-6ca0-c2b04cac0521@tycho.nsa.gov>
 <CAGB+Vh5MF+p4wLNONp5Vozv_d85BJ=nK8vqiHj1Aq=Y_2WkPrg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0b940225-c244-ff2c-6c28-de5333cc6636@tycho.nsa.gov>
Date: Tue, 11 Sep 2018 14:21:09 -0400
MIME-Version: 1.0
In-Reply-To: <CAGB+Vh5MF+p4wLNONp5Vozv_d85BJ=nK8vqiHj1Aq=Y_2WkPrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/11/2018 01:39 PM, Joshua Brindle wrote:
> On Tue, Sep 11, 2018 at 1:33 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/11/2018 12:53 PM, Joshua Brindle wrote:
>>>
>>> On Tue, Sep 11, 2018 at 10:41 AM, Stephen Smalley <sds@tycho.nsa.gov>
>>> wrote:
>>>>
>>>> On 09/10/2018 06:30 PM, Ted Toth wrote:
>>>>>
>>>>>
>>>>> mcstrans mcscolor.c also uses the same logic I'd been using to check
>>>>> dominance so this too will no longer function as expected on el7. Do you
>>>>> any
>>>>> suggestions for doing a 'generic' (one not tied to a specific resource
>>>>> class) dominance check in lieu of context contains?
>>>>
>>>>
>>>>
>>>> You should probably define your own permission with its own constraint to
>>>> avoid depending on the base policy's particular constraint definitions.
>>>> Certainly for your own code.  For mcstrans, mcscolor probably ought to be
>>>> switched to using at least a separate permission in the context class if
>>>> not
>>>> its own class to avoid overloading the meaning with pam_selinux's usage
>>>> (or
>>>> vice versa, but likely harder to change pam_selinux at this point).
>>>>
>>>
>>> Isn't the actual question what the GLB of the 2 contexts is, rather
>>> than what permissions one has on the other? It seems like a hack to
>>> use permissions to figure out dominance.
>>>
>>> Would a libselinux interface to determine glb and lub of 2 contexts
>>> make sense? Or maybe add a default_range glb and lub option and then
>>> calculate it using relabel?
>>
>>
>> At least as used in mcstrans, it appears to be a way of matching which entry
>> from the colors configuration to use.  So it is just a "Can context C1 use
>> the colors specified for context C2?" question.  It just happens that the
>> way they are deciding that for the MLS part is through the dominance
>> relation.  And determining whether context C1 dominates context C2 is
>> something only the kernel security server or libsepol with the same policy
>> file loaded into it can answer, not libselinux or anything else.
>>
> 
> I meant an libselinux as in a library interface to some file in
> selinuxfs to calculate the glb.
> 
> If it is 'permission to see a color' that makes sense, I was thinking
> the source context and target context have a glb that maps to the
> color to be shown.

That doesn't seem to match the existing mcstrans logic or colors 
configuration file.  So, sure he could rewrite mcstrans and its 
configuration format, add a new libselinux interface, add a new kernel 
interface, and implement a new kernel security server function, but he 
just wanted to make something that was already working on rhel6 to work 
on rhel7, and which only broke because a constraint changed out 
underneath to address a concern with pam_selinux/login.  Easiest 
approach is to define a new class/perm and define the old constraint for 
it.  Requires adding a CIL module for the policy piece and then a couple 
of lines changed in mcstrans and his own code and he is done.
