Message-ID: <43F24C42.1010407@cornell.edu>
Date: Tue, 14 Feb 2006 16:31:46 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: [SEPOL] Nodes, Ports: always prepend
Content-Type: multipart/mixed;
 boundary="------------090209040601080304040307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090209040601080304040307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The current algorithm for modifcation of nodes and ports is:
- look for an exact match, if one is found, replace
- otherwise prepend to ocontext list.

This approach can (and will) cause problems if ordering is significant 
for the modify() requests.
Two overlapping port ranges or network nodes, one that overrides policy, 
and one that is new, added in the wrong order can be caused to shadow 
each other. This can happen regardless of what order they were added in 
- either request can have a match within policy, and be pushed behind 
the other one, invalidating the ordering.

This will be an issue for ordering, so change the algorithm to always 
prefix there.
For ports, we've banned overlapping port ranges from libsemanage, so 
this isn't an issue. However, with respect to libsepol this is an 
unnecessary limitation, so this patch also changes the algorithm to 
always prefix ports as well, which will allow an addition of an ordered 
set of ports, if the caller requires that.
====================================
Dan, as a side effect, you will now see duplicate ports in the semanage 
tool when a user modifies an existing policy port. Previously this only 
happened when a user modified a range, but an inexact match happened 
(i.e. user modified 80 from 1-1023, or user modified 60-70 from 65-80).

The correct solution for this involves a two-stage display of local 
modifications, and policy separately, with the assistance of system() 
databases - I'll send an email about this soon.


--------------090209040601080304040307
Content-Type: text/x-patch;
 name="libsepol.nodes_ports_always_prepend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.nodes_ports_always_prepend.diff"

diff -Naurp --exclude-from excludes old/libsepol/src/nodes.c new/libsepol/src/nodes.c
--- old/libsepol/src/nodes.c	2006-02-14 13:48:09.000000000 -0500
+++ new/libsepol/src/nodes.c	2006-02-14 16:13:19.000000000 -0500
@@ -314,28 +314,6 @@ int sepol_node_modify(
 
 		case SEPOL_PROTO_IP4:
 		{
-			head = policydb->ocontexts[OCON_NODE];
-			for (c = head; c; c = c->next) {
-				unsigned int* addr2 = &c->u.node.addr;
-				unsigned int* mask2 = &c->u.node.mask;
-	
-				if (!memcmp(addr, addr2, 4) &&
-				    !memcmp(mask, mask2, 4)) {
-	
-					/* Replace */
-					node->next = c->next;
-					if (prev == NULL) 
-						policydb->ocontexts[OCON_NODE] = node;
-					else
-						prev->next = node;
-
-					context_destroy(&c->context[0]);
-					free(c);
-					return STATUS_SUCCESS;
-				}
-				prev = c;
-			}
-
 			/* Attach to context list */
 			node->next = policydb->ocontexts[OCON_NODE];
 			policydb->ocontexts[OCON_NODE] = node;
@@ -343,29 +321,6 @@ int sepol_node_modify(
 		}
 		case SEPOL_PROTO_IP6:
 		{
-			head = policydb->ocontexts[OCON_NODE6];
-			for (c = head; c; c = c->next) {
-				unsigned int* addr2 = c->u.node6.addr;
-				unsigned int* mask2 = c->u.node6.mask;
-
-				if (!memcmp(addr, addr2, 16) &&
-				    !memcmp(mask, mask2, 16)) {
-
-					/* Replace */
-					node->next = c->next;
-					if (prev == NULL) 
-						policydb->ocontexts[OCON_NODE6] = node;
-					else
-						prev->next = node;
-
-					context_destroy(&c->context[0]);
-					free(c);
-
-					return STATUS_SUCCESS;
-				}
-				prev = c;
-			}
-
 			/* Attach to context list */
 			node->next = policydb->ocontexts[OCON_NODE6];
 			policydb->ocontexts[OCON_NODE6] = node;
diff -Naurp --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2006-02-14 13:48:09.000000000 -0500
+++ new/libsepol/src/ports.c	2006-02-14 16:18:57.000000000 -0500
@@ -267,28 +267,6 @@ int sepol_port_modify(
 	if (port_from_record(handle, policydb, &port, data) < 0)
 		goto err;
 
-	head = policydb->ocontexts[OCON_PORT];
-	for (c = head; c; c = c->next) {
-		int proto2 = c->u.port.protocol;
-		int low2 = c->u.port.low_port;
-		int high2 = c->u.port.high_port;
-
-		if (proto == proto2 && low2 == low && high2 == high) {
-
-			/* Replace */
-			port->next = c->next;
-			if (prev == NULL)
-				policydb->ocontexts[OCON_PORT] = port;
-			else
-				prev->next = port;
-			context_destroy(&c->context[0]);
-			free(c);
-
-			return STATUS_SUCCESS;
-		}
-		prev = c;
-	}
-
 	/* Attach to context list */
 	port->next = policydb->ocontexts[OCON_PORT];
 	policydb->ocontexts[OCON_PORT] = port;

--------------090209040601080304040307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
