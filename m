Subject: Re: review of a dbus-selinux patch
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5277D42D.6050609@tycho.nsa.gov>
References: <1383578801.23834.59.camel@localhost>
	 <5277D42D.6050609@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-g285+NppxASjaQXDdHc8"
Date: Thu, 07 Nov 2013 14:57:30 -0500
Message-ID: <1383854250.23834.146.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-g285+NppxASjaQXDdHc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-11-04 at 12:06 -0500, Stephen Smalley wrote:

> XSELinux correctly uses selinux_set_mapping() so that libselinux
> internally creates a mapping from arbitrary class/perm indices used by
> XSELinux and the policy values and handles all of the translation at
> runtime on avc_has_perm() calls.

Ok, I see how this works now.  It was not obvious at all to me initially
that the order of the #defines in XSELinux had to correspond to the
security_class_mapping struct array.

But then I only discovered while writing a patch to document
selinux_set_mapping() that there are man pages now for the libselinux
API, and I guess the docs in the headers are not really used anymore?

Anyways I attached the patch...maybe it'll be useful.


--=-g285+NppxASjaQXDdHc8
Content-Disposition: attachment; filename="0001-selinux_set_mapping-Document-it.patch"
Content-Type: text/x-patch; name="0001-selinux_set_mapping-Document-it.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


--=-g285+NppxASjaQXDdHc8--
