Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44JMS2B003648
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 15:22:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B78F2D9FC0
 for <selinux@tycho.nsa.gov>; Thu,  4 May 2017 19:22:24 +0000 (UTC)
Received: from hulk.lan (ovpn-204-31.brq.redhat.com [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B3C62926
 for <selinux@tycho.nsa.gov>; Thu,  4 May 2017 19:22:23 +0000 (UTC)
Subject: Re: Policy capabilities: when to use and complications with using
To: selinux@tycho.nsa.gov
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
 <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
 <20170504174240.GD29905@julius> <20170504175031.GE29905@julius>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <a6d7dd71-9951-93e8-d9b5-22f4775badb2@redhat.com>
Date: Thu, 4 May 2017 21:22:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170504175031.GE29905@julius>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2017 07:50 PM, Dominick Grift wrote:
> On Thu, May 04, 2017 at 07:42:40PM +0200, Dominick Grift wrote:
>> On Thu, May 04, 2017 at 11:50:15AM -0400, Paul Moore wrote:
>>> On Wed, May 3, 2017 at 12:51 PM, Dominick Grift <dac.override@gmail.com> wrote:
>>>> On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
>>>>> Part of the reason that we tend to not introduce a new policy
>>>>> capability more often is that it is painful to do so currently.  We
>>>>> have to patch libsepol to recognize the new capability and patch the
>>>>> policy to declare it (although for the latter we can now declare them
>>>>> via a CIL module without modifying the base policy).  And since the
>>>>> policy or module won't build without the updated libsepol, we can't
>>>>> turn on the capability by default in refpolicy without making it
>>>>> dependent on a new libsepol version.  That's why extended_socket_class
>>>>> isn't yet enabled in refpolicy, for example.  That causes enablement
>>>>> and adoption to lag behind.  It also makes it harder to test the new
>>>>> kernel feature in the first place.
>>>>
>>>> I would like to see Fedora package the RC's in Rawhide as well (other distributions could help by packaging the RC's in unstable as well). That would atleast make the RC's a bit more accessible.
>>>> In Fedora it is usually not the kernel that is the problem, it is user space that is generally to old. And as you've said policy is no longer a problem with CIL.
>>>
>>> [NOTE: I'm still thinking about the rest of Stephen's email, and the
>>> follow up comments, but I wanted to reply to this particular comment
>>> separately.]
>>>
>>> I'm not sure I want to see SELinux userspace release candidates in
>>> normal Rawhide, but I think creating a COPR repository to
>>> build/distribute release candidates could be a good thing.  We already
>>> do something similar for the kernel patches and it has been helpful in
>>> my opinion.
>>
>> Thanks, Yes i suppose you are right. Release Candidates would probably potentially cause too much disruption even in Rawhide.
>> COPR should do the job, although will not be as accessible as Rawhide. It won't get the same kind of attention, but it will do for me.
> 
> With COPR though we might be able to package more frequent and not just RC's (weekly's/nightly's)? If that can somehow be automated  then we also do not have to worrie so much about keeping things maintained over time


I'm just building new set of updates in my COPR plautrba/selinux
repository [1]. It's based on latest upstream sources with some Fedora
patches on the top of it currently tracked in my github tree [2]. But
there are some problems and it's not ready yet.

I used to build vanilla upstream sources [3] but the latest build is 15
months old. I can restart this project if there's an interest.

Since COPR provides API with an authentication token, builds can
automated and I have few scripts I used before.

I think it could even work for Rawhide with less frequent update cycle.

[1] https://copr.fedorainfracloud.org/coprs/plautrba/selinux/
[2] https://github.com/bachradsusi/selinux/tree/WIP-master
[3] https://copr.fedorainfracloud.org/coprs/plautrba/selinux-master/builds/

Petr
