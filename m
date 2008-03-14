Message-ID: <47DA9A3C.3080802@redhat.com>
Date: Fri, 14 Mar 2008 11:31:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: libselinux/matchpathcon has a memory leak
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com>	 <47D9BBEE.5090105@redhat.com> <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Thu, 2008-03-13 at 19:42 -0400, Daniel J Walsh wrote:
> The attached patch fixes the leaks.
> 
plain text document attachment (diff)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/label.c
libselinux-2.0.59/src/label.c
- --- nsalibselinux/src/label.c	2007-07-16 14:20:46.000000000 -0400
+++ libselinux-2.0.59/src/label.c	2008-03-13 19:40:24.000000000 -0400
@@ -95,7 +95,7 @@
 	if (compat_validate(rec, lr, "file_contexts", 0))
 		return NULL;

- -	if (translating &&
+	if (translating && (! lr->ctx_trans) &&

> No parentheses required there.

ok


 	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
 		return NULL;

@@ -131,6 +131,7 @@
 void selabel_close(struct selabel_handle *rec)
 {
 	rec->func_close(rec);
+	free(rec->data);

> Wrong layer - we don't know how rec->data was allocated here.
> Needs to happen in label_file.c:close(), I think, at the end of it.

But reading that code, it looks like the memory was being zeroed out for
reuse?  That is why I did it here instead of in the close.
 	free(rec);
 }


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfamjcACgkQrlYvE4MpobNPbwCeMFxneOjYOcXZhcjw1dJ+bH8h
k30AoLcyCWc8L8n6n4fzZVD3wYuf8Cqe
=QnyD
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
