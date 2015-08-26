Date: Wed, 26 Aug 2015 16:07:01 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: kernel access to device comm is kdevtmpfs
Message-ID: <20150826140659.GA26572@x250>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <55DDC373.8030509@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Aug 26, 2015 at 09:47:31AM -0400, Stephen Smalley wrote:

<snip>

> 
> Fedora has tried to work around this by defining name-based type
> transitions for the kernel domain on /dev to label the device nodes
> correctly on creation.  However, name-based type transitions aren't well
> suited to that purpose; they only support exact match (no prefix, glob,
> or regex matching), they only match the last component, and they were
> only intended to cover exceptional cases where regular type transitions
> weren't sufficiently granular and one couldn't modify the creating
> program to explicitly label the file based on file_contexts (so they
> aren't designed to scale well).  Maybe we could use genfs_contexts
> instead (i.e. add devtmpfs to the list of filesystems that have
> SE_SBGENFS set in sbsec->flags, then you can specify path prefixes
> relative to the root of devtmpfs and label them that way).

This sounds like a good idea to me.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV3cf/AAoJENAR6kfG5xmc88gL+gLY44J62XK0v//hjLWtg9yk
fZLOvjQNJ0B1zsWhYWarJ/mxleToKLwZSDhNSinkjzvDzw2zTwCl6D5pf9JSp1cr
5IreQ/XTM4VDmUJqd45NReInWzwwn23lva2qHWrxk15RzWqAEvn+2lByUE/uk5ca
hKL173klBg2MVjS4hfafSm4h9KTvTB0mkMmcMbi9PzhzCqzqjB8Q6uJnzKQ9pGtT
i7ibHrQUNE18z9qRs3LQEaoTujdcTyvTL88f3nrdCGlJkihJe59Qm6lGv/UiFbbY
MRVpVdc4pC4sOr5+zNpD892L/L619gOtW0/5FpxWnBghHw46+G5p4ZAB79S+anfO
C5w0Rr5lQ0dYgAiV6wDCQZoBaw6PlOREtATe7WqOf7hAd7KGzYoRkuKdcYBMiEjj
XHqX8kXyKsoBl4k71LWHGGQyMAWunjrfxQCrpn37B4089jMJrJYbyXHeVHUo7X56
syh9uNPV2FMUey7wsuDXJ8C5PFZU8B1HP1PDXDLepQ==
=Wpna
-----END PGP SIGNATURE-----
