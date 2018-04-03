Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w33Bw0U0017693
 for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2018 07:58:00 -0400
Received: by mail-lf0-f43.google.com with SMTP id e5-v6so19756205lfb.7
 for <selinux@tycho.nsa.gov>; Tue, 03 Apr 2018 04:57:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b5ff9dc2-d9b8-4419-726f-8f950d423a7c@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
 <20180126143241.23108-2-peter.enderborg@sony.com>
 <1517320017.14420.7.camel@tycho.nsa.gov>
 <4c41ad02-5370-95bc-51e4-992767768559@sony.com>
 <CAHC9VhRas0SbsPEsLLy_cVBRm356y5sbPxdawcK1uLCM2h1YtA@mail.gmail.com>
 <b5ff9dc2-d9b8-4419-726f-8f950d423a7c@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Apr 2018 07:56:53 -0400
Message-ID: <CAHC9VhSC6AKv5djyA8xDEtZo-89DHf6bDLV6eiWUuTxqju=Gug@mail.gmail.com>
To: peter enderborg <peter.enderborg@sony.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 1/5] selinux:Remove direct references to
 policydb.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 3, 2018 at 7:41 AM, peter enderborg
<peter.enderborg@sony.com> wrote:
> On 02/01/2018 04:55 PM, Paul Moore wrote:
>> On Thu, Feb 1, 2018 at 10:17 AM, peter enderborg
>> <peter.enderborg@sony.com> wrote:
>>> On 01/30/2018 02:46 PM, Stephen Smalley wrote:
>>>> On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
>>>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>>>>
>>>>> To be able to use rcu locks we seed to address the policydb
>>>>> though a pointer. This preparation removes the export of the
>>>>> policydb and send pointers to it through parameter agruments.
>>>> Just for reference, I have a patch series that does this not only for
>>>> the policydb, sidtab, and class/perm mapping, but for all of the
>>>> SELinux global state, see:
>>>> https://github.com/stephensmalley/selinux-kernel/tree/selinuxns
>>>> and in particular
>>>> https://github.com/stephensmalley/selinux-kernel/commit/c10d90b43cd720c8f8aab51007e805bf7c4f10d2
>>>> https://github.com/stephensmalley/selinux-kernel/commit/ec038a64173d56a331423b6d1564b801f0915afc
>>>> https://github.com/stephensmalley/selinux-kernel/commit/97aa5d7a05e4458bc4562c47d8f7bc4f56fbfefd
>>>>
>>>> Those first three patches should have no effect on SELinux behavior.
>>>> They need to be re-based to latest selinux next branch (some minor
>>>> conflict resolution required) but I was waiting for that to advance to
>>>> something 4.15-rcX based.  I could however re-base it now if desired.
>>> I read that as that you want me to rebase the patches on that tree? Seems to
>>> be partly prepared but lot of changes.  Is it a moving target?
>> Stephen is being nice and not throwing me under the bus, but I'm most
>> likely the problem here.
>>
>> Last summer/fall Stephen and I had a discussion about SELinux
>> namespacing and we talked about some of the preparatory work that
>> needed to be done before the namespacing work could be started.  The
>> namespacing work is obviously off topic for the work you are doing,
>> but a big part of the necessary cleanup work was the consolidation and
>> encapsulation of the various SELinux global state variables.  At the
>> time I encouraged Stephen to post this work as I felt it would be
>> useful independent of the namespacing work, and I think we are seeing
>> one reason why with the work you are doing.
>>
>> I owe Stephen some review/feedback on his namespace patchset, at the
>> very least the global state work that he referenced with you.  I'm
>> just getting back from some traveling over the past week or so, let me
>> review the first few patches in Stephen's patchset with the idea of
>> getting those merged and then you can use those as a base for your
>> work.  From what I can see, I imagine that having Stephen's work as a
>> base would be helpful for you.  I'll make a promise to get Stephen
>> feedback by the end of next week at the latest; I'll aim for sooner.
>>
>> Does that help?
>>
> Hi. Need follow up on this. I dont see any progress on this lately.  Is there any
> conclusions about namespace thing in kernel code yet?

The namespace work is still a work in progress, and to some degree an
open question as a result, but the work I believe you are interested
in, the consolidation/encapsulation patches, have been merged into the
selinux/next branch (you should have seen mail about that on-list) and
will be going up to Linus during this merge window.  I expect that to
happen within the next few days.

>From my perspective I'm expecting that you would be rebasing your work
on top of these patches, is that what you are planning?

-- 
paul moore
www.paul-moore.com
