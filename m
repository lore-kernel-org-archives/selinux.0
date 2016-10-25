Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9PMCpJ4017523
 for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2016 18:12:51 -0400
Subject: Re: [RFC] Split up policycoreutils
To: Jason Zaman <jason@perfinion.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
 <20161025034900.GA14100@meriadoc.perfinion.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <69bc9988-47ed-5dec-c470-db721cb281a8@ieee.org>
Date: Tue, 25 Oct 2016 18:12:18 -0400
MIME-Version: 1.0
In-Reply-To: <20161025034900.GA14100@meriadoc.perfinion.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/24/16 23:49, Jason Zaman wrote:
> On Mon, Oct 24, 2016 at 09:13:42AM -0400, Stephen Smalley wrote:
>> On 10/22/2016 09:44 AM, Chris PeBenito wrote:
>>> On 10/21/16 13:47, Stephen Smalley wrote:
>>> I'm not sure where the main part of sepolicy should go, but it would be
>>> nice to split it out since it depends on setools which has heavier
>>> dependencies than a core system package should typically have IMO
>>> (NetworkX, which pulls in scipy, numpy, matplotlib, etc.)
>>
>> I would be in favor of that too, but hesitated to do so because it would
>> require moving audit2allow and semanage out of policycoreutils as well.
>> Fedora does package those as part of policycoreutils-python (along with
>> sepolgen).  Arguably audit2allow isn't necessary for production (but
>> many users of SELinux in Linux distributions rely on it), but semanage
>> is more fundamental these days.
>>
>> However, if people are open to moving sepolicy, audit2allow, and
>> semanage, possibly combining them with sepolgen in a new
>> subdirectory/package, then we could explore that.
>
> My eventual goal for seobject.py was to just kill it, there isnt really
> anything that setools4 doesnt have. For the last release mostly due to
> lack of time I changed several parts to just be sort of thin wrappers
> around setools.
>
> sepolicy also seemed like two separate things. one part was a kind of
> library thing which i updated to use setools4 too, that would be better
> off dying or being a separate small lib. then there is the whole gui
> part of sepolicy which can probably be split out. I dont think i've ever
> personally used the gui. semanage only requires the lib parts.
>
> I havent looked too much into the core of setools4 other than what I
> needed to update sepolicy so I'm not sure how important networkX and
> stuff are. semanage might only require the base stuff if we're able to
> split that out?

NetworkX is a dependency for the domain transition and information flow 
analyses only.  You could conceivably make those conditional, but I'm 
not particularly fond of the idea.

-- 
Chris PeBenito
