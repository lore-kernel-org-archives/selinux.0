Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <01fd01c4c359$e70c5fb0$1e0c010a@columbia.tresys.com>
References: <01fd01c4c359$e70c5fb0$1e0c010a@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099676893.6373.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 12:48:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 12:07, Frank Mayer wrote:
> Adding/removing permissions?  That's not mandatory security, flexible or not.
> Dropping permissions permanently can only be achieved securely (or as secure as
> Linux possible) by exec'ing into a new, lower domain so that's covered.  And I
> thought the need was privilege bracketing, allowing software the arbitrary
> ability to add/drop base privileges, which the hierarchy does naturally.

Mandatory in what sense?  As we have always used the term, it signifies:
admin-controlled policy, control over all subjects and objects,
decisions based on all security-relevant information.  Dynamic
transitions would be subject to the control of the policy.

TCS has clearly expressed the desire to be able to shed permissions
permanently within an application.  The samba discussion talked about an
orthogonal transformation with three types, starting in a domain with
access to samba configuration files only, transitioning to a domain with
access to user files only, and then transitioning to a domain with
access to nothing for cleanup before transitioning back to the initial
domain.  Such orthogonal transformations are common for the exec-based
domain transitions today, for least privilege purposes.

> If this mechanism is implemented as proposed, I do not think we can implement a
> hierarchy at all, in the compiler or anywhere.  There will be no way to allow a
> process to start at a point in the hierarchy, and allow it move down *and* up
> again.  For example, take the hierarchy: A, A.1, A.1.1, A.1.2 where each are a
> type.  If I want to allow a process that starts in A to change to any type A.*
> and back again and between any types in the tree, I have to allow A.* to change
> to any other A.*.  If that's the case then I can't have a process start at A.1
> and not be allowed to get to A, since the rules would allow A.* to change to any
> other A.*.

I'm not sure I understand your point.  The "if" part seems to be a
strawman that forces your conclusion.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
