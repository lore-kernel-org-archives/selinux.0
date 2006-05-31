Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, dhowells@redhat.com
In-Reply-To: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
References: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 31 May 2006 14:29:08 -0400
Message-Id: <1149100148.524.263.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-31 at 13:50 -0400, Michael LeMay wrote:
> This revision of my patch incorporates a few more changes suggested
> by Stephen.  I eliminated the "lookup" permission, due to the possibility
> for kernel confusion, and because of its strange semantics (e.g. it was
> possible to write to a key without performing a lookup on it).  I also added
> an unlink permission to the keys subsystem and SELinux, which is checked
> before a key is unlinked from a keyring.  I felt this change was fairly
> trivial and within the overall spirit of the patch, which is why I
> included it here.  If any of you decide it should be split off into
> some other patch, I'd be glad to remove it.

[Capturing an off-list discussion for the list] From a quick look, this
appears to break compatibility as it affects the key user interface.  We
could follow a similar approach to what was done in
fs/namei.c:permission() and open_namei(), where we introduced a new
MAY_APPEND flag, but mask it out before calling the normal DAC
permission checking logic, only passing it to the LSM hook.  We would
just need to reserve a permission bit for KEY_UNLINK for in-kernel use,
possibly the high bit.  No change to the existing key permission bits,
and plenty of room for them to grow still.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
