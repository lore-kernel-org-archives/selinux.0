From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Fri, 5 Nov 2004 12:07:15 -0500
Message-ID: <01fd01c4c359$e70c5fb0$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099672876.6373.182.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> What about permanently shedding permissions after a certain point in
> processing within a program?   What about an orthogonal
> transformation, e.g. adding permission to one type while removing
> permission to another type for least privilege purposes?  I think
> that your model will prove too simplistic and inflexible.

Adding/removing permissions?  That's not mandatory security, flexible or not.
Dropping permissions permanently can only be achieved securely (or as secure as
Linux possible) by exec'ing into a new, lower domain so that's covered.  And I
thought the need was privilege bracketing, allowing software the arbitrary
ability to add/drop base privileges, which the hierarchy does naturally.

>> The current proposal, if I understand correctly, will allow policy
>> writers to arbitrary related multiple type domains forcing analysis
>> to be treat all related domains as a "union domain."
> 
> Yes, the kernel mechanism is only restricted by the policy.  What
> restrictions can/should be imposed by userspace can be investigated,
> but we don't have a clear answer presently, nor a clear sense that a
> single set of restrictions will properly cover every case.

If this mechanism is implemented as proposed, I do not think we can implement a
hierarchy at all, in the compiler or anywhere.  There will be no way to allow a
process to start at a point in the hierarchy, and allow it move down *and* up
again.  For example, take the hierarchy: A, A.1, A.1.1, A.1.2 where each are a
type.  If I want to allow a process that starts in A to change to any type A.*
and back again and between any types in the tree, I have to allow A.* to change
to any other A.*.  If that's the case then I can't have a process start at A.1
and not be allowed to get to A, since the rules would allow A.* to change to any
other A.*.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
