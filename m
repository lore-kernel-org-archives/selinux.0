Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23BC433EF
	for <selinux@archiver.kernel.org>; Fri, 21 Jan 2022 08:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiAUIkS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jan 2022 03:40:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34284 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiAUIkQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jan 2022 03:40:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1CECE21910
        for <selinux@vger.kernel.org>; Fri, 21 Jan 2022 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642754414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=h2pRRYCk1RJJIWuSqUtOtGJXuG9Oa/NJR36JZAvfVVw=;
        b=dt+CO/pWYE2UuaVI9E02Aqr+wHgJ4hCwa/E7NW2is6M5CA6YUgAYgQ/3TA7VXnBi6MkOFG
        DqZRmQTQ0fncTo3A3zDqSZyMnlBPczONrTl+9tHU65+tKExKUXMeFrEf5hYMgPN8bQoeJl
        GD3y2GBGtkQC+BfpomNuI9+IayzQoR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642754414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=h2pRRYCk1RJJIWuSqUtOtGJXuG9Oa/NJR36JZAvfVVw=;
        b=NQNF94DQeWuRF8gJ/yWm+u6Ohng4vUiFJx2yXa9pMjuCzStwTNRLUnl9T1K6TsbODnvJ3j
        TR7OCj3fKan2P0AA==
