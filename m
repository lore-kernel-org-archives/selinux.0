From: "Frank Mayer" <mayerf@tresys.com>
To: "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Fri, 5 Nov 2004 11:01:37 -0500
Message-ID: <01f801c4c350$bb88ef10$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <418B968F.3070700@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Subject: Re: dynamic context transitions
> 
> 
> Frank Mayer wrote:
>> In any case, this would require some patience before dynamic
>> contexts are available in order to develop the language constructs
>> and new kernel support for context change (probably a couple of
>> months).  Are we prepared to wait a little longer for the more
>> constrained mechanism? 
>> 
>> Frank
> 
> The current proposed implementation gives the policy writer very
> fine-grained control over the use of dynamic transitions.

The current proposal gives the policy writer the ability to related process
types in arbitrary ways.  So the concept of "domain" is no longer simply "the
type of a process", but "depends, based on what the policy writer wrote."  I can
no longer look at entry into a domain by looking at file exec permission (ala
apol domain transition analysis), but have to start looking for types that are
related via this mechanism.  That's a fairly significant change in concept (and
conceptual complexity) to achieve what many of us have argued is a feature of
marginal security merit.  The hierarchy proposal appears a reasonable compromise
that retains strong notion of domain type yet allowing privilege bracketing.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
