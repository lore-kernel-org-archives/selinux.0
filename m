Date: Fri, 17 Sep 2004 14:38:39 -0500
From: "George C. Wilson" <ltcgcw@us.ibm.com>
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Fedora SELinux List <fedora-selinux-list@redhat.com>
Subject: Boolean utilities segv's
Message-ID: <20040917193839.GA3020@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We found what appears to be a bug in libselinux.  The getsebool, setsebool,
and togglesebool all SIGSEGV when SELINUX=disabled.

The global that stores the selinuxfs mountpoint in libselinux, selinux_mnt, is
initialized to NULL.  selinuxfs is not mounted when SELinux is disabled,
therefore no mountpoint exists when init_selinuxmnt() scans /proc/mounts, and
selinux_mnt remains NULL.  So when get_bool_value() in booleans.c  attempts to
strlen(selinux_mnt), a SIGSEGV results.  The fix is to validate selinux_mnt
before the offending strlen() in get_bool_value(), line 101 of booleans.c from
selinux-usr-2004081908.  It probably would not hurt to validate name as well.
The same bug exists in FC3.

Thanks
-- 
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
