Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12GJC53023596
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 11:19:13 -0500 (EST)
Subject: Re: New patch for fixfiles sed script
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4200DC75.1070009@redhat.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200DC75.1070009@redhat.com>
Content-Type: multipart/mixed; boundary="=-+EScflJPTmHICH7omwXd"
Message-Id: <1107360761.890.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 11:12:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+EScflJPTmHICH7omwXd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-02-02 at 08:58, Daniel J Walsh wrote:
> +	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
> +	sed -r -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
> +	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
> +               -e 's|\?.*|*|g' \
> +	       -e 's|\(.*|*|g' \
> +	       -e 's|\[.*|*|g' \
> +               -e 's|\.\*|*|g' \
> +               -e 's|\.\+|*|g' \
> +	sort -u | \
> +        while read pattern ; \
> +	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
> +                  echo "$pattern"; \
> +                  case "$pattern" in *"*") \
> +	               echo "$pattern" | sed 's,\*$,,g' >> ${TEMPFILE};;  
> +                  esac; \
> +               fi; \
> +            done | \
> +	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
>  	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
> -	${RESTORECON} $2 -v -f -R - 
> +	${RESTORECON} -R $2 -v -f - 
>  	rm -f ${TEMPFILE}
>  fi
>  }

I tried splitting this again and looking at the incremental diffs for
each stage of the pipeline as applied to a diff of two file_contexts
that differ on every line.  Notes:
1) You removed the s,[[:blank:]].*,,g sed substitution.  An oversight? 
Otherwise, you are left with the type field (e.g. --, -d) and context
fields on some lines that are ultimately fed to the find command,
yielding errors (but silenced by your redirection of stderr).

2) The find command can still produce entries that you filtered out
earlier (e.g. /home, /tmp) and can yield duplicate entries again due to
wildcard expansion at that point.  Filtering out entries that end in *
via the sed filters would help, as would moving the grep filter for
special directories to the end of the pipeline.

3) The filter to avoid overlaps doesn't seem correct, especially since
restorecon is being applied recursively; you want to see whether there
are any prefixes of the path already specified, not whether there is a
match of the path itself (e.g. /bin is subsumed by any prior / entry,
but a grep of /bin against a file containing / will fail).  I don't
think that this filter is serving any purpose presently.  

Also, restorecon won't currently cross filesystem boundaries (FTW_MOUNT
flag to nftw, inherited from the setfiles code), so doing this kind of
overlap filtering is a problem unless we change restorecon. Having
restorecon -R cross filesystem boundaries seems sensible for its usage,
whereas setfiles is oriented toward labeling specific filesystems, which
is why it only labels the ones you specify and doesn't cross boundaries.

The attached patch relative to yours makes changes along the lines
described above, and simply removes the overlap filter for now.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-+EScflJPTmHICH7omwXd
Content-Disposition: attachment; filename=policycoreutils-nsa.patch
Content-Type: text/x-patch; name=policycoreutils-nsa.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/restorecon/restorecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/restorecon/restorecon.c,v
retrieving revision 1.23
diff -u -p -r1.23 restorecon.c
--- policycoreutils/restorecon/restorecon.c	28 Jan 2005 20:05:41 -0000	1.23
+++ policycoreutils/restorecon/restorecon.c	2 Feb 2005 16:07:59 -0000
@@ -184,7 +184,7 @@ static int apply_spec(const char *file,
 void process(char *buf) {
       if (recurse) {
 	if (nftw
-	    (buf, apply_spec, 1024, FTW_PHYS | FTW_MOUNT)) {
+	    (buf, apply_spec, 1024, FTW_PHYS)) {
 	  fprintf(stderr,
 		  "%s:  error while labeling files under %s\n",
 		  progname, buf);
Index: policycoreutils/scripts/fixfiles
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/scripts/fixfiles,v
retrieving revision 1.17
diff -u -p -r1.17 fixfiles
--- policycoreutils/scripts/fixfiles	2 Feb 2005 14:49:40 -0000	1.17
+++ policycoreutils/scripts/fixfiles	2 Feb 2005 16:09:15 -0000
@@ -58,29 +58,20 @@ fi
 #
 diff_filecontext() {
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
-	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
-	test -z "$TEMPFILE" && exit
 	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
 	sed -r -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
 	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
+	       -e 's,[[:blank:]].*,,g' \
                -e 's|\?.*|*|g' \
 	       -e 's|\(.*|*|g' \
 	       -e 's|\[.*|*|g' \
                -e 's|\.\*|*|g' \
                -e 's|\.\+|*|g' \
+	       -e 's|\*$||g' | \
 	sort -u | \
-        while read pattern ; \
-	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
-                  echo "$pattern"; \
-                  case "$pattern" in *"*") \
-	               echo "$pattern" | sed 's,\*$,,g' >> ${TEMPFILE};;  
-                  esac; \
-               fi; \
-            done | \
-	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
-	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
-	${RESTORECON} -R $2 -v -f - 
-	rm -f ${TEMPFILE}
+ 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
+	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | 
+	xargs ${RESTORECON} -R $2 -v
 fi
 }
 #

--=-+EScflJPTmHICH7omwXd--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
