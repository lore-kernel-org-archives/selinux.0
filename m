Subject: RE: sepol_genusers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200502180253.j1I2rl8R004666@gotham.columbia.tresys.com>
References: <200502180253.j1I2rl8R004666@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 08:36:50 -0500
Message-Id: <1108733810.28149.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-17 at 21:53 -0500, Karl MacMillan wrote:
> Any reason this shouldn't generate a new policy that is saved to disc? How are
> the booleans handled when the config file is corrupt? Also, there doesn't seem
> to be a security reason not to continue the boot with the missing users.

sepol_genusers(3), like sepol_genbools(3), is acting on an in-memory
binary policy image and generating a new in-memory image for loading
into the kernel just prior to performing the load.  No modification of
the on-disk policy binary file.  That is the point.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
