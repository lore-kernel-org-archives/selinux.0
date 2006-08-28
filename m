Message-ID: <44F31A4F.9070800@trustedcs.com>
Date: Mon, 28 Aug 2006 11:31:11 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [PATCH 1/3] support for extended range_transitions
References: <44F318B9.6010303@trustedcs.com>
In-Reply-To: <44F318B9.6010303@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Introduce support for kernel policy format version 21, base policy 
> format version
> 6, and policy module format 6.  These new formats allow for the 
> definition of
> range_transitions on security classes other than "process".  The new 
> module and
> base formats (both 6) also move expansion of the range_transition 
> statements
> from compile time to the actual expansion phase.  This change should 
> allow for
> using range_transitions in policy modules (with a bit more work in the 
> future)
> with another change in format.
> 
> The current range_transition statements are of the form:
>   range_transition <source types> <target types> <new range>
> These statements affect process transitions only.  The new supported 
> format is:
>   range_transition <source types> <target types>:<target classes> <new 
> range>
> With this format it is possible to to specify a new range for operations 
> such
> as file creation.  The old style statements are still allowed and they
> implicitly refer to the "process" security class, thereby retaining the 
> same
> behavior as before.
> 
> The new kernel format now stores the security class on which the rule 
> operates.
> When dealing with older kernel policy formats, the "process" security 
> class is
> implicit.
> 
> The new module and base formats now store a representation of the rule 
> just (the
> new addition to the avrule_decl structure) and are expanded at the 
> proper time.
> The previous implementation expanded the rules at compilation time and 
> could
> produce an incomplete set of transitions if type attributes were used in 
> the
> statement. Here is how range_transition statements are handled for the 
> various formats:
> for kernel policy version up to 18, there are no range_transition
> for kernel policy versions 19 and 20, a list of old-style (no class 
> specified)
>   range_trans structures are encoded
> for kernel policy versions 21 and up, a list of new-style (class specified)
>   range_trans structures are encoded
> 
> for base policy versions up to 5, there are no range_transitions
> for base policy version 5, a compile-time generated list of old-style (no
>   class specified) range_trans structures are encoded as they are in kernel
>   formats 19 and 20
> for base policy versions 6 and up, an expressive rule stating the intention
>   of the statement is stored - that will be properly linked and expanded
>   for further usage
> 
> for module policy versions up to 6, there are no range_transitions
> for base policy versions 6 and up, an expressive rule stating the intention
>   of the statement is stored jut like in base policy version 6 (of 
> course we
>   still need more work to get them in there, but the format is supportive).

Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>

---

I forgot that we're doing this for the userspace code now, sorry.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
