Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w11FtruB010036
 for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2018 10:55:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zXPps32gbz63cX
 for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2018 15:55:49 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zXPps2DNFz63cW
 for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2018 15:55:49 +0000 (UTC)
Received: by mail-lf0-f54.google.com with SMTP id k19so26996538lfj.1
 for <selinux@tycho.nsa.gov>; Thu, 01 Feb 2018 07:55:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4c41ad02-5370-95bc-51e4-992767768559@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
 <20180126143241.23108-2-peter.enderborg@sony.com>
 <1517320017.14420.7.camel@tycho.nsa.gov>
 <4c41ad02-5370-95bc-51e4-992767768559@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Feb 2018 10:55:46 -0500
Message-ID: <CAHC9VhRas0SbsPEsLLy_cVBRm356y5sbPxdawcK1uLCM2h1YtA@mail.gmail.com>
To: peter enderborg <peter.enderborg@sony.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 1/5] selinux:Remove direct references to
 policydb.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 1, 2018 at 10:17 AM, peter enderborg
<peter.enderborg@sony.com> wrote:
> On 01/30/2018 02:46 PM, Stephen Smalley wrote:
>> On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>>
>>> To be able to use rcu locks we seed to address the policydb
>>> though a pointer. This preparation removes the export of the
>>> policydb and send pointers to it through parameter agruments.
>> Just for reference, I have a patch series that does this not only for
>> the policydb, sidtab, and class/perm mapping, but for all of the
>> SELinux global state, see:
>> https://github.com/stephensmalley/selinux-kernel/tree/selinuxns
>> and in particular
>> https://github.com/stephensmalley/selinux-kernel/commit/c10d90b43cd720c8f8aab51007e805bf7c4f10d2
>> https://github.com/stephensmalley/selinux-kernel/commit/ec038a64173d56a331423b6d1564b801f0915afc
>> https://github.com/stephensmalley/selinux-kernel/commit/97aa5d7a05e4458bc4562c47d8f7bc4f56fbfefd
>>
>> Those first three patches should have no effect on SELinux behavior.
>> They need to be re-based to latest selinux next branch (some minor
>> conflict resolution required) but I was waiting for that to advance to
>> something 4.15-rcX based.  I could however re-base it now if desired.
>
> I read that as that you want me to rebase the patches on that tree? Seems to
> be partly prepared but lot of changes.  Is it a moving target?

Stephen is being nice and not throwing me under the bus, but I'm most
likely the problem here.

Last summer/fall Stephen and I had a discussion about SELinux
namespacing and we talked about some of the preparatory work that
needed to be done before the namespacing work could be started.  The
namespacing work is obviously off topic for the work you are doing,
but a big part of the necessary cleanup work was the consolidation and
encapsulation of the various SELinux global state variables.  At the
time I encouraged Stephen to post this work as I felt it would be
useful independent of the namespacing work, and I think we are seeing
one reason why with the work you are doing.

I owe Stephen some review/feedback on his namespace patchset, at the
very least the global state work that he referenced with you.  I'm
just getting back from some traveling over the past week or so, let me
review the first few patches in Stephen's patchset with the idea of
getting those merged and then you can use those as a base for your
work.  From what I can see, I imagine that having Stephen's work as a
base would be helpful for you.  I'll make a promise to get Stephen
feedback by the end of next week at the latest; I'll aim for sooner.

Does that help?

-- 
paul moore
www.paul-moore.com
