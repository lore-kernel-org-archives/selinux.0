Subject: Re: Patch to restorecon to add -R switch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41584DCA.7030006@redhat.com>
References: <41584DCA.7030006@redhat.com>
Content-Type: text/plain
Message-Id: <1096999568.3878.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 14:06:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-09-27 at 13:28, Daniel J Walsh wrote:
> Also patch adds some fixed for fixfiles.

> --- policycoreutils-1.17.5/scripts/fixfiles.rhat	2004-08-30 11:46:47.000000000 -0400
> +++ policycoreutils-1.17.5/scripts/fixfiles	2004-09-24 18:46:15.672622592 -0400
> @@ -36,6 +36,8 @@
>  FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
>  FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
>  SELINUXTYPE="targeted"
> +FCFILE=`mktemp /var/tmp/file_contexts.XXXXXXXXXX`
> +trap "rm -f $FCFILE; exit 2" 1 2 3 5 15 

I thought we had agreed that generating a temporary FCFILE was
undesirable and unnecessary, given that:
a) it requires allow setfiles to take temporary files as input (not
allowed by strict policy),
b) /dev nodes are no longer touched by setfiles anyway due to use of
tmpfs and udev.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
