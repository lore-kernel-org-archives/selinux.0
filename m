Subject: Re: [ SEPOL ] Extract user records from binary policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <4334E4C8.8050206@cornell.edu>
References: <4334E273.9070703@cornell.edu>  <4334E4C8.8050206@cornell.edu>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 15:19:02 -0400
Message-Id: <1127762342.19016.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-09-24 at 01:31 -0400, Ivan Gyurdiev wrote:
> ...and here's the same patch, with the obvious malloc bug fixed...tsk

diff -Nrua libsepol.new/src/users.c libsepol/src/users.c
--- libsepol.new/src/users.c	2005-09-21 10:42:24.000000000 -0400
+++ libsepol/src/users.c	2005-09-24 01:28:27.000000000 -0400
+		/* Extract MLS info */
+		if (mls_enabled) {
+			context_struct_t context;
+			char *str;
+			int len;
+
+			context_init(&context);
+			memcpy(&context.range.level[0], 
+				&usrdatum->dfltlevel, sizeof(mls_level_t));
+			memcpy(&context.range.level[1],
+				&usrdatum->dfltlevel, sizeof(mls_level_t));	
+			len = mls_compute_context_len(policydb, &context);
+			str = (char*) malloc(len);
+			if (str == NULL)
+				goto omem;
+			mls_sid_to_context(policydb, &context, &str);				
+			str -= len;
+			
+			if ( sepol_user_set_mlslevel(tmp_users[i], str + 1) < 0 ) {
+				free(str);
+				goto err;
+			}
+			free(str);			
+
+			context_init(&context);
+			memcpy(&context.range, &usrdatum->range, sizeof(mls_range_t));
+			len = mls_compute_context_len(policydb, &context);
+			str = (char*) malloc(len);
+			if (str == NULL)
+				goto omem;
+			mls_sid_to_context(policydb, &context, &str);
+			str -= len;
+	
+			if ( sepol_user_set_mlsrange(tmp_users[i], str + 1) < 0) {
+				free(str);
+				goto err;
+			}
+			free(str);
+		}
 	}

I understand that you are trying to just re-use the existing mls_
functions here, but I think it would be better to alter them or add new
ones that provide a saner interface for this kind of manipulation.  In
particular, the manipulation of str above makes me nervous, even if it
is technically correct.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
