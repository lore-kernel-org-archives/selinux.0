Subject: Re: Boolean utilities segv's
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "George C. Wilson" <ltcgcw@us.ibm.com>
Cc: SELinux <SELinux@tycho.nsa.gov>,
   Fedora SELinux List <fedora-selinux-list@redhat.com>
In-Reply-To: <20040917193839.GA3020@us.ibm.com>
References: <20040917193839.GA3020@us.ibm.com>
Content-Type: text/plain
Message-Id: <1095450979.17932.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 17 Sep 2004 15:56:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-17 at 15:38, George C. Wilson wrote:
> We found what appears to be a bug in libselinux.  The getsebool, setsebool,
> and togglesebool all SIGSEGV when SELINUX=disabled.
> 
> The global that stores the selinuxfs mountpoint in libselinux, selinux_mnt, is
> initialized to NULL.  selinuxfs is not mounted when SELinux is disabled,
> therefore no mountpoint exists when init_selinuxmnt() scans /proc/mounts, and
> selinux_mnt remains NULL.  So when get_bool_value() in booleans.c  attempts to
> strlen(selinux_mnt), a SIGSEGV results.  The fix is to validate selinux_mnt
> before the offending strlen() in get_bool_value(), line 101 of booleans.c from
> selinux-usr-2004081908.  It probably would not hurt to validate name as well.
> The same bug exists in FC3.

Ok, we can certainly fix this, but note that these functions are not
going to work on a non-SELinux system regardless; you shouldn't even be
calling them (or running those utilities) on a non-SELinux system.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
