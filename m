MIME-Version: 1.0
In-Reply-To: <70144410-e5bc-e96c-1a20-24b25c73fa2d@tycho.nsa.gov>
References: <1479323571-8501-1-git-send-email-william.c.roberts@intel.com>
 <1479323571-8501-2-git-send-email-william.c.roberts@intel.com>
 <CAFftDdrMH63b2Y37HToZVmoWgqm0_fdD9w8LNZJjXeypC44vng@mail.gmail.com>
 <24ae9eb5-3f0b-d7cf-500e-c00b6f99a092@tycho.nsa.gov>
 <CAFftDdr-ttK0ebet=TbWO1wO8DAPdcpPbnb58ATAeDnQm1qSMA@mail.gmail.com>
 <70144410-e5bc-e96c-1a20-24b25c73fa2d@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 16 Nov 2016 13:41:08 -0800
Message-ID: <CAFftDdrMfdzL3zBASTkY7ktts4URs6UJroP_+T9fJuuTWjhLpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] expand_avrule_helper: cleanup
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 16, 2016 at 12:57 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/16/2016 03:37 PM, William Roberts wrote:
>> On Wed, Nov 16, 2016 at 11:50 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 11/16/2016 02:32 PM, William Roberts wrote:
>>>> sediff reports no delta between policies built on master and these 2 patches.
>>>
>>> Not possible.  checkpolicy segfaults with these patches.
>>> Probably didn't rebuild it after rebuilding libsepol.
>>> Anyway, you can just use cmp to compare the policies here; they should
>>> be byte-for-byte identical.
>>
>> Crazy, I only tested these on Android.
>
> Again, not possible.  checkpolicy calls expand_module() with NULL
> handle, and therefore segfaults with this change.  You could not have
> been invoking a checkpolicy built with this change and had it work
> (also, even aside from that, you would have ended up failing later
> because you weren't mapping the DONTAUDIT values).
>

Hmm I'm using a test script the always builds everything, it didn't
segfault, but
I did get different policy hashes, which is why I ran sediff. Either
way it doesn't
matter, the patch was wrong.

v2 (currently unsent):
59b2538cf2789ba8f7496644ff8fef5c  bullhead.policy.old
93548cfc4de715432d2118353ed1d56a  marlin.policy.old
59b2538cf2789ba8f7496644ff8fef5c  bullhead.policy.new
93548cfc4de715432d2118353ed1d56a  marlin.policy.new

That looks better.

<snip>
