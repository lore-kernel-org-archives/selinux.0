Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <01f701c4c34f$e4c56170$1e0c010a@columbia.tresys.com>
References: <01f701c4c34f$e4c56170$1e0c010a@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099672876.6373.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 11:41:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 10:55, Frank Mayer wrote:
> I guess I don't see this issue as policy, but rather as fundamental nature of
> "domain" in TE.  What I'm proposing is to retain the notion of domain type as a
> strong concept, yet still allowing practices such as privilege bracketing. In
> essence, any name hierarchy tree, from its upper bound starting point on down,
> is one domain.  The language would guarantee that there is no increase of
> permission "down" the tree hierarchy.  A process can freely drop "down" the
> hierarchy to its privilege (at its discretion) and go back "up" the hierarchy
> (but not above its upper bound or starting point type) to re-assert its base
> privileges.  So the definition of a domain is still largely the same, i.e., the
> starting type of a process.

What about permanently shedding permissions after a certain point in
processing within a program?   What about an orthogonal transformation,
e.g. adding permission to one type while removing permission to another
type for least privilege purposes?  I think that your model will prove
too simplistic and inflexible.

> To me this is not policy, but definition of domain.  The notion of domain type
> entry only via exec isn't a policy decision, and neither would this.

This is just another way of arguing aginst dynamic context transitions
at all.  A "domain" is a security equivalence class for processes. 
Whether or not it can change only at new-subject-creation time is
another matter, and I don't think SELinux would be the first TE system
to support dynamic changes in domain.  Parallel:  Files can be
relabeled, not just assigned a label when they are created.  Kernel
imposes no inherent restriction on the relationship among those types;
it just enforces the policy as defined.

> In fact we don't even have to have a permission to allow context change, there's
> no reason to prevent any process from dropping down the type tree as long as
> there are guarantees that the sub-domains are always less privileged.  Seems a
> lot simpler and still responsive.

I don't think this will meet the need, as above.

> The current proposal, if I understand correctly, will allow policy writers to
> arbitrary related multiple type domains forcing analysis to be treat all related
> domains as a "union domain."  

Yes, the kernel mechanism is only restricted by the policy.  What
restrictions can/should be imposed by userspace can be investigated, but
we don't have a clear answer presently, nor a clear sense that a single
set of restrictions will properly cover every case.

> What I'm not entirely sure of is the best mechanisms: how much of this is
> enforced in policy compile (probably the hierarchy implicit constraints) and how
> much the kernel needs to be involved in?  The kernel has to define context
> switch, so why not have it preserve the concept of domain type the same time?

Because the concept, as stated above, is really a policy decision.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
