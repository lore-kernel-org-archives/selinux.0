Message-ID: <451C20F5.9010802@trustedcs.com>
Date: Thu, 28 Sep 2006 14:22:29 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New Patch for Policycoreutils.
References: <451945DB.90209@redhat.com>
In-Reply-To: <451945DB.90209@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I have updated the patch to remove some of the objectionable changes.
> 
> Includes Change submitted on the list for checking if policy loaded in 
> avc.py
> 
> -i flag to tell restorecon to ignore missing files
> 
> -o now takes "-" to allow it to output file list to stdout
> 
> Check to make sure restorecon has at least one input file
> 
> Build restorecond with -fPIE
> 
> fixfiles use "-i" with restorecon, added new command verify to check all 
> files and output only the files with wrong context
> 
> seobject needs to have oldserange initialized.
> 
> 
> ------------------------------------------------------------------------
> 

<snip>

> diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.30.29/restorecon/restorecon.c
> --- nsapolicycoreutils/restorecon/restorecon.c	2006-09-01 22:32:11.000000000 -0400
> +++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-26 11:06:37.000000000 -0400
> @@ -11,9 +11,10 @@
>   * restorecon [-Rnv] pathname...
>   * 
>   * -e   Specify directory to exclude
> + * -i   Ignore error if file does not exist
>   * -n	Do not change any file labels.
>   * -v	Show changes in file labels.  
> - * -o filename save list of files with incorrect context
> + * -o	filename save list of files with incorrect context
>   * -F	Force reset of context to match file_context for customizable files
>   *
>   * pathname...	The file(s) to label 
> @@ -47,6 +48,7 @@
>  static char *progname;
>  static int errors = 0;
>  static int recurse = 0;
> +static int file_exist = 1;
>  static int force = 0;
>  #define STAT_BLOCK_SIZE 1
>  static int pipe_fds[2] = { -1, -1 };
> @@ -62,6 +64,7 @@
>  static int add_exclude(const char *directory)
>  {
>  	struct stat sb;
> +	int len=0;
>  	if (directory == NULL || directory[0] != '/') {
>  		fprintf(stderr, "Full path required for exclude: %s.\n",
>  			directory);
> @@ -85,12 +88,18 @@
>  		return 1;
>  	}
>  
> -	excludeArray[excludeCtr].directory = strdup(directory);
> +	len = strlen(directory);
> +	if (len > 1 &&  directory[len-1] == '/') {
> +		excludeArray[excludeCtr].directory = calloc(1,len--);
> +		strncpy(excludeArray[excludeCtr].directory, directory, len);
> +	} else
> +		excludeArray[excludeCtr].directory = strdup(directory);
> +
>  	if (!excludeArray[excludeCtr].directory) {
>  		fprintf(stderr, "Out of memory.\n");
>  		return 1;
>  	}
> -	excludeArray[excludeCtr++].size = strlen(directory);
> +	excludeArray[excludeCtr++].size = len;
>  
>  	return 0;
>  }

The above will only strip off one trailing '/',  a path such as "/tmp/stuf/////"
will still end up as "/tmp/stuff////".  There is also no need to do the calloc and
strncpy - the strdup will do just fine because size refers only to the number of
valid characters, not the actual size of the allocation.  How 'bout something along
these lines:

	len = strlen(directory);
	while (len > 1 && excludeArray[excludeCtr].directory[len - 1] == '/')
		len--;
	excludeArray[excludeCtr++].size = len;

Even if you wanted to go with the sized-to-fit allocation, I would recommend the
while loop on the trailing slashes.

<snip>

> diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30.29/scripts/fixfiles
> --- nsapolicycoreutils/scripts/fixfiles	2006-09-01 22:32:11.000000000 -0400
> +++ policycoreutils-1.30.29/scripts/fixfiles	2006-09-26 11:16:51.000000000 -0400
> @@ -117,8 +117,8 @@
>      exit $?
>  fi
>  if [ ! -z "$RPMFILES" ]; then
> -    for i in `echo $RPMFILES | sed 's/,/ /g'`; do
> -	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* -f - 2>&1 >> $LOGFILE
> +    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
> +	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -i -f - 2>&1 >> $LOGFILE
>      done
>      exit $?
>  fi

Was dropping -R intentional?  I didn't see a reference to that in the description.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
