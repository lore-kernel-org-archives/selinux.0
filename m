Subject: Re: [Announce][Patch] Enhanced MLS support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <791924EBDA572C4FA970D4A94AA95DA309E3BA@chaos.tcs.tcs-sec.com>
References: <791924EBDA572C4FA970D4A94AA95DA309E3BA@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1078259657.9775.228.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Mar 2004 15:34:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-02 at 14:44, Chad Hanson wrote:
> Attached are patches to enable the detection of MLS on a SELinux system. 
> 
> This consists of an mls object inside of selinuxfs (/selinux/mls), a library
> call for libselinux (is_selinux_mls_enabled()), and application patches for
> pam and init. The init patch enables loading of MLS or non-MLS policy
> depending on kernel configuration. The pam patch will ask for the MLS level
> if a default context is not found.

Thanks for working on this.  With regard to the libselinux function,
note that the other libselinux functions have been converted to obtain
the selinuxfs mount point from selinux_mnt (determined at runtime by
libselinux/src/init.c:init_selinuxmnt()) rather than compiling in a
fixed location.  That allows the selinuxfs mount point to be easily
changed without affecting any package other than SysVinit.  There has
been prior discussion of moving the selinuxfs mount point from /selinux
to a better location, so we want to prepare for such a transition.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
