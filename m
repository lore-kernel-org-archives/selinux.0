Subject: RE: SELinux and LSM chaining.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin_Stoilov@mcafee.com
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, Valdis.Kletnieks@vt.edu,
        jbrindle@tresys.com, eparis@parisplace.org
In-Reply-To: <2069DE2C1E4BD64CABAB75F191A2B993A62732@beaexmb1.corp.nai.org>
References: <2069DE2C1E4BD64CABAB75F191A2B993A62732@beaexmb1.corp.nai.org>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 13:01:33 -0500
Message-Id: <1169661693.15390.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-24 at 09:52 -0800, Martin_Stoilov@McAfee.com wrote:
> Than you Stephen,
> 
> That was helpful, although disappointing. At least I understand that I
> should be looking for a different approach and don't expect SELinux to
> play nicely with secondary security modules.

Note however that you can use SELinux as a mechanism to support higher
level functionality, e.g. it is a very natural application of Type
Enforcement to enforce a processing pipeline in userspace to perform
e.g. scanning or filtering of data prior to use or release.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
