MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch] libsepol: clarify and reduce neverallow error reporting
Date: Mon, 3 Dec 2007 15:37:07 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455C6B@exchange.columbia.tresys.com>
In-Reply-To: <1196713777.27820.160.camel@moss-spartans.epoch.ncsc.mil>
References: <1196347937.24040.10.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B0158801455C66@exchange.columbia.tresys.com> <1196713777.27820.160.camel@moss-spartans.epoch.ncsc.mil>
From: "Brian M. Williams" <bwilliams@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>-----Original Message-----
>From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>Sent: Monday, December 03, 2007 3:30 PM
>To: Brian M. Williams
>Cc: selinux@tycho.nsa.gov; Daniel J Walsh; Joshua Brindle
>Subject: RE: [patch] libsepol: clarify and reduce neverallow error
reporting
>
>On Mon, 2007-12-03 at 15:29 -0500, Brian M. Williams wrote:
>> >-----Original Message-----
>> >From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov]
>> On Behalf Of Stephen Smalley
>> >Sent: Thursday, November 29, 2007 9:52 AM
>> >To: selinux@tycho.nsa.gov
>> >Cc: Daniel J Walsh; Joshua Brindle
>> >Subject: [patch] libsepol: clarify and reduce neverallow error
>> reporting
>> >
>> >Alter the error reporting for neverallow failures to be clearer,
i.e.
>> >use the word neverallow instead of assertion and don't report a line
>> number
>> >if we don't have that information, and bail on the first such error
>> rather
>> >than flooding the user with multiple ones, since any such error is
>> fatal.
>>
>> Bailing after the first neverallow will make it much harder to write
>> policy IMHO.  I have used neverallows in the past to define security
>> goals for custom systems and there be 20+ violations to the
neverallows
>> after I first define them.  Now I might have to compile the policy
20+
>> times in order to clean up each neverallow which can be a very time
>> consuming task.
>
>If you want to make it an option, feel free - but the default should
>remain to bail after the first failure IMHO.  Otherwise we commonly
>flood the user with a bunch of noise, often all related to the first
one
>(e.g. user forgot to mark a domain type with the domain attribute, so
>every allow rule on it triggers a neverallow failure).

Sounds good to me

>
>>
>> >
>> >Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>> >
>> >---
>> >
>> > libsepol/src/assertion.c |   47
>> ++++++++++++++++++++++++++++-------------------
>> > 1 file changed, 28 insertions(+), 19 deletions(-)
>> >
>> >Index: trunk/libsepol/src/assertion.c
>> >===================================================================
>> >--- trunk/libsepol/src/assertion.c	(revision 2690)
>> >+++ trunk/libsepol/src/assertion.c	(working copy)
>> >@@ -59,11 +59,21 @@
>> > 	return 0;
>> >
>> >       err:
>> >-	ERR(handle, "assertion on line %lu violated by allow %s %s:%s
>> {%s };",
>> >-	    line, p->p_type_val_to_name[stype],
>> p->p_type_val_to_name[ttype],
>> >-	    p->p_class_val_to_name[curperm->class - 1],
>> >-	    sepol_av_to_string(p, curperm->class,
>> >-			       node->datum.data & curperm->data));
>> >+	if (line) {
>> >+		ERR(handle, "neverallow on line %lu violated by allow %s
>> %s:%s {%s };",
>> >+		    line, p->p_type_val_to_name[stype],
>> >+		    p->p_type_val_to_name[ttype],
>> >+		    p->p_class_val_to_name[curperm->class - 1],
>> >+		    sepol_av_to_string(p, curperm->class,
>> >+				       node->datum.data &
>> curperm->data));
>> >+	} else {
>> >+		ERR(handle, "neverallow violated by allow %s %s:%s {%s
>> };",
>> >+		    p->p_type_val_to_name[stype],
>> >+		    p->p_type_val_to_name[ttype],
>> >+		    p->p_class_val_to_name[curperm->class - 1],
>> >+		    sepol_av_to_string(p, curperm->class,
>> >+				       node->datum.data &
>> curperm->data));
>> >+	}
>> > 	return -1;
>> > }
>> >
>> >@@ -74,7 +84,7 @@
>> > 	avtab_t te_avtab, te_cond_avtab;
>> > 	ebitmap_node_t *snode, *tnode;
>> > 	unsigned int i, j;
>> >-	int errors = 0;
>> >+	int rc;
>> >
>> > 	if (!avrules) {
>> > 		/* Since assertions are stored in avrules, if it is NULL
>> >@@ -111,32 +121,31 @@
>> > 			if (a->flags & RULE_SELF) {
>> > 				if (check_assertion_helper
>> > 				    (handle, p, &te_avtab,
>> &te_cond_avtab, i, i,
>> >-				     a->perms, a->line))
>> >-					errors++;
>> >+				     a->perms, a->line)) {
>> >+					rc = -1;
>> >+					goto out;
>> >+				}
>> > 			}
>> > 			ebitmap_for_each_bit(ttypes, tnode, j) {
>> > 				if (!ebitmap_node_get_bit(tnode, j))
>> > 					continue;
>> > 				if (check_assertion_helper
>> > 				    (handle, p, &te_avtab,
>> &te_cond_avtab, i, j,
>> >-				     a->perms, a->line))
>> >-					errors++;
>> >+				     a->perms, a->line)) {
>> >+					rc = -1;
>> >+					goto out;
>> >+				}
>> > 			}
>> > 		}
>> > 	}
>> >
>> >-	if (errors) {
>> >-		ERR(handle, "%d assertion violations occured", errors);
>> >-		avtab_destroy(&te_avtab);
>> >-		avtab_destroy(&te_cond_avtab);
>> >-		return -1;
>> >-	}
>> >-
>> >+	rc = 0;
>> >+out:
>> > 	avtab_destroy(&te_avtab);
>> > 	avtab_destroy(&te_cond_avtab);
>> >-	return 0;
>> >+	return rc;
>> >
>> >       oom:
>> >-	ERR(handle, "Out of memory - unable to check assertions");
>> >+	ERR(handle, "Out of memory - unable to check neverallows");
>> > 	return -1;
>> > }
>> >
>> >--
>> >Stephen Smalley
>> >National Security Agency
>> >
>> >
>> >--
>> >This message was distributed to subscribers of the selinux mailing
>> list.
>> >If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with
>> >the words "unsubscribe selinux" without quotes as the message.
>--
>Stephen Smalley
>National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
