Subject: Re: [Announce][Patch] Enhanced MLS support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <791924EBDA572C4FA970D4A94AA95DA309E3BA@chaos.tcs.tcs-sec.com>
References: <791924EBDA572C4FA970D4A94AA95DA309E3BA@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1078327895.13948.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Mar 2004 10:31:36 -0500
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

The init and pam patches will need to go to Dan (cc'd above) for
inclusion after we have released a libselinux that includes
is_selinux_mls_enabled().  This can happen independently of the kernel
support getting into the Fedora kernel, as is_selinux_mls_enabled() will
return 0 if /selinux/mls doesn't exist at all.  With regard to the init
patch, it would likely be cleaner to bracket the snprintf with your test
of is_selinux_mls_enabled() and print the entire version string
(including -mls suffix if appropriate) once to the policy_file buffer;
the separate strncat could theoretically overflow the buffer and is
wasteful anyway (having to walk the string again).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
