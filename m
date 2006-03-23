Subject: Re: [RFC][PATCH] extending the libsepol API
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, Selinux-Dev <selinux-dev@tresys.com>
In-Reply-To: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
References: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 15:41:22 -0500
Message-Id: <1143146482.28120.439.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-21 at 17:46 -0500, Kevin Carr wrote:
> To make our changes we have been working on some API additions for libsepol.
> The attached diff adds some header files that represent how we plan to
> export a new shared API for accessing types/attribs.  The patch is the first
> of many aimed at fleshing out the shared API.  The diff contains just the
> headers as we would like to get some feedback from the community at this
> point.
> 
> The patch adds two files: "include/iterator.h" and "include/type_query.h".  

Aside from concerns about not introducing an orthogonal set of APIs into
libsepol, other comments:

diff -purN --exclude=.svn trunk/libsepol/include/sepol/type_query.h branch/setools_export-types/libsepol/include/sepol/type_query.h
--- trunk/libsepol/include/sepol/type_query.h	1969-12-31 19:00:00.000000000 -0500
+++ branch/setools_export-types/libsepol/include/sepol/type_query.h	2006-03-12 04:31:39.000000000 -0500
@@ -0,0 +1,159 @@
<snip>
+#include <stddef.h>
+#include <stdint.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/iterator.h>
+
+typedef struct sepol_type_datum sepol_type_datum_t;

Just struct sepol_type / sepol_type_t would seem sufficient.
datum doesn't add anything here; an unfortunate choice in the internal
headers that we don't to export to the stable interface.

+extern int sepol_policydb_get_type_by_name(sepol_handle_t *handle, sepol_policydb_t *policy, const char *name, sepol_type_datum_t **datum);

Rather verbose.  How about sepol_type_query() instead, like the existing
APIs.  And mark the policydb arguments as const for the read-only
interfaces.

+extern int sepol_type_datum_get_value(sepol_handle_t *handle, sepol_policydb_t *policy, sepol_type_datum_t *datum, uint32_t *value);

Likewise => sepol_type_get_value().  Ditto for other interfaces.

+extern int sepol_type_datum_get_name(sepol_handle_t *handle, sepol_policydb_t *policy, sepol_type_datum_t *datum, char **name);

Seems strange to query the datum for the name.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
