From: "Frank Mayer" <mayerf@tresys.com>
To: "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Core policy, second pass
Date: Thu, 27 Feb 2003 08:53:27 -0500
Message-ID: <000101c2de67$9d9aa270$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200302270923.25751.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me that the idea of categories should be simpler in concept
than I perceive where the discussion is going.  All .te files should be
distributed, just some enabled and some not.  Likewise all should be
categorized.  I don't think the category tag is that critical as long as
it provide some intuitive meaning.  I think this was Wayne's original
suggestion.

I for one do not imagine these category tags being used primarily to
include/exclude whole groups of policy modules, or to characterize a
particular environment.  Any given application of selinux will have
significantly different configuration than any other, and all the
category tags provide is a logical way to view the options.  For
example, in any definition, I would assert that load_policy.te would be
categorized as core.  But there are plenty of target applications where
the load_policy program would not be installed (e.g., embedded
applications where field updates to policy is not desired).

We should not bundle the idea of categorization with customization;
rather we should use categories as an aid to customization (e.g., if I'm
not using X, having all X related services together in one category
would make it simpler to customize the policy).  I suggest categories
like core/base, development, utils, database, X, libs, admin,... or some
similar logical affinity.  If someone wants to create a customize
package for their view of a workstation, mail servers, etc., then
they'll have to customize the policy for their application.  Someone's
package for the same application will likely be different.  We can't
solve that problem generically; only help.

Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
