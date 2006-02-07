Message-ID: <43E9079B.9020600@tresys.com>
Date: Tue, 07 Feb 2006 15:48:27 -0500
From: Chad Sellers <csellers@tresys.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: selinux-dev@tresys.com
Subject: [Patch] Refpolicy constraints patch for hierarchy
Content-Type: multipart/mixed;
 boundary="------------060306010800010708070300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060306010800010708070300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is a patch to reference policy that modifies constraints to allow
using type hierarchy (as provided through "dot" notation) in a certain
way with reference policy. This way corresponds to that used in the
Framework which we've been working on at Tresys, in which we use
hierarchical types to create boundaries which domains cannot escape
from. For example, I create outside_t, outside_t.inside_one_t, and
outside_t.inside_two_t, where inside_one_t and inside_two_t are
constrained by the permissions allowed to outside_t. All 3 of these are
given the domain attribute.

The problem arises when you want to place files inside the outside_t
security boundary. To do this, we must give the file_type attribute to
outside_t. Currently in reference policy, this is not possible because
of a constraint which prevents process permissions on anything with a
file_type attribute. We modify this to prevent process permissions on
anything that's not a domain, so parent types can have both the domain
and the file_type attribute. As an additional side effect, this prevents
granting process permissions to types that aren't domains or file_types,
such as network types, thereby making this constraint more precise in
what it's trying to do.

Thanks,
Chad
-- 

----------------------
Chad Sellers
Tresys Technology, LLC
http://www.tresys.com


--------------060306010800010708070300
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="hierarchy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hierarchy.diff"

Index: policy/modules/kernel/domain.te
===================================================================
--- policy/modules/kernel/domain.te	(revision 1472)
+++ policy/modules/kernel/domain.te	(working copy)
@@ -63,7 +63,5 @@
 # SELinux identity and role change constraints
 attribute process_uncond_exempt;	# add userhelperdomain to this one
 
-# TODO:
-# cjp: also need to except correctly for SEFramework
-neverallow { domain unlabeled_t } file_type:process *;
+neverallow { domain unlabeled_t } ~{ domain unlabeled_t }:process *;
 neverallow ~{ domain unlabeled_t } *:process *;



--------------060306010800010708070300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
