Subject: Re: [PATCH v2 2/8] genhomedircon: move fallback user to
 genhomedircon_user_entry_t
To: Jason Zaman <jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-3-git-send-email-jason@perfinion.com>
 <b8ccf4b3-15b0-d50c-be4b-20c30a1a3af4@tycho.nsa.gov>
 <20160429192314.GA14636@meriadoc.perfinion.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <72c34032-8d57-dd8f-a422-bb0e3abffaa3@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 16:29:18 -0400
MIME-Version: 1.0
In-Reply-To: <20160429192314.GA14636@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2016 03:23 PM, Jason Zaman wrote:
> On Fri, Apr 29, 2016 at 12:54:44PM -0400, Stephen Smalley wrote:
>> On 04/23/2016 02:04 AM, Jason Zaman wrote:
>>> The fallback user is used in all the write functions, making it use a
>>> struct allows us to have everything consistent between normal and
>>> fallback users.
>>>
>>> Signed-off-by: Jason Zaman <jason@perfinion.com>
>>
>> When you split a patch into a series, the goal is to ensure that the
>> code remains in a working state after each patch in the series.
>> Otherwise, git bisect will often find broken states in the future.
>> So, we have two options:
>> 1. You can refactor this patch set so that it does compile after each
>> patch (currently breaks on this one at least).
>> 2. I can squash them all into one logical change.
> 
> The best is squashing 2-4 into one then. The others are pretty self
> contained. 2-4 was a really big change so I split it up even tho it
> broke the build but if you'd prefer squashing them thats not a problem.

I have to squash 2-5 to keep it buildable at each step.