Received: from suse.com (unknown [10.163.27.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BC4CA3B83
        for <selinux@vger.kernel.org>; Fri, 21 Jan 2022 08:40:14 +0000 (UTC)
Date:   Fri, 21 Jan 2022 09:40:12 +0100
From:   Johannes Segitz <jsegitz@suse.de>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: Cached security context not accurate
Message-ID: <20220121084012.GS7643@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L/iKGr82HRlWSTal"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--L/iKGr82HRlWSTal
Content-Type: multipart/mixed; boundary="Cp+VOSm8VfVBUvcG"
Content-Disposition: inline


--Cp+VOSm8VfVBUvcG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

a colleague of mine (Olaf Kirch) identified a problem with libselinux that
has a small security impact. I discussed this with some people on this list
privately before and we think it doesn't have a big impact and can be
discussed here without harm.

The reproducer below works on SUSE and RH systems.
# gcc -Wall -o test -lselinux test.c
# ./test
Parent: child context according to library unconfined_u:unconfined_r:unconf=
ined_t:s0
Parent: child context according to procfs: unconfined_u:unconfined_r:passwd=
_t:s0
bummer, context mismatch

You need to make you system permissive to allow the initial context change.

The problem is the procattr cache in libselinux, which doesn't work properl=
y.
Attached is a small patch that "fixes" the issue at the cost of not using t=
he
cache as soon as a pid is specified.

With this applied we see the correct result:
# ./test
Parent: child context according to library unconfined_u:unconfined_r:passwd=
_t:s0
Parent: child context according to procfs: unconfined_u:unconfined_r:passwd=
_t:s0

In most use cases this issue will not be much of a problem, but it's still
a small security issue, since this incorrect information might lead to
incorrect access decisions. This way of doing it is inherently racy and
should not be used for security decision, it's also probably pretty rare to
see this. ATM not CVE was assigned. Strictly speaking we probably need one,
but I won't push for it given the low impact.

Thanks,
Johannes

/*
 * This demonstrates some odd behavior in libselinux.
 *
 * procattr query functions seem to return cached content from
 * previous calls to the corresponding set function, but without
 * taking the pid into account.
 *
 * This means that getpidcon() returns the context installed
 * by the most recent setcon() call, rather than the actual
 * context of the process we wanted to query.
 *
 * Apparently, this was introduced by commit 1d403326a
 *
 * Enjoy,
 * Olaf Kirch <okir at suse.de>
 */
#include <selinux/selinux.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>

static void
fatal(const char *msg)
{
        perror(msg);
        exit(1);
}

static char *
getpidcon_sinatra(pid_t pid)
{
        static char linebuf[128];
        char path[1024];
        FILE *fp;

        snprintf(path, sizeof(path), "/proc/%d/attr/current", pid);
        if ((fp =3D fopen(path, "r")) =3D=3D NULL)
                fatal(path);

        if (fgets(linebuf, sizeof(linebuf), fp) =3D=3D NULL)
                fatal("read from /proc file");
        fclose(fp);

        return linebuf;
}

int
main(void)
{
        char *lib_context =3D NULL, *actual_context;
        pid_t pid;

        pid =3D fork();
        if (pid < 0)
                fatal("fork");

        if (pid =3D=3D 0) {
                if (setcon("unconfined_u:unconfined_r:passwd_t:s0") < 0)
                        fatal("child setcon");

                sleep(15);
                exit(0);
        }

        /* Set my own process context.
         * This will addle the library's brain by setting prev_current
         * in procattr.c
         */
        if (setcon("unconfined_u:unconfined_r:unconfined_t:s0") < 0)
                fatal("parent setcon");

        /* Wait for the child process to complete initialization */
        sleep(1);

        /* Ask the library about the security context */
        if (getpidcon(pid, &lib_context) < 0)
                fatal("getpidcon");
        printf("Parent: child context according to library %s\n", lib_conte=
xt);

        /* Query /proc/$pid/attr/current directly, which is what
         * the library is supposed to do. */
        actual_context =3D getpidcon_sinatra(pid);
        printf("Parent: child context according to procfs: %s\n", actual_co=
ntext);

        kill(pid, 9);

        if (strcmp(lib_context, actual_context) !=3D 0) {
                printf("bummer, context mismatch\n");
                return 1;
        }

        return 0;
}


Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nuernberg
Gesch=E4ftsf=FChrer: Ivo Totev (HRB 36809, AG N=FCrnberg)

--Cp+VOSm8VfVBUvcG
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="libselinux_procattr_cache.patch"
Content-Transfer-Encoding: quoted-printable

Index: libselinux-3.3/src/procattr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- libselinux-3.3.orig/src/procattr.c
+++ libselinux-3.3/src/procattr.c
@@ -148,7 +148,7 @@ static int getprocattrcon_raw(char ** co
 			return -1;
 	}
=20
-	if (prev_context && prev_context !=3D UNSET) {
+	if (prev_context && prev_context !=3D UNSET && !pid) {
 		*context =3D strdup(prev_context);
 		if (!(*context)) {
 			return -1;

--Cp+VOSm8VfVBUvcG--

--L/iKGr82HRlWSTal
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmHqcWwACgkQvCfdnSzE
/WZ2cA/8CcA3QRvFa0tg59+o42z+iRMR5iHSjw0IUiNOGLt6y6HKm1206yrnpHV/
qFAl+ovxLdL9nCRgwlK8j9PON6aDg5vISxD6kS0gbMg3alqfQIWPLAxCO9+2+zfA
abxs9avyOoVNxareCZ2IyW9yH97jvWZ/T/4BJaOIuP92sAxdH/WsfQ5fv/22IK8E
7FuvGt1jpYEbe7hf9xgN8jggCnqvaRzTmpWYzWVAnnq7+k/aIP65K/4PTqwnRDlu
6voerL7uhykMlzrDyomVtad0s1VunOPnf8uPEvjPi+KI0Tsl/s09fWV4SaSpt1Ez
+u+7kct5pHmKXR3CvGMecS0c0CDgDHFuro0jy3osw20OTzR5ZWyQCbX5WHolLXPY
LNTpOmA4ChVvQwX5kUYu61wi2Rhr+vskTAyBjOTeq1W5LLEM0djHeeACXe7zVrdg
cgyHkZ9mCF7CDq90Iqk0TILXr24cfW655lxpXvqzad3lklf5G5toI4OURhOXnqRK
TVJxve6FR81YAKFrHkSOGFe0LbfY2i60BmvW4qsGVodYqD40gGwr5W06PTMiFGZi
H3qqtP3UjTxvAK48XIp2Y6UA2wv4Yga8BpFhfP8Kreow1O5uxw+D5oGkcS9mF08Z
SRwgKE9puUM7nqgZcf7G1HdDWbSRq/jyad5WcGOIAHPKMzUbTyM=
=bfjT
-----END PGP SIGNATURE-----

--L/iKGr82HRlWSTal--
