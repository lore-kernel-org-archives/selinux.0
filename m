Subject: Re: Strange staff role problems...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
In-Reply-To: <421CB4F3.5040803@redhat.com>
References: <1109131644.5285.10.camel@cobra.ivg2.net>
	 <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>
	 <421CAF61.20708@redhat.com>
	 <1109176324.17298.85.camel@moss-spartans.epoch.ncsc.mil>
	 <421CB4F3.5040803@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 12:12:00 -0500
Message-Id: <1109178720.17298.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-23 at 11:53 -0500, Daniel J Walsh wrote:
> Ok try again.

Looks good.  Of course, you'll need to update the spec file if you
haven't already to depend on versions of libselinux and libsepol that
include the necessary support (libselinux >= 1.21.10, libsepol >=
1.3.4).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
