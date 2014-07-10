Message-ID: <1405003843.661.27.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 16:50:43 +0200
In-Reply-To: <53BEA459.8060305@tycho.nsa.gov>
References: <53BD9646.6030303@tresys.com> <53BE9F2A.9050906@tycho.nsa.gov>
 <1405002183.661.17.camel@x220.localdomain> <53BEA25D.8090501@tycho.nsa.gov>
 <53BEA459.8060305@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-07-10 at 10:34 -0400, Stephen Smalley wrote:
\
> 
> Hmmm...but rebooting "cleared" it and now I can su without delay and no
> systemd error message.
> 

Yes , sound like the issue i hit yesterday (when i updated my e145
policy)

basically i loaded the updated policy, rebooted (system was hanging),
hard reset, looking at avc denials, system_t self:dbus send_msg was
denied. (even though i had that rule both before and after i updated my
policy. was not able to reproduce it after that, but looks like we will
be seeing more from this issue soon.

> Merged #next to #integration locally to try to pick up the improved
> error reporting on unknown class/perms but can't reproduce it now...
> 
> 
> 
