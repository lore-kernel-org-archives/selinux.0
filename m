Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o45IPVwS010464
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 14:25:31 -0400
Received: from mail-ew0-f210.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o45IQaV7024931
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 18:26:37 GMT
Received: by ewy2 with SMTP id 2so1436336ewy.36
        for <selinux@tycho.nsa.gov>; Wed, 05 May 2010 11:25:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
Date: Wed, 5 May 2010 14:25:28 -0400
Message-ID: <AANLkTimAb0vnrmRMDLbgyCCGTTMxJexBX_v0KlnYtMdn@mail.gmail.com>
Subject: Re: Life cycle process for building products with selinux
From: Karl MacMillan <kmacmillan@tresys.com>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 5, 2010 at 10:22 AM, Alan Rouse <alan.rouse@ericsson.com> wrote:
> I'm not sure where to ask a question like this but I bet someone on the list
> will know…
>
> Are there any guidelines or "best practices" for building products with
> selinux?   (Think network appliances for example.)  I have in mind life
> cycle tasks such as
>
> - Software development:  Where in the software development cycle do you
> introduce selinux?  Should application developers have to develop on a
> system confined by selinux?

How we do this depends on the development team. When the team is
unfamiliar with SELinux then I believe that it's best to turn on
enforcement as early as possible so that developers start to
understand what is going to happen.

For our internal development projects - which are often appliances -
we actually design the system with SELinux in mind but don't worry
about writing policy right at the beginning. We can get away with this
because the way we use SELinux is often a key feature of the design
and everyone on the development team has a very thorough understanding
of how the enforcement will happen.

> Is selinux policy maintenance a software
> development task, or a separate phase in the development cycle?
>

We always treat it as software development. Doing too early is not
useful because the applications aren't well formed enough and doing it
after primary development doesn't catch coding errors that would
require overly permissive policy.

> - System integration:  Is this where selinux is first turned on?
>

We always have SELinux on, but leave it in permissive all the way past
the initial integration steps. We still experiment with the right
point to switch to enforcing, but currently leave it until a build or
two that has been run all the way through the integration tests. We
also have a mechanism for testers to switch to permissive and re-run
tests to get better diagnostics.

> - QA testing:  should QA testing include selinux-specific penetration
> testing?  Any guidelines or examples of how this is done?  Any tools?
>

We rely more on policy analysis rather than penetration testing, but
this requires a clear, documented set of security goals and expertise
to compare the policy against those goals. We use setools for the
analysis.

> - Who in the development organization needs selinux expertise?
>

Our situation is a bit unusual, but at Tresys every developer has good
knowledge of security and SELinux. We find this enormously beneficial
and we can justify the investment because security is key to our
business. Obviously not everyone has that benefit.

When we help teams where the knowledge of SELinux is more mixed there
are a variety of challenges. The hardest is helping developers
understand how to design software to maximize the benefit of MAC. So
many developers with security knowledge are overly focused on correct
code that privilege separation and limiting process trust are foreign
concepts. If you can't have everyone in the organization be
knowledgeable, then I would suggest teaching people about the big
picture concepts, how to switch to permissive, and how to read and
minimally interpret AVCs. That get's people to buy into using SELinux
and lets them provide good debugging information.

Without that context, SELinux can become a scapegoat for all hard to
explain bugs. Letting people quickly determine for themselves if
SELinux is to blame can avoid a lot of frustration.

> - Are there services that can certify the MAC rules for the operating
> system?  For the product application?
>

Do you mean in an automated way? Not really - there is no substitute
for a knowledgeable person reviewing the policy. If you mean
professional services, we (Tresys) do system and policy analysis and I
know others do as well.

> - Any selinux-specific guidance for customers who install the protected
> appliance?
>

Depends on how much of an appliance it is. If there is a shell or the
possibility of installing software, then we give SELinux guidance in
documentation. Otherwise we just collect AVCs with other log
information for diagnostics.

> - Impact on the process for upgrades and patches because of selinux.  What
> not to do… for example, turning off selinux to apply a patch.  How to
> configure a properly confined user for applying patches.
>

It's very, very difficult to give an admin access to only apply
patches if you don't want them to have arbitrary access to the system.
Even restricting packages to only signed packages is hard. We just
patch with SELinux on from a domain with sufficient privilege and test
the updates before releasing them. Only rarely should there be a
problem - only if the installation of the upgrade requires a policy
change.

> - Organizational policy to complement a properly designed system (separation
> of duties; physical security; etc).
>

Most of the systems we design are installed in locations where these
policies are already in place. Role separation is something that it
would be nice to see get easier in SELinux.

> - War stories, lessons learned… or anything of the sort
>

Admins and users are always much harder than anything else - the
variety in how admins accomplish similar tasks still surprises me and
makes the policy more complex.

It's possible to lock systems down until they are irritating or
impossible debug - we tend to always leave the ability to get to a
permissive mode but protect it with policy, grub passwords, etc.
During testing it's nice to have this unlock automated.

When there are policy problems, it's best to switch to permissive and
exercise the system thoroughly. Going through many fix, build,
install, test iterations to fix policy bugs can eat up a lot of time.
Raw audit messages are much better than audit2allow output.

Installing a fully custom policy in an automated way on existing
distributions is  harder than it should be - basically you are going
to be forced into a full relabel on initial boot because of
differences between the policy during installation and on the actual
system.

Karl

> Thanks
> Alan
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
