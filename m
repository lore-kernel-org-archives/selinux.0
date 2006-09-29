Message-ID: <451D3116.7030109@redhat.com>
Date: Fri, 29 Sep 2006 10:43:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Karl MacMillan <kmacmill@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: libsemanage patch to handle installation problem
References: <451BEFA4.60507@redhat.com>	 <1159463932.11489.44.camel@moss-spartans.epoch.ncsc.mil>	 <1159464256.11489.48.camel@moss-spartans.epoch.ncsc.mil>	 <451C0C79.4000105@redhat.com>	 <1159537518.29474.6.camel@twoface.columbia.tresys.com> <1159538012.8496.35.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159538012.8496.35.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030409040500030005020701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030409040500030005020701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

During install if selinux-policy-mls or selinux-policy-strict get 
installed before targeted, libsemanage will
try to load those policies when it should not.

Dan


--------------030409040500030005020701
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

--- libsemanage-1.6.16/src/semanage_store.c~	2006-08-23 13:57:48.000000000 -0400
+++ libsemanage-1.6.16/src/semanage_store.c	2006-09-29 10:41:08.000000000 -0400
@@ -1106,6 +1106,10 @@
 			goto skip_reload;
 		}
 	}
+	else 
+		if (errno == ENOENT && 
+		    strcmp(really_active_store, storepath) != 0)
+			goto skip_reload;
 
 	if (semanage_reload_policy(sh)) {
 		goto cleanup;

--------------030409040500030005020701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
