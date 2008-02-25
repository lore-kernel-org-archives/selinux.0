Subject: Re: Permissive mode for xace is broken.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47C2D552.8060509@redhat.com>
References: <47C2CC18.6080801@redhat.com>
	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>
	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>
	 <47C2D552.8060509@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 13:49:23 -0500
Message-Id: <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 09:48 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Mon, 2008-02-25 at 09:12 -0500, Stephen Smalley wrote:
> >> On Mon, 2008-02-25 at 09:09 -0500, Daniel J Walsh wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> If I turn on xserver_object_manager in rawhide and log in as staff_t in
> >>> permissive mode, I get all sorts of things failing, which makes writing
> >>> policy for it very difficult.  And is very broken.
> >> Hmmm...as I understood it, XSELinux should follow the kernel's enforcing
> >> status by default (i.e. if the kernel is permissive, then so should
> >> XSELinux), unless you explicitly configure enforcing= in xorg.conf to
> >> specify a different setting for the X server than the kernel.  You are
> >> supposed to be able to make the X server permissive w/o making the
> >> kernel permissive via xorg configuration, I believe, although I'm not
> >> sure that made it into the rawhide xorg yet.
> > 
> > Doesn't look like the rawhide xorg server has that support yet.
> > 
> > But it should follow the kernel's enforcing status.  You should see log
> > messages with "received setenforce notice (enforcing=...)" in them from
> > both dbus and X in either /var/log/messages or /var/log/audit/audit.log.
> > 
> Looking at the code, I do not see security_getenforce() in the code.
> Are you saying that this is not necessary, the kernel will return
> allowed but generate the AVC?

Handling of enforcing status is hidden within the userspace AVC in
libselinux (libselinux/src/avc*.c).  avc_enforcing stores the current
value of the enforcing status and is updated when the kernel generates
the setenforce notification.  avc_setenforce is set if the object
manager explicitly sets its own enforcing mode to a specific value to
override the kernel status.

> And the only one who mentions setenforce in /var/log/audit/audit.log in
> dbus not X?

Hmmm...that's seems like a bug in X then, that it isn't getting the
notifications from the kernel (via netlink).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
