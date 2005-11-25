Subject: Re: [refpolicy][PATCH] fix Makefile BASE_MODS and
	MOD_MODS	detection
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Johan Fischer <jfischer@cmcrc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <438656CE.6030804@cmcrc.com>
References: <43715253.2070108@cmcrc.com> <1131546156.24234.58.camel@sgc>
	 <438656CE.6030804@cmcrc.com>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 09:22:49 -0500
Message-Id: <1132928569.7775.5.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-25 at 11:11 +1100, Johan Fischer wrote:
> the solution to the problem....
> 
> make sure that you're using gawk and not mawk as the default awk on your
> system.
> 
> possibly the gawk and mawk way of adding extra anchors might be
> different making it fail on my installation ( I don't how when I
> installed mawk or why, but anyway....)

Perhaps the awk commands should be changed to gawk.  I wouldn't think it
would be a problem; it doesn't seem likely that a policy will be built
on a non-GNU system.

> Christopher J. PeBenito wrote:
> 
> >On Wed, 2005-11-09 at 12:35 +1100, Johan Fischer wrote:
> >  
> >
> >>quick patch to fix the modules detection from the modules.conf file...
> >>
> >>before:
> >>$ awk '/^[[:blank:]]*[[:alpha:]]/{ if ($3 == "module") print $1 }'
> >>policy/modules.conf
> >>(no result)
> >>
> >>after:
> >>$ awk '/^[[:blank:]]*[[:alpha:]]*/{ if ($3 == "module") print $1 }'
> >>policy/modules.conf
> >>apm
> >>apache
> >>bluetooth
> >>    
> >>
> >
> >I can't reproduce this behavior.  I don't believe this patch is correct,
> >as it makes the regex too inspecific.  With the change, the regex
> >matches all lines, so if the second word in a comment was "module", it
> >would print out "#", causing errors.
> > 
> >  
> >
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
