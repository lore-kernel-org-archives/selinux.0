Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s38FvY09006377
 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2014 11:57:34 -0400
Message-ID: <53441C65.8070803@redhat.com>
Date: Tue, 08 Apr 2014 11:57:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Richard Haines <richard_c_haines@btinternet.com>,
 selinux@tycho.nsa.gov, setools-bugs@tresys.com
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy
 features
References: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
 <53441804.9060408@tresys.com>
In-Reply-To: <53441804.9060408@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We have a hole series of patches for setools also, that have never made
it upstream.


On 04/08/2014 11:38 AM, Christopher J. PeBenito wrote:
> On 04/08/2014 10:52 AM, Richard Haines wrote:
>> These four patches will update setools-3.3.8.tar.bz2 available from
>> http://oss.tresys.com/projects/setools/wiki/download
>>
>> I know this is not being fully supported but as I use APOL frequently
>> I thought I would update it to support the latest policy version 29 (I
>> could be the only user!!!). Tested on latest Fedora 20 x86_64
> Thanks, we'll take a look at these.  You're not the only user, as we use it internally at Tresys a lot.  Actually, we're in the process of prototyping SETools 4.  There are a few things that have been a challenge for maintaining SETools over the years:
>
> * Libsepol is only designed for building the policy, not analyzing the policy:  It doesn't have an API that's conducive to querying the policy (it didn't even exist when SETools started).  SETools' source policy parsers have to be copied from checkpolicy/checkmodule.
> * It's over 10 years old and has been very evolutionary in its development (hence tk and gtk toolkits, for example)
> * A (nearly) full C implementation is fast, but we have our own implementations of functions/structures come built-in on OO languages.
>
> So we're looking at the possibility of reimplementing SETools in Python.  That brings in a huge amount of capability.  For example, libapol has it's own vector implementation, which can be replaced with Python lists (or sets) and all their functions.  Similarly, we're evaluating the NetworkX graph library as a basis for the information flow and domain transition analyses.
>
> Additionally, we'd like to see if some form of the libqpol API (or something similar) could be upstreamed into libsepol (or be a new upstream library).  It was discussed before at some point after the SETools dependency in audit2allow got upstreamed, but didn't really end in any implementation.
>
> We're not quite ready for shifting to public development (we're not even set on Python yet, though it's very likely), but we'll let the list know when that happens.
>
