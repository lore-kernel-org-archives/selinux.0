Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4QFZKRb026632
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 11:35:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4QFZJAR023704
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 15:35:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4QFZIHn023701 for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 15:35:18 GMT
Subject: Re: X policy classes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Joshua Brindle <jbrindle@snu.edu>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Eamon Walsh <ewalsh@epoch.ncsc.mil>
In-Reply-To: <1084561713.18592.64.camel@moss-spartans.epoch.ncsc.mil>
References: <40A464EB.5030008@snu.edu>
	 <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
	 <40A5014A.9060400@snu.edu>
	 <1084556829.18592.5.camel@moss-spartans.epoch.ncsc.mil>
	 <1084561241.7518.222.camel@gorn.pebenito.net>
	 <1084561713.18592.64.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-cIweQDonB2/OhLhFcwTg"
Message-Id: <1085585699.31854.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 May 2004 11:35:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cIweQDonB2/OhLhFcwTg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-05-14 at 15:08, Stephen Smalley wrote:
> If you look at the diffs, you should see that it is just an ordering
> issue, not a change in actual values.  The current scripts are just
> walking a hash and emitting the definitions, so the order isn't
> guaranteed to be stable.  Someone should likely change the scripts to
> avoid spurious diffs.

I think that this patch will ensure a stable order for the
av_permissions.h definitions.  Naturally, it will yield a large diff for
the first time we regenerate headers using it, but subsequent
regeneration will hopefully have smaller diffs.  Look sane?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-cIweQDonB2/OhLhFcwTg
Content-Disposition: attachment; filename=flask-sort.patch
Content-Type: text/x-patch; name=flask-sort.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/flask/mkaccess_vector.sh
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/mkaccess_vector.sh,v
retrieving revision 1.4
diff -u -r1.4 mkaccess_vector.sh
--- policy/flask/mkaccess_vector.sh	17 Jul 2003 11:44:34 -0000	1.4
+++ policy/flask/mkaccess_vector.sh	26 May 2004 15:30:40 -0000
@@ -123,17 +123,30 @@
 				split(combined,separate, SUBSEP);
 				if (separate[1] == inherits)
 				{
-					printf("#define %s__%s", toupper(tclass), toupper(separate[2])) > outfile; 
-					spaces = 40 - (length(separate[2]) + length(tclass));
-					if (spaces < 1)
-					      spaces = 1;
-					for (i = 0; i < spaces; i++) 
-						printf(" ") > outfile; 
-					printf("0x%08xUL\n", common_perms[combined]) > outfile; 
+					inherited_perms[common_perms[combined]] = separate[2];
 				}
 			}
+
+                        j = 1;
+                        for (i in inherited_perms) {
+                            ind[j] = i + 0;
+                            j++;
+                        }
+                        n = asort(ind);
+			for (i = 1; i <= n; i++) {
+				perm = inherited_perms[ind[i]];
+				printf("#define %s__%s", toupper(tclass), toupper(perm)) > outfile; 
+				spaces = 40 - (length(perm) + length(tclass));
+				if (spaces < 1)
+				      spaces = 1;
+				for (j = 0; j < spaces; j++) 
+					printf(" ") > outfile; 
+				printf("0x%08xUL\n", ind[i]) > outfile; 
+			}
 			printf("\n") > outfile;
-	
+                        for (i in ind) delete ind[i];
+                        for (i in inherited_perms) delete inherited_perms[i];
+
 			printf("   { SECCLASS_%s, common_%s_perm_to_string, 0x%08xUL },\n", toupper(tclass), inherits, permission) > inheritfile; 
 
 			nextstate = "CLASS_OR_CLASS-OPENBRACKET";

--=-cIweQDonB2/OhLhFcwTg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
