Message-ID: <526FD081.6080604@redhat.com>
Date: Tue, 29 Oct 2013 11:13:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: eparis@redhat.com, selinux@tycho.nsa.gov,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 09/17] Have sepolgen return additional constraint information
References: <526EC096.109@redhat.com> <526FB2C0.4010506@tycho.nsa.gov>
In-Reply-To: <526FB2C0.4010506@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------090202070002060908030301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090202070002060908030301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/29/2013 09:06 AM, Stephen Smalley wrote:
> On 10/28/2013 03:52 PM, Daniel J Walsh wrote:
>> This patch allows sepolgen to also display the constraint information. 
>> This patch looks good to me. acked.
> 
> Patches 1-3 applied on master. Patches 4-9 applied on a separate
> constraintnames branch for further review/testing and to await the updated
> kernel patch.
> 
> I suspect we'll need to go ahead and add the module version anyway just to
> avoid breaking compatibility?  Not optimal but I don't think we want 
> upstream SELinux userspace build to break a Fedora 19/20 box, or to reuse
> the version number down the road for something completely different.
> Unless you are going to push an update to 19 and 20 that will downgrade all
> modules to the prior version (what could possibly go wrong?).
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
Well here is the patch for this.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJv0IAACgkQrlYvE4MpobPzOgCg64w/kYLGklld3bT3nSEF3qXe
nwAAni97VHxOOjoumeexTx2yhzWy3uqR
=9Vop
-----END PGP SIGNATURE-----

--------------090202070002060908030301
Content-Type: text/x-patch;
 name="0011-Update-version-of-policy-file-to-match-what-was-ship.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0011-Update-version-of-policy-file-to-match-what-was-ship.pa";
 filename*1="tch"


--------------090202070002060908030301--
