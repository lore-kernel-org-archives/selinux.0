Subject: Re: Patch to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41FE7DB2.1000101@redhat.com>
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA6861.6080505@redhat.com>
	 <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9FA8.7010008@redhat.com>
	 <1107180899.24654.67.camel@moss-spartans.epoch.ncsc.mil>
	 <41FE4B16.1050206@redhat.com>
	 <1107185236.24654.97.camel@moss-spartans.epoch.ncsc.mil>
	 <41FE7DB2.1000101@redhat.com>
Content-Type: text/plain
Message-Id: <1107267771.26936.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 09:22:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-31 at 13:49, Daniel J Walsh wrote:
> +	/usr/bin/diff $PREFC $FC | grep '^[<>]'|cut -c3-| grep ^/ | \
> +	grep -v -e ^/root -e ^/home -e ^/tmp -e ^/var/tmp | \
> +	sed -r -e 's|\(([/?[:alnum:]]+)\)\?|{\1,}|g' \
> +	       -e 's|([[:alnum:]])\?|{\1,}|g' \
> +	       -e 's,\(.*,*,g' -e 's,\[.*,*,g' \
> +	       -e 's,[[:blank:]].*,,g' \
> +               -e 's,\?.*,*,g' \
> +               -e 's,\.\*,*,g' \
> +	       -e 's,\(.*,*,g' \
> +	       -e 's,\[.*,*,g' | \

Minor:  You have duplicate \(.* and \[.* substitutions above, once with
both on the same line and then separately immediately above.

> +	sort -u | \
>          while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
>  	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \

The find command can end up re-introducing /root, /tmp, and /home if /
is in the input patterns, so you may want to move the grep -v command
down to the end of the pipeline.  tmp directories are likely ok anyway,
as file_contexts specifies <<none>> for them already (so restorecon
shouldn't relabel them even if they are passed).  Further, the find
command ends up re-introducing duplication; even though / was included
in my test, it also ended up generating a list of other directories
directly in / that were not separate filesystems.

As a side note, I experimented with this by splitting the pipeline up
and writing the output of each stage to a separate temporary file, then
diff'ing each pair of temporary files to see the effect of each stage. 
I wanted to force it to be applied to all file_contexts entries as a
degenerate case, so I initially tried passing -C /dev/null, but that
didn't seem to work (possibly fails the -f test), so I instead use a MLS
vs. non-MLS file_contexts to ensure that every line differed (due to the
MLS level field).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
