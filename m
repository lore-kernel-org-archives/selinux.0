Message-ID: <4255A62F.80405@trustedcs.com>
Date: Thu, 07 Apr 2005 16:29:19 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: policy hierarchy patch
References: <1112631282.19526.18.camel@localhost>	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>	 <425456F1.5000905@trustedcs.com>	 <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>	 <42556015.6090405@trustedcs.com> <1112907833.19565.9.camel@localhost>
In-Reply-To: <1112907833.19565.9.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Thu, 2005-04-07 at 11:30 -0500, Darrel Goeddel wrote:
> 
>>Stephen Smalley wrote:

>>>The original hierarchy patch also collapsed the identifier and
>>>user_identifier together, thereby allowing "-" to occur in any
>>>identifier.  As a result, if someone specifies s0-s9 in the policy
>>>without whitespace, it will be incorrectly interpreted as an attempt to
>>>specify a level named "s0-s9".  Further, nothing prevents someone from
>>>defining a level or category name that includes a "-" presently.
>>>Options are to revert the change from the original patch that collapsed
>>>identifier and user_identifier together (only adding "." to identifier,
>>>not "-") or to add further handling to the action routines to deal with
>>>it.
>>>
> 
> 
> Out of curiousity, why are sensitivity ranged specified with '-' and
> category ranged specified with '.'?
> 

To ease (or make possible) parsing things like "s0:c1 . c4 - s1:c1 . c4".
If it was "s0:c1 - c4 - s1:c1 - c4", the second '-' is ambiguous.  At least
thats why I think its that way...

> I think this is correct, not just because of the explanation above but
> because this may cause issues with space sensitivity in type sets, ie
> { foo-bar } is the same as { foo -bar } now, but wouldn't be with this
> patch. I'll fix this and send out a patch tomorrow.

Ahhh. I misread the comment earlier - I read it as "go back to IDENTIFIER and
MLS_IDENTIFIER".  I think going back to "USER_IDENTIFIER and IDENTIFIER", and
ditching the '-' in Ithe current DENTIFIER is the way to go.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
