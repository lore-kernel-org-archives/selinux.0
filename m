From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Fri, 5 Nov 2004 10:55:37 -0500
Message-ID: <01f701c4c34f$e4c56170$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099660413.6373.55.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Subject: RE: dynamic context transitions
> On Fri, 2004-11-05 at 08:01, Frank Mayer wrote:
>> True.  The actual enforcement of the switch-in-hierarchy constraint
>> could be enforced entirely within the policy compiler (a weak
>> security enforcement, but strong convention enforcement), which
>> eventually would be overcome by an actual running policy server (a
>> strong security enforcement). However we could also design the
>> kernel's context switching capability to understand name hierarchy,
>> maintain upper bounds for processes, and enforce it strongly in the
>> kernel (e.g., by using the starting type for a new process as its
>> upper bound in a name hierarchy).  The latter approach seems a
>> stronger security mechanism, allowing much of what is desired while
>> maintaining a great deal of conceptual commonality with the current
>> tranquility model (IMHO).  
> 
> That starts to move policy into the kernel mechanism.  Consider the
> parallel for exec-based transitions; would we want the kernel
> mechanism for exec-based transitions to fundamentally limit the
> relationship between the old and new contexts?  That is more like the
> POSIX.1e capability model, where you have a hardwired evolution logic
> for capabilities upon exec, but that leads to all kinds of problems,
> as one size doesn't fit all.

I guess I don't see this issue as policy, but rather as fundamental nature of
"domain" in TE.  What I'm proposing is to retain the notion of domain type as a
strong concept, yet still allowing practices such as privilege bracketing. In
essence, any name hierarchy tree, from its upper bound starting point on down,
is one domain.  The language would guarantee that there is no increase of
permission "down" the tree hierarchy.  A process can freely drop "down" the
hierarchy to its privilege (at its discretion) and go back "up" the hierarchy
(but not above its upper bound or starting point type) to re-assert its base
privileges.  So the definition of a domain is still largely the same, i.e., the
starting type of a process.  

To me this is not policy, but definition of domain.  The notion of domain type
entry only via exec isn't a policy decision, and neither would this.

In fact we don't even have to have a permission to allow context change, there's
no reason to prevent any process from dropping down the type tree as long as
there are guarantees that the sub-domains are always less privileged.  Seems a
lot simpler and still responsive.

The current proposal, if I understand correctly, will allow policy writers to
arbitrary related multiple type domains forcing analysis to be treat all related
domains as a "union domain."  

What I'm not entirely sure of is the best mechanisms: how much of this is
enforced in policy compile (probably the hierarchy implicit constraints) and how
much the kernel needs to be involved in?  The kernel has to define context
switch, so why not have it preserve the concept of domain type the same time?

Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
