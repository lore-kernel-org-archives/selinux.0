From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Colin Walters'" <walters@verbum.org>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Fri, 5 Nov 2004 08:01:48 -0500
Message-ID: <01e001c4c337$9ce64210$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099658949.6373.28.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Subject: Re: dynamic context transitions
> 
> 
> On Fri, 2004-11-05 at 00:31, Colin Walters wrote:
>> There seemed to be a consensus behind restricting dynamic
>> transitions to within a "domain hierarchy"; i.e. that an application
>> could not dynamically gain more privileges, only shed them.  Is that
>> true?  And if so, what will the language to define them look like?
> 
> That's a policy issue; it doesn't affect the mechanism implementation
> in the kernel.  Tresys is doing work on language extensions that
> would help support such restrictions, but that work is purely
> userspace; the policy will still be compiled down to the existing
> form for the kernel. 

True.  The actual enforcement of the switch-in-hierarchy constraint could be
enforced entirely within the policy compiler (a weak security enforcement, but
strong convention enforcement), which eventually would be overcome by an actual
running policy server (a strong security enforcement).  However we could also
design the kernel's context switching capability to understand name hierarchy,
maintain upper bounds for processes, and enforce it strongly in the kernel
(e.g., by using the starting type for a new process as its upper bound in a name
hierarchy).  The latter approach seems a stronger security mechanism, allowing
much of what is desired while maintaining a great deal of conceptual commonality
with the current tranquility model (IMHO). 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
