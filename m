Subject: Re: policycoreutils fixes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <421C9750.4080402@redhat.com>
References: <421C9750.4080402@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 09:14:52 -0500
Message-Id: <1109254492.4217.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-23 at 09:46 -0500, Daniel J Walsh wrote:
> +	while read pattern ; do find $pattern -fstype ext2 -fstype ext3 -fstype reiserfs -fstype xfs -print; done 2> /dev/null | \
> +	 ${RESTORECON} $2 -v -e /root -e /home -e /tmp -e /var/tmp -e /dev -f - 
>  	rm -f ${TEMPFILE}
>  fi
>  }

Per the find(1) man page, expr1 expr2 is an implied AND, i.e. both
expressions must be true, so -fstype ext2 -fstype ext3 will always be
false and you'll never print anything.

Shouldn't this be:
find $pattern \( -fstype ext2 -o -fstype ext3 -o -fstype xfs -o -fstype
reiserfs \) -print

Also, I'm not sure why you include reiserfs, as reiserfs xattr support
is still broken for SELinux in the mainline kernel and policy fs_use
doesn't use xattrs for reiserfs as a result.

As of 2.6.11, jfs will have xattr security support, so we should be able
to add it to policy/fs_use and start including it in fixfiles in the
future.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
