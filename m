Date: Wed, 10 Aug 2005 16:32:26 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] fix use-after-free in matchpathcon.c
Message-ID: <20050810213226.GA7826@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Following is a set of patches against (potential) bugs found by
Coverity in libselinux.  Hopefully the rest of the selinux-usr
libraries will follow.  None of the selinux-usr ones looked
groundbreaking, whereas a quick peek at some later libraries
looked scarier.

All of these bugs seem to be on error paths, and the most inane
are resource leaks on error paths, but some look like they should
definately cause segvs.

This patch fixes a bug found in matchpathcon.c by Coverity:

	process_line() uses anchored_regex after freeing it if
	regcomp() fails.

thanks,
-serge

Index: src/matchpathcon.c
===================================================================
--- src.orig/matchpathcon.c
+++ src/matchpathcon.c
@@ -465,11 +465,12 @@ static int process_line( const char *pat
 			regcomp(&spec_arr[nspec].regex,
 				anchored_regex,
 				REG_EXTENDED | REG_NOSUB);
-		free(anchored_regex);
 		if (regerr < 0) {
 			myprintf("%s:  line %d has invalid regex %s\n", path, lineno, anchored_regex); 
+			free(anchored_regex);
 			return 0;
 		}
+		free(anchored_regex);
 		
 		/* Convert the type string to a mode format */
 		spec_arr[nspec].type_str = type;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
