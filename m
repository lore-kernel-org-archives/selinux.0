Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12GnB53023941
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 11:49:11 -0500 (EST)
Subject: Re: New patch for fixfiles sed script
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4201012F.6040604@redhat.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200DC75.1070009@redhat.com>
	 <1107360761.890.234.camel@moss-spartans.epoch.ncsc.mil>
	 <4201012F.6040604@redhat.com>
Content-Type: text/plain
Message-Id: <1107362559.890.247.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 11:42:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-02 at 11:34, Daniel J Walsh wrote:
> Yes because you are reading it wrong.  It is doing a grep "/" in "/bin".
> 
> Basically the stuff in the TMPFILE are all the ones we will be 
> restoreing.  So
> 
> echo "/bin" | grep -q -f TEMPFILE will succeed if / is in TEMPFILE

Ah, my mistake.  This patch relative to yours (not mine) just restores
the blank filter, fixes a missing pipe, and moves the tmp filter after
the find, leaving everything else unchanged.

Index: policycoreutils/scripts/fixfiles
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/scripts/fixfiles,v
retrieving revision 1.17
diff -u -r1.17 fixfiles
--- policycoreutils/scripts/fixfiles	2 Feb 2005 14:49:40 -0000	1.17
+++ policycoreutils/scripts/fixfiles	2 Feb 2005 16:40:37 -0000
@@ -63,11 +63,12 @@
 	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
 	sed -r -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
 	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
+	       -e 's,[[:blank:]].*,,g' \
                -e 's|\?.*|*|g' \
 	       -e 's|\(.*|*|g' \
 	       -e 's|\[.*|*|g' \
                -e 's|\.\*|*|g' \
-               -e 's|\.\+|*|g' \
+               -e 's|\.\+|*|g' |
 	sort -u | \
         while read pattern ; \
 	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
@@ -77,8 +78,8 @@
                   esac; \
                fi; \
             done | \
-	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
+	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
 	${RESTORECON} -R $2 -v -f - 
 	rm -f ${TEMPFILE}
 fi

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
