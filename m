Subject: Re: Patch to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41FA6861.6080505@redhat.com>
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA6861.6080505@redhat.com>
Content-Type: text/plain
Message-Id: <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 28 Jan 2005 14:51:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-28 at 11:29, Daniel J Walsh wrote:
> Added new fixfiles -C PREVIOUS_FILECONTEXT  (RESTORE | CHECK)
> 
> Which will take an old version of the file_context file and the 
> currently installed one and do a
> diff.  Then it will run a recursive restorecon on all files covered by 
> the difference.  The idea here
> is to potentially call this function from within policy spec files on 
> updates.  So the if the file_context
> file changes on update, the file context on disk will be updated.

Interesting idea, although textual diffs of file_contexts may not be
adequate.

> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.5/scripts/fixfiles
> --- nsapolicycoreutils/scripts/fixfiles	2005-01-26 11:30:57.000000000 -0500
> +++ policycoreutils-1.21.5/scripts/fixfiles	2005-01-28 11:16:21.000000000 -0500
> @@ -37,10 +37,12 @@
>  SELINUXTYPE="targeted"
>  if [ -e /etc/selinux/config ]; then
>      . /etc/selinux/config
> +    FILE_CONTEXT=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
>      FC=`mktemp /etc/selinux/${SELINUXTYPE}/contexts/files/file_context.XXXXXX`
> -    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null
> +    cat ${FILE_CONTEXT} ${FILE_CONTEXT}.local > $FC 2> /dev/null
>  else
> -    FC=/etc/security/selinux/file_contexts
> +    FILE_CONTEXT=/etc/security/selinux/file_contexts
> +    FC=${FILE_CONTEXT}
>  fi

We no longer need to have fixfiles deal with file_contexts.local with
the latest version of setfiles, since setfiles is now using matchpathcon
and matchpathcon will internally check it as well.

> +#
> +# Compare PREVious File Context to currently installed File Context and 
> +# run restorecon on all files affected by the differences.
> +#
> +diff_filecontext() {
> +if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> +	TEMPFILE=`mktemp /var/tmp/${SELINUXTYPE}.XXXXXXXXXX`
> +	test -z "$TEMPFILE" && exit
> +	/usr/bin/diff $PREFC $FILE_CONTEXT | egrep '^[<>]'|cut -c3-| grep ^/ | \
> +        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
> +            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
> +        while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
> +	while read pattern ; do find $pattern -print; done 2> /dev/null | \
> +	${RESTORECON} $2 -v -f - 
> +	rm -f ${TEMPFILE}
> +fi
> +}

Hmmm...I'm a bit concerned about the correctness and robustness of this
filter pipeline, as well as with the notion of feeding restorecon from a
temporary file.  Can you explain the stages in the filter pipeline a
bit?  I think it would be preferable to make the temporary file in a
directory with the same protections as the file_contexts configuration
(i.e. /etc/selinux/${SELINUXTYPE}/contexts/files).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
