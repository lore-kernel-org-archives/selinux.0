Subject: Re: Patch to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41FA9FA8.7010008@redhat.com>
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA6861.6080505@redhat.com>
	 <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9FA8.7010008@redhat.com>
Content-Type: text/plain
Message-Id: <1107180899.24654.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 31 Jan 2005 09:14:59 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-28 at 15:25, Daniel J Walsh wrote:
> diff_filecontext() {
> if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> 	TEMPFILE=`mktemp ${FILE_CONTEXT}.XXXXXXXXXX`
> 	test -z "$TEMPFILE" && exit
> 	/usr/bin/diff $PREFC $FILE_CONTEXT | egrep '^[<>]'|cut -c3-| grep ^/ | \
>         sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
>             -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
>         while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
> 	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
> 	${RESTORECON} $2 -v -f -R - 
> 	rm -f ${TEMPFILE}
> fi
> }

To try to understand this better, I split the pipeline and wrote each
stage into a separate temporary file, then looked at diffs between each
pair of stages.  I'm not sure if the filter pipline is functioning as
you intend, e.g.:

1) The first sed substitution changes:
/var/tmp/vi\.recover  -d      system_u:object_r:tmp_t
to:
/var/tmp/vi*

A \. is not a regex; it is a regular dot character, so I would have
expected you to just remove the backslash for passing along to
restorecon. 

2) The second sed substitution changes:
/usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird --      system_u:object_r:bin_t
to:
/usr/lib*

This is due to sed itself performing regex matching for the .* sequence,
i.e. it consumes anything after an open parens.  Possibly you could
escape it if that is what you intended, e.g. \.\*.

Similar issues with the other substitutions that are using .*, I think,
e.g. changing:
/usr/bin/[xgkw]dm     --      system_u:object_r:xdm_exec_t
to:
/usr/bin/*

But the shell would have correctly handled /usr/bin/[xgkw]dm without any
change at all.

Also seems to have a problem with the /u?dev entries, changing:
/u?dev/microcode
to:
/u*

which won't actually catch /dev nodes.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
