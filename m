Date: Tue, 24 Sep 2002 08:13:59 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: directory permissions
In-Reply-To: <200209240848.IAA19881@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0209240808120.11975-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 24 Sep 2002, Carsten Grohmann wrote:

> the rw_dir_perms macro have "write" inside. But inside "Integrating
> Flexible Support for Security Policies into the Linux Operation System"
> from February 2001 I don't found this permission for the directory class
> (Table 13).
> Which permission is allow with write?

That report doesn't reflect changes made when we transitioned from the
original SELinux kernel patch to the LSM-based SELinux.  The changes are
described in the module technical report available in selinux/doc/module
in the release and from the NSA SELinux web site at
http://www.nsa.gov/selinux/module-abs.html.  In particular, the directory
write permission is discussed in
http://www.nsa.gov/selinux/doc/module/x104.html#INODE_PERMS_CHANGES.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
