Date: Mon, 1 Apr 2002 09:34:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <SeLinux@tycho.nsa.gov>
Subject: Re: Troubles with 2.4.18 kernel
In-Reply-To: <20020401135709.A7D9C46E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204010913010.20742-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 1 Apr 2002, Russell Coker wrote:

> Yes, that is the case with the 2.4.18 kernel patches now.  However a kernel
> compiled with the older patch seems to work fine with utilities compiled
> against the headers from the new one (some of the current patches for
> utilities require the latest kernel patch for the latest headers though).

Yes, I think that the lsm-full-2002_02_25 patch against 2.4.18 from
lsm.immunix.org is "compatible" with the current SELinux release.
However, it lacks some of the newer developments in the SELinux kernel
module included in the NSA SELinux 2002031409 release (e.g. merging the
Selopt labeled networking support by James Morris, starting to adapt
SELinux to use that support, minimal labeling support for usbdevfs).
These newer developments were pushed to the LSM BitKeeper tree after the
NSA release was made, showing up in revision 1.322 of the lsm-2.4
BitKeeper tree.

> I expect that when 2.4.19 comes out then Immunix will have a patch that
> incorporates your latest code at least a week before the main NSA site gets
> it.

If "latest code" means the code from the 2002031409 release (plus
subsequent bug fixes, plus some new LSM hooks, plus any necessary updates
to address changes in 2.4.19), then you may be right.  But if "latest
code" means our latest stable internal version of the SELinux kernel
module, then that code should show up first at the NSA site as a new
release and only subsequently at the LSM site.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
