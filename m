Date: Mon, 21 Jul 2008 02:50:20 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: [patch] SELinux: trivial, remove unneeded local variable
Message-ID: <Pine.LNX.4.64L.0807210244480.8743@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Remove unneeded local variable:

    struct avtab_node *newnode

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

---

 security/selinux/ss/avtab.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)



--- security-testing-2.6/security/selinux/ss/avtab.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk2/security/selinux/ss/avtab.c	2008-07-21 02:40:36.000000000 +0300
@@ -98,7 +98,7 @@ struct avtab_node *
 avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
 {
 	int hvalue;
-	struct avtab_node *prev, *cur, *newnode;
+	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);

 	if (!h || !h->htable)
@@ -122,9 +122,7 @@ avtab_insert_nonunique(struct avtab *h,
 		    key->target_class < cur->key.target_class)
 			break;
 	}
-	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
-
-	return newnode;
+	return avtab_insert_node(h, hvalue, prev, cur, key, datum);
 }

 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
