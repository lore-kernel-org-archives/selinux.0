From: "Frank Mayer" <mayerf@tresys.com>
To: "'Colin Walters'" <walters@verbum.org>,
   "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Fri, 5 Nov 2004 07:52:27 -0500
Message-ID: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099632701.25416.19.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:
> Subject: Re: dynamic context transitions
> 
> 
> On Thu, 2004-11-04 at 11:50 -0500, Stephen Smalley wrote:
> 
>> I would like to move forward with this proposal, going beyond a
>> discussion of whether or not it should be implemented to how it
>> should be implemented.
> 
> There seemed to be a consensus behind restricting dynamic transitions
> to within a "domain hierarchy"; i.e. that an application could not
> dynamically gain more privileges, only shed them.  Is that true?  And
> if so, what will the language to define them look like?

I think the best consensus we achieved was that a process could change its
domain type (hence its privileges) "up or down" the hierarchy within a given
range.  However I sense a desire to create a capability more urgently than the
time this mechanism will take to develop.  We're in the process of contemplating
a re-prioritization in our design efforts in order to develop the domain
hierarchy feature sooner (there are other reasons for such a semantic too).
However, this would also require some additional kernel features to support
"dynamic context" (as does the current proposal).  In particular something in a
process security context that would define the upper bound in the hierarchy for
a context switch, and some type of rule enhancement (probably to
type_transition) to define the upper bound context for a given entry point (or
we could assume that the starting domain type is the upper bound and no lower
bound is required).

In any case, this would require some patience before dynamic contexts are
available in order to develop the language constructs and new kernel support for
context change (probably a couple of months).  Are we prepared to wait a little
longer for the more constrained mechanism?

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
