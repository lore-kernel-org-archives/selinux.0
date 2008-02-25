Subject: Re: Permissive mode for xace is broken.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47C2CC18.6080801@redhat.com>
References: <47C2CC18.6080801@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 09:12:44 -0500
Message-Id: <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 09:09 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> If I turn on xserver_object_manager in rawhide and log in as staff_t in
> permissive mode, I get all sorts of things failing, which makes writing
> policy for it very difficult.  And is very broken.

Hmmm...as I understood it, XSELinux should follow the kernel's enforcing
status by default (i.e. if the kernel is permissive, then so should
XSELinux), unless you explicitly configure enforcing= in xorg.conf to
specify a different setting for the X server than the kernel.  You are
supposed to be able to make the X server permissive w/o making the
kernel permissive via xorg configuration, I believe, although I'm not
sure that made it into the rawhide xorg yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
