Message-ID: <41A788C2.9060609@gentoo.org>
Date: Fri, 26 Nov 2004 21:49:22 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Daniel J Walsh <Dan-Walsh@comcast.net>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Still getting random execute permissions on shared libraries.
References: <41A3EC21.1090200@comcast.net> <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEACEDB2B7351DCA24335F67B"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEACEDB2B7351DCA24335F67B
Content-Type: multipart/mixed;
 boundary="------------080503030203020707070706"

This is a multi-part message in MIME format.
--------------080503030203020707070706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi Stephen,

Stephen Smalley wrote:
> On Tue, 2004-11-23 at 21:04, Daniel J Walsh wrote:
> 
>>Trying to run java from within firefox is a disaster, Mozilla crashes.
>>
>>allow user_mozilla_t ld_so_cache_t:file execute;
>>allow user_mozilla_t lib_t:file execute; (Jar files)
>>allow user_mozilla_t user_tmp_t:file execute;
>>allow user_t ld_so_cache_t:file execute;
>>allow user_t locale_t:file execute;
> 
> 
> They aren't random.  As discussed previously here and on
> fedora-selinux-list, execution of a legacy binary causes the
> read_implies_exec behavior to be enabled for the process, so that
> subsequent read requests are transparently mapped to read|execute.  This
> was a change in the upstream kernel, not SELinux, and was to allow
> introduction of NX support without breaking compatibility with legacy
> binaries.  SELinux is merely checking permissions based on the
> information supplied by the core kernel.
> 
> Your options are:
> - get java rebuilt with a PT_GNU_STACK header so the kernel doesn't
> treat it as a legacy binary (assuming that it doesn't assume that read
> implies exec),
> - change policy to allow execute permission in these cases (although it
> would be preferable here to move java into its own domain in that case,
> so that you only have to allow it these permissions and not the entire
> user domain or mozilla domain).

I made a patch to the kernel that reverts to the old behaviour. no more execs on random files.
I find that changing the policy to allow those execs is not a valid solution.

would it be feasible to send upstream a patch that would remove the 'exec on read' behaviour if the kernel has selinux capabilities?

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------080503030203020707070706
Content-Type: text/plain;
 name="mmap_oddity.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmap_oddity.diff"

--- linux-2.6.9.orig/mm/mmap.c	2004-11-11 20:18:36.436249280 +0200
+++ linux-2.6.9/mm/mmap.c	2004-11-11 20:20:47.863269336 +0200
@@ -790,10 +790,12 @@
 	 * (the exception is when the underlying filesystem is noexec
 	 *  mounted, in which case we dont add PROT_EXEC.)
 	 */
+	/*
+ 	// this breaks havoc on a SELinux system
 	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
 		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
 			prot |= PROT_EXEC;
-
+	*/
 	if (!len)
 		return addr;
 

--------------080503030203020707070706--

--------------enigEACEDB2B7351DCA24335F67B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBp4jHGSBEIeh4AEYRAjsKAKCONk6pm9IjR+BaqQe9MUf0IIYMjgCfTyh/
HaH5vlsDEBRBdkRuGkJYFXs=
=Hqaf
-----END PGP SIGNATURE-----

--------------enigEACEDB2B7351DCA24335F67B--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
