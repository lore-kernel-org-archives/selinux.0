Subject: Re: Change fixfiles to use file_context.local if it exists.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F521F0.7090108@redhat.com>
References: <41F521F0.7090108@redhat.com>
Content-Type: text/plain
Message-Id: <1106584190.19246.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 11:29:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 11:27, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.1/scripts/fixfiles
> --- nsapolicycoreutils/scripts/fixfiles	2005-01-24 11:19:10.103136000 -0500
> +++ policycoreutils-1.21.1/scripts/fixfiles	2005-01-24 11:19:28.998223000 -0500
> @@ -37,11 +37,19 @@
>  SELINUXTYPE="targeted"
>  if [ -e /etc/selinux/config ]; then
>      . /etc/selinux/config
> -    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
> +    FC=`mktemp /var/tmp/file_contexts.XXXXXX`
> +    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null

Rather than using a temporary file in /var/tmp, I'd recommend creating
it in the same parent directory as the existing file_contexts
configuration (i.e. /etc/selinux/${SELINUXTYPE}/contexts/files). 
setfiles_t cannot read temporary files, and we don't especially want to
allow it to do so (to protect against low integrity input).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
