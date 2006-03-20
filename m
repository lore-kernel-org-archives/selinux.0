Subject: Re: Changes to policycoreutils.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, Russell Coker <russell@coker.com.au>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <441B2C7B.7050307@redhat.com>
References: <441B2C7B.7050307@redhat.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 15:11:01 -0500
Message-Id: <1142885461.16487.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-17 at 16:39 -0500, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.c policycoreutils-1.30/restorecond/restorecond.c
> --- nsapolicycoreutils/restorecond/restorecond.c	1969-12-31 19:00:00.000000000 -0500
> +++ policycoreutils-1.30/restorecond/restorecond.c	2006-03-17 15:43:36.000000000 -0500
> +	if (S_ISLNK(st.st_mode)) {

For the daemon, I don't think you want this symlink realpath logic
inherited from restorecon.  The admin should just specify the real path
in the config file unless he wants the symlink itself to be restored.

> +	retcontext=lgetfilecon(filename,&prev_context);
> +	
> +	if (retcontext >= 0 || errno == ENODATA) {
<snip>
> +			if (lsetfilecon(filename,scontext) < 0) {

Need to counter the risks I noted earlier for files in user-writable
directories.  There is both a DAC concern (user should only be able to
relabel files he owns) and a MAC concern here (user should only be able
to relabel files to which he has suitable permission), and the inode
referenced by filename can change between these two calls.

> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30/scripts/fixfiles
> --- nsapolicycoreutils/scripts/fixfiles	2006-01-04 13:07:46.000000000 -0500
> +++ policycoreutils-1.30/scripts/fixfiles	2006-03-17 16:26:25.000000000 -0500
> @@ -124,7 +124,15 @@
>      exit $?
>  fi
>  if [ ! -z "$DIRS" ]; then
> -    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $1 -v $DIRS 2>&1 >> $LOGFILE
> +    if [ -x /usr/bin/find ]; then
> +	for d in ${DIRS} ; do find $d \
> +	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o -print; \
> +	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $1 -v -f - 2>&1 >> $LOGFILE
> +	done

Am I reading this incorrectly, or does the find command just generate
output to the stdout stream above, not piped into restorecon?  I think I
saw this diff earlier and dropped it because it doesn't work.

> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.30/semanage/seobject.py
> --- nsapolicycoreutils/semanage/seobject.py	2006-03-10 09:48:05.000000000 -0500
> +++ policycoreutils-1.30/semanage/seobject.py	2006-03-17 15:37:21.000000000 -0500
> @@ -229,10 +229,9 @@
>  			if rc < 0:
>  				raise ValueError("Could not set name for %s" % name)
>  
> -			if serange != "":
> -				rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
> -				if rc < 0:
> -					raise ValueError("Could not set MLS range for %s" % name)
> +			rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
> +			if rc < 0:
> +				raise ValueError("Could not set MLS range for %s" % name)

This looks like a reversion of a change I made to get semanage working
on non-MLS/MCS systems - calling semanage_seuser_set_mlsrange with an
empty string yields trouble later.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
