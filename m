Subject: Re: matchpathcon regcomp return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Johan Fischer <jfischer@cmcrc.com>
Cc: SELinux-dev@tresys.com, "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-3i6G/7U3jKfqvVwhclRZ"
Date: Wed, 05 Oct 2005 12:17:15 -0400
Message-Id: <1128529035.24059.204.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3i6G/7U3jKfqvVwhclRZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-10-05 at 09:19 -0400, Stephen Smalley wrote:
> On Wed, 2005-10-05 at 16:14 +1000, Johan Fischer wrote:
> > Now the problem is restorecon is crashing (segfault in matchpathcon)
> > 
> > About the crashing, it seems that the error code check of regcomp in
> > matchpathcon.c is wrong (see attached patch from CVS HEAD).
> 
> Ah, thanks for the bug fix.  Should likely also call regerror there and
> report that error string.

I merged the patch below into libselinux 1.27.4.  Includes your change
plus use of regerror.

With regard to the original problem, I think you just have to put both
pathname regexes (the top-level /var/lib/svn one and the lost+found one)
into apache.fc with the desired ordering explicit for now.  We are
looking into ways to address the general ordering issues in the future,
including the sort algorithm mentioned earlier and an optional explicit
ordering/predecence value field in the .fc entries.

-- 
Stephen Smalley
National Security Agency

--=-3i6G/7U3jKfqvVwhclRZ
Content-Disposition: attachment; filename=libselinux-1.27.4.patch
Content-Type: text/x-patch; name=libselinux-1.27.4.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/ChangeLog,v
retrieving revision 1.145
retrieving revision 1.146
diff -u -p -r1.145 -r1.146
--- libselinux/ChangeLog	3 Oct 2005 17:06:16 -0000	1.145
+++ libselinux/ChangeLog	5 Oct 2005 15:48:05 -0000	1.146
@@ -1,3 +1,8 @@
+1.27.4 2005-10-05
+	* Merged fix for matchpathcon (regcomp error checking) from Johan
+	Fischer.  Also added use of regerror to obtain the error string
+	for inclusion in the error message.
+
 1.27.3 2005-10-03
 	* Changed getseuserbyname to not require (and ignore if present)
 	the MLS level in seusers.conf if MLS is disabled, setting *level
Index: libselinux/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/VERSION,v
retrieving revision 1.63
retrieving revision 1.64
diff -u -p -r1.63 -r1.64
--- libselinux/VERSION	3 Oct 2005 17:06:16 -0000	1.63
+++ libselinux/VERSION	5 Oct 2005 15:48:05 -0000	1.64
@@ -1 +1 @@
-1.27.3
+1.27.4
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.30
retrieving revision 1.31
diff -u -p -r1.30 -r1.31
--- libselinux/src/matchpathcon.c	30 Sep 2005 18:27:18 -0000	1.30
+++ libselinux/src/matchpathcon.c	5 Oct 2005 15:48:05 -0000	1.31
@@ -501,8 +501,18 @@ static int process_line( const char *pat
 			regcomp(&spec_arr[nspec].regex,
 				anchored_regex,
 				REG_EXTENDED | REG_NOSUB);
-		if (regerr < 0) {
-			myprintf("%s:  line %d has invalid regex %s\n", path, lineno, anchored_regex); 
+		if (regerr != 0) {
+			size_t errsz = 0;
+			char *errbuf = NULL;
+			errsz = regerror(regerr, &spec_arr[nspec].regex, 
+					 errbuf, errsz);
+			if (errsz)
+				errbuf = malloc(errsz);
+			if (errbuf)
+				(void) regerror(regerr, 
+						&spec_arr[nspec].regex, 
+						errbuf, errsz);
+			myprintf("%s:  line %d has invalid regex %s:  %s\n", path, lineno, anchored_regex, (errbuf ? errbuf : "out of memory")); 
 			free(anchored_regex);
 			return 0;
 		}

--=-3i6G/7U3jKfqvVwhclRZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
