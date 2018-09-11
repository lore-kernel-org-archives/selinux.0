To: Joshua Brindle <joshua.brindle@crunchydata.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <CAGB+Vh5H1bu5vuPgfrj+YgbGGWegjnc4iskpuuHW6xgdWP5c5Q@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bb05c207-2c43-5af2-6ca0-c2b04cac0521@tycho.nsa.gov>
Date: Tue, 11 Sep 2018 13:33:10 -0400
MIME-Version: 1.0
In-Reply-To: <CAGB+Vh5H1bu5vuPgfrj+YgbGGWegjnc4iskpuuHW6xgdWP5c5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/11/2018 12:53 PM, Joshua Brindle wrote:
> On Tue, Sep 11, 2018 at 10:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/10/2018 06:30 PM, Ted Toth wrote:
>>>
>>> mcstrans mcscolor.c also uses the same logic I'd been using to check
>>> dominance so this too will no longer function as expected on el7. Do you any
>>> suggestions for doing a 'generic' (one not tied to a specific resource
>>> class) dominance check in lieu of context contains?
>>
>>
>> You should probably define your own permission with its own constraint to
>> avoid depending on the base policy's particular constraint definitions.
>> Certainly for your own code.  For mcstrans, mcscolor probably ought to be
>> switched to using at least a separate permission in the context class if not
>> its own class to avoid overloading the meaning with pam_selinux's usage (or
>> vice versa, but likely harder to change pam_selinux at this point).
>>
> 
> Isn't the actual question what the GLB of the 2 contexts is, rather
> than what permissions one has on the other? It seems like a hack to
> use permissions to figure out dominance.
> 
> Would a libselinux interface to determine glb and lub of 2 contexts
> make sense? Or maybe add a default_range glb and lub option and then
> calculate it using relabel?

At least as used in mcstrans, it appears to be a way of matching which 
entry from the colors configuration to use.  So it is just a "Can 
context C1 use the colors specified for context C2?" question.  It just 
happens that the way they are deciding that for the MLS part is through 
the dominance relation.  And determining whether context C1 dominates 
context C2 is something only the kernel security server or libsepol with 
the same policy file loaded into it can answer, not libselinux or 
anything else.
