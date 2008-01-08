Message-ID: <4783CE58.40008@redhat.com>
Date: Tue, 08 Jan 2008 14:26:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: In the midst of doing a conversion of audit2why to python
Content-Type: multipart/mixed;
 boundary="------------070202070909080604060701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070202070909080604060701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I want to make this code available to audit2why/audit2allow,
setroubleshoot and potentially system-config-selinux.

I have two questions,


Is there a way for audit2why to figure out whether an AVC would be
dontaudited by the current policy?

If we add audit2why python bindings should I put it in libselinux?
sepolgen?


Attached .h file describes functions and constants.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeDzlcACgkQrlYvE4MpobPCjwCgueX3P6iolC2wjwhRGoYRR5pT
S98An21rXxPf//hNoP1iDivDJw9AlhsL
=cTHu
-----END PGP SIGNATURE-----

--------------070202070909080604060701
Content-Type: text/x-chdr;
 name="audit2why.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2why.h"

#include <selinux/selinux.h>
#define BADSCON -1
#define BADTCON -2
#define BADTCLASS -3
#define BADPERM -4
#define BADCOMPUTE -5
#define NOPOLICY -6
#define ALLOWED 0
#define TERULE 1
#define BOOLEAN 2
#define CONSTRAINT 3
#define RBAC 4

struct boolean_t {
	char *name;
	int active;
};

extern void policy_finish(void);
extern int policy_init(const char *init_path);
extern int audit2why(const security_context_t scon, const security_context_t tcon, char *tclassstr, char *permstr, struct boolean_t **bools);

--------------070202070909080604060701
Content-Type: application/octet-stream;
 name="audit2why.h.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="audit2why.h.sig"

iEYEABECAAYFAkeDzlgACgkQrlYvE4MpobMyVQCeKJAKT1iMeSDiFvCnHSmfGcU94HgAoN5Q
p/anB8ieFw7B87T1FiNpJHjT
--------------070202070909080604060701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
