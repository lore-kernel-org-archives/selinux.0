Subject: Re: patch to setfiles/fixfiles to handle file names with special
	characters in them.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, benny+bugzilla@amorsen.dk
In-Reply-To: <4797C270.9000202@redhat.com>
References: <4797C270.9000202@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 14:31:44 -0500
Message-Id: <1201203104.21288.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-23 at 17:40 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Benny Amorsen Provided the patch added -0 option.
> 
> Also added support to fixfiles for ext4 ext4dev and gfs2
> 
> Fixes quoting in fixfiles also.
> 
> Cleaned up description in man page.

Thanks, merged as of policycoreutils 2.0.38.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkeXwm8ACgkQrlYvE4MpobPTHgCfXoMY6qmBuOSBPXcCszFpkRfA
> WuoAn1Dw9NWg1gUJmZbyPF1IoXdyuL7D
> =pglo
> -----END PGP SIGNATURE-----
> plain text document attachment (fixfiles.patch)
> --- nsapolicycoreutils/scripts/fixfiles	2008-01-23 14:36:28.000000000 -0500
> +++ policycoreutils-2.0.37/scripts/fixfiles	2008-01-23 17:13:45.000000000 -0500
> @@ -36,8 +36,8 @@
>  LOGGER=/usr/sbin/logger
>  SETFILES=/sbin/setfiles
>  RESTORECON=/sbin/restorecon
> -FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | jfs ).*\(rw/{print $3}';`
> -FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | jfs ).*\(ro/{print $3}';`
> +FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs ).*\(rw/{print $3}';`
> +FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs ).*\(ro/{print $3}';`
>  FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
>  SELINUXTYPE="targeted"
>  if [ -e /etc/selinux/config ]; then
> @@ -88,11 +88,11 @@
>                    esac; \
>                 fi; \
>              done | \
> -	while read pattern ; do sh -c "find $pattern" \
> -		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o \
> -		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print; \
> +	while read pattern ; do sh -c "find $pattern \
> +		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs \) -prune  -o \
> +		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print0"; \
>  		      done 2> /dev/null | \
> -	 ${RESTORECON} $2 -f - 
> +	 ${RESTORECON} $2 -0 -f - 
>  	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
>  fi
>  }
> @@ -129,8 +129,8 @@
>  if [ ! -z "$FILEPATH" ]; then
>      if [ -x /usr/bin/find ]; then
>  	/usr/bin/find "$FILEPATH" \
> -	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o -print | \
> -	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -f - 2>&1 >> $LOGFILE
> +	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs \) -prune  -o -print0 | \
> +	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
>      else
>  	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
>      fi
> --- nsapolicycoreutils/scripts/fixfiles.8	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.37/scripts/fixfiles.8	2008-01-23 17:13:45.000000000 -0500
> @@ -35,7 +35,7 @@
>  
>  .TP 
>  .B -f
> -Don't prompt for removal of /tmp directory.
> +Clear /tmp directory with out prompt for removal.
>  
>  .TP 
>  .B -R rpmpackagename[,rpmpackagename...]
> --- nsapolicycoreutils/setfiles/setfiles.8	2007-07-16 14:20:43.000000000 -0400
> +++ policycoreutils-2.0.37/setfiles/setfiles.8	2008-01-23 17:13:45.000000000 -0500
> @@ -59,6 +59,9 @@
>  .TP 
>  .B \-W
>  display warnings about entries that had no matching files.
> +.TP 
> +.B \-0
> +Input items are terminated by a null character instead of by whitespace,  and the quotes and backslash are not special (every character is taken literally).  Disables the end of file string, which  is  treated  like  any other argument.  Useful when input items might contain white space, quote  marks,  or  backslashes.The  GNU  find  -print0  option produces input suitable for this mode.
>  
>  .SH "ARGUMENTS"
>  .B spec_file
> --- nsapolicycoreutils/setfiles/setfiles.c	2008-01-11 10:52:37.000000000 -0500
> +++ policycoreutils-2.0.37/setfiles/setfiles.c	2008-01-23 17:13:45.000000000 -0500
> @@ -55,6 +55,7 @@
>  static int verbose = 0;
>  static int logging = 0;
>  static int warn_no_match = 0;
> +static int null_terminated = 0;
>  static char *rootpath = NULL;
>  static int rootpathlen = 0;
>  static int recurse; /* Recursive descent. */
> @@ -384,7 +385,7 @@
>  {
>  	if (iamrestorecon) {
>  		fprintf(stderr,
> -			"usage:  %s [-iFnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
> +			"usage:  %s [-iFnrRv0] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
>  			name);
>  	} else {
>  		fprintf(stderr,
> @@ -805,7 +806,7 @@
>  	}
>  
>  	/* Process any options. */
> -	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW")) > 0) {
> +	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
>  		switch (opt) {
>  		case 'c':
>  			{
> @@ -927,6 +928,9 @@
>  		case 'W':
>  			warn_no_match = 1;
>  			break;
> +		case '0':
> +			null_terminated = 1;
> +			break;
>  		case '?':
>  			usage(argv[0]);
>  		}
> @@ -983,6 +987,7 @@
>  	if (use_input_file) {
>  		FILE *f = stdin;
>  		ssize_t len;
> +		int delim;
>  		if (strcmp(input_filename, "-") != 0)
>  			f = fopen(input_filename, "r");
>  		if (f == NULL) {
> @@ -991,7 +996,9 @@
>  			usage(argv[0]);
>  		}
>  		__fsetlocking(f, FSETLOCKING_BYCALLER);
> -		while ((len = getline(&buf, &buf_len, f)) > 0) {
> +
> +		delim = (null_terminated != 0) ? '\0' : '\n';
> +		while ((len = getdelim(&buf, &buf_len, delim, f)) > 0) {
>  			buf[len - 1] = 0;
>  			errors |= process_one(buf);
>  		}
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
