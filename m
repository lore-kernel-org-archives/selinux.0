Subject: Re: [PATCH 0/2] genhomedircon: add support for %group syntax
To: Jason Zaman <jason@perfinion.com>
References: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
 <a0946bf4-e061-7298-fe4f-2a51345f612e@tycho.nsa.gov>
 <20160823131835.GA20743@meriadoc.perfinion.com>
Cc: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <06c0204b-205f-bf06-924d-1bcb1e3ba4a4@tycho.nsa.gov>
Date: Tue, 23 Aug 2016 11:26:44 -0400
MIME-Version: 1.0
In-Reply-To: <20160823131835.GA20743@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/23/2016 09:18 AM, Jason Zaman wrote:
> On Tue, Aug 23, 2016 at 08:54:17AM -0400, Stephen Smalley wrote:
>> On 08/22/2016 04:22 PM, Gary Tierney wrote:
>>> From: Gary Tierney <selinux@tycho.nsa.gov>
>>>
>>> Re-spin of my original patch that adds support for logins mapped using the
>>> group %syntax to genhomedircon.  This version includes fixes for the issues
>>> raised by Jason and splits the bugfix into a separate commit.
>>>
>>> There was a bit of confusion about the MLS level, I think, since semanage-user
>>> supports a default MLS level and not semanage-login.  So it wouldn't be possible
>>> for a login to have a more specific level than the fallback login in that case.
>>> Though the bugfix still addresses an issue with home directories outside of
>>> /home / LU_HOMEDIRCETORY and is required for the second commit.
>>
>> semanage login can set a more limited range for a Linux user than what
>> is allowed for the SELinux user.  Thus, you can have a single SELinux
>> user that is authorized for a wider range but narrow its scope on a
>> per-Linux-user basis via semanage login.
> 
> semanage user has --level and --range
> semanage login has only --range.
> You mean setting --range on a specific linux user to be a subset of what
> is in the semanage user range?

Yes; you can set it to either a subrange or even just a single level
within the user range, and thereby constrain that particular Linux user
to only that subrange or level.  Avoids requiring one to define a
separate SELinux user for every possible level/range that you want to
authorize for an individual Linux user.  That's why semanage login range
(aka seusers range) exists.

> What exactly is semanage user --level used for then? and which one(s?)

It depends. It won't be used at all if it doesn't fall within the
semanage login range for the Linux user - then the semanage login
range's low level wins.  If it does fall within the semanage login range
for the Linux user, then it is used as the low level for the user's
context at login time.

The logic is rather complicated, both as a result of historical changes
(original MLS -> modern MLS model, introduction of seusers and semanage
login) and by various use cases.  There is quite a bit of historical
baggage and complexity in the computation of user contexts at login time
that I'd like to see eliminated and consolidated; currently it is spread
across pam_selinux, libselinux, and the kernel.

> of all these values matter for genhomedircon? Is it --level or is it just the
> lowest one within login --range?

Presently appears to always use the semanage user level.  That's correct
in the case where it falls within the semanage login range, but not in
the other case.

> meriadoc ~ #  semanage user -l
>                 Labelling  MLS/       MLS/
> SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles
> 
> root            sysadm     s0         s0-s0:c0.c1023                 staff_r sysadm_r
> 
> In the prev version of the patch, I thought you meant the "s0" here which
> doesnt exist in semanage login -l.
