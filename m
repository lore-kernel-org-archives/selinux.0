Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49I374e009867
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 14:03:08 -0400
Received: by mail-lf0-f51.google.com with SMTP id j1so6814446lfh.2
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 11:03:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a6d7dd71-9951-93e8-d9b5-22f4775badb2@redhat.com>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
 <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
 <20170504174240.GD29905@julius> <20170504175031.GE29905@julius>
 <a6d7dd71-9951-93e8-d9b5-22f4775badb2@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 May 2017 14:03:01 -0400
Message-ID: <CAHC9VhQM+V+yybXZ_YkEEMOZL0W5pSXDfCJrZPt99Nm74FVyZw@mail.gmail.com>
Subject: Re: Policy capabilities: when to use and complications with using
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 4, 2017 at 3:22 PM, Petr Lautrbach <plautrba@redhat.com> wrote:
> On 05/04/2017 07:50 PM, Dominick Grift wrote:
>> On Thu, May 04, 2017 at 07:42:40PM +0200, Dominick Grift wrote:
>>> On Thu, May 04, 2017 at 11:50:15AM -0400, Paul Moore wrote:
>>>> On Wed, May 3, 2017 at 12:51 PM, Dominick Grift <dac.override@gmail.com> wrote:
>>>>> On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
>>>>>> Part of the reason that we tend to not introduce a new policy
>>>>>> capability more often is that it is painful to do so currently.  We
>>>>>> have to patch libsepol to recognize the new capability and patch the
>>>>>> policy to declare it (although for the latter we can now declare them
>>>>>> via a CIL module without modifying the base policy).  And since the
>>>>>> policy or module won't build without the updated libsepol, we can't
>>>>>> turn on the capability by default in refpolicy without making it
>>>>>> dependent on a new libsepol version.  That's why extended_socket_class
>>>>>> isn't yet enabled in refpolicy, for example.  That causes enablement
>>>>>> and adoption to lag behind.  It also makes it harder to test the new
>>>>>> kernel feature in the first place.
>>>>>
>>>>> I would like to see Fedora package the RC's in Rawhide as well (other distributions could help by packaging the RC's in unstable as well). That would atleast make the RC's a bit more accessible.
>>>>> In Fedora it is usually not the kernel that is the problem, it is user space that is generally to old. And as you've said policy is no longer a problem with CIL.
>>>>
>>>> [NOTE: I'm still thinking about the rest of Stephen's email, and the
>>>> follow up comments, but I wanted to reply to this particular comment
>>>> separately.]
>>>>
>>>> I'm not sure I want to see SELinux userspace release candidates in
>>>> normal Rawhide, but I think creating a COPR repository to
>>>> build/distribute release candidates could be a good thing.  We already
>>>> do something similar for the kernel patches and it has been helpful in
>>>> my opinion.
>>>
>>> Thanks, Yes i suppose you are right. Release Candidates would probably potentially cause too much disruption even in Rawhide.
>>> COPR should do the job, although will not be as accessible as Rawhide. It won't get the same kind of attention, but it will do for me.
>>
>> With COPR though we might be able to package more frequent and not just RC's (weekly's/nightly's)? If that can somehow be automated  then we also do not have to worrie so much about keeping things maintained over time
>
> I'm just building new set of updates in my COPR plautrba/selinux
> repository [1]. It's based on latest upstream sources with some Fedora
> patches on the top of it currently tracked in my github tree [2]. But
> there are some problems and it's not ready yet.
>
> I used to build vanilla upstream sources [3] but the latest build is 15
> months old. I can restart this project if there's an interest.
>
> Since COPR provides API with an authentication token, builds can
> automated and I have few scripts I used before.
>
> I think it could even work for Rawhide with less frequent update cycle.

I used to use your upstream COPR builds on my primary test system, but
I dropped that repo when I had to rebuild that system a few months ago
and I realized the COPR repo had grown stale.

If you've got the time, I think it might be helpful to create a COPR
with the upstream userspace and the Fedora/Rawhide patches layered on
top; it would help get more testing/exposure and should help amortize
the work in keeping the Fedora/Rawhide patches current.  If it helps
any I keep my COPR patching/building scripts at the link below.  The
pcopr_srpm-kernel script is package specific but should be easy to
adopt to new packages; the pcopr_patch script should be generic enough
to work on any package.

* https://github.com/pcmoore/copr-pkg_scripts

-- 
paul moore
www.paul-moore.com
