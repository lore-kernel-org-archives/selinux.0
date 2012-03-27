Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2REERCT020071
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 10:14:27 -0400
Message-ID: <4F71CB3F.5090305@redhat.com>
Date: Tue, 27 Mar 2012 10:14:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/4] libsemanage -- fallback-user-level
References: <20120326155749.4003f8fd@eldamar.bigon.be>
In-Reply-To: <20120326155749.4003f8fd@eldamar.bigon.be>
Content-Type: multipart/mixed;
 boundary="------------000103050407040902080700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000103050407040902080700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/26/2012 09:57 AM, Laurent Bigonville wrote:
> Hi,
> 
> I've no rational and no original author about this patch.
> 
> 
> --- a/libsemanage/src/genhomedircon.c +++
> b/libsemanage/src/genhomedircon.c @@ -863,7 +877,7 @@ level =
> semanage_user_get_mlslevel(*u); } else { prefix = name; -			level =
> "s0"; +			level = FALLBACK_USER_LEVEL; }
> 
> retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 
Looks good to me although I see this in two places.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9xyz8ACgkQrlYvE4MpobOV3QCfQfT77DP3b5sXDqmQ2vOoVVxl
wukAoL137DCkrpJF6ISEE63oa6z8Td2e
=EHIC
-----END PGP SIGNATURE-----

--------------000103050407040902080700
Content-Type: text/x-patch;
 name="libsemanage_fallback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage_fallback.patch"

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d2646ae..1b4c6c8 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -772,7 +772,7 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 			if (semanage_user_query(s->h_semanage, key, &u) < 0)
 			{
 				prefix = name;
-				level = "s0";
+				level = FALLBACK_USER_LEVEL;
 			}
 			else
 			{
@@ -863,7 +863,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 			level = semanage_user_get_mlslevel(*u);
 		} else {
 			prefix = name;
-			level = "s0";
+			level = FALLBACK_USER_LEVEL;
 		}
 
 		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);

--------------000103050407040902080700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
