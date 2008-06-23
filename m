Subject: Re: How to disable/remove MLS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ioannis Aslanidis <iaslanidis@flumotion.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <485FC1FB.3030605@flumotion.com>
References: <485FC1FB.3030605@flumotion.com>
Content-Type: text/plain
Date: Mon, 23 Jun 2008 12:05:36 -0400
Message-Id: <1214237136.32762.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-23 at 17:32 +0200, Ioannis Aslanidis wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> Is there a way to disable MLS so that the MLS tag gets removed from the
> context?

Whether or not MLS is enabled is defined by your policy build options.
In refpolicy, this is determined by the TYPE= setting in build.conf.
The upstream refpolicy defaults to "standard", which leaves MLS
disabled.  Fedora and RHEL use "mcs", which enables the MLS engine and
field but only uses categories with a different set of constraints than
"mls".  Fedora and RHEL also run mcstransd, a daemon for label
translation, which by default strips the ":s0" suffixes so that users
don't see them.

Disabling MCS/MLS in Fedora or RHEL may cause compatibility problems.
Such compatibility issues should be reported as bugs, since application
code should remain independent of policy, but such bugs have been
encountered in the past, and most users of Fedora and RHEL only use the
default policy that enables MCS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
