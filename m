Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D1C4CECD
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC70F2070B
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir9GBUVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD0U63 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:58:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD0U63 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588021107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsISodZHrSsxvA/UsmPEsM31hKOL2TgsTCG24SOBzUA=;
        b=Ir9GBUVI5Afp2rDhsBw0/1POuyh5s5a+QKQgoorlgeGabqB2F5WknyMdzmjN64sfIMqd4J
        pgjI6WicY6GerGImJ1OgChhVN4Ti2NzILXOwEKyAuJMGXYgiClEkrLwpxXsWPCSnWoB3nz
        lqwzQQnMdote7gsX0xxFXJ1mwYPuO4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-eJR2WeNtOL6oqL0tTg18cA-1; Mon, 27 Apr 2020 16:58:23 -0400
X-MC-Unique: eJR2WeNtOL6oqL0tTg18cA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F314680B702;
        Mon, 27 Apr 2020 20:58:21 +0000 (UTC)
Received: from workstation (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0329B60D27;
        Mon, 27 Apr 2020 20:58:19 +0000 (UTC)
Date:   Mon, 27 Apr 2020 22:58:16 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 3/3] restorecond/user: handle SIGTERM properly
Message-ID: <20200427205816.GA28535@workstation>
References: <20200413162413.1161803-1-nicolas.iooss@m4x.org>
 <20200413162413.1161803-3-nicolas.iooss@m4x.org>
MIME-Version: 1.0
In-Reply-To: <20200413162413.1161803-3-nicolas.iooss@m4x.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2020 at 06:24:13PM +0200, Nicolas Iooss wrote:
> When restorecond starts, it installs a SIGTERM handler in order to exit
> cleanly (by removing its PID file). When restorecond --user starts,
> there is no PID file, and g_main_loop_run() does not stop when master_fd
> is closed. This leads to an unkillable service, which is an issue.
>=20
> Fix this by overriding the handler for SIGTERM in restorecond --user.
>=20
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

The whole patchset

Acked-by: Petr Lautrbach <plautrba@redhat.com>

and merged.

Thanks!


> ---
>  restorecond/user.c | 54 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 17 deletions(-)
>=20
> diff --git a/restorecond/user.c b/restorecond/user.c
> index f940fd4e6678..a24b8407b048 100644
> --- a/restorecond/user.c
> +++ b/restorecond/user.c
> @@ -46,6 +46,7 @@
>  #include "restorecond.h"
>  #include "stringslist.h"
>  #include <glib.h>
> +#include <glib-unix.h>
> =20
>  static int local_lock_fd =3D -1;
> =20
> @@ -250,35 +251,54 @@ static void end_local_server(void) {
>  =09local_lock_fd =3D -1;
>  }
> =20
> +static int sigterm_handler(gpointer user_data)
> +{
> +=09GMainLoop *loop =3D user_data;
> +
> +=09if (debug_mode)
> +=09=09g_print("Received SIGTERM, exiting\n");
> +=09g_main_loop_quit(loop);
> +=09return FALSE;
> +}
> +
> +
>  int server(int master_fd, const char *watch_file) {
> -    GMainLoop *loop;
> +=09GMainLoop *loop;
> =20
> -    loop =3D g_main_loop_new (NULL, FALSE);
> +=09loop =3D g_main_loop_new (NULL, FALSE);
> =20
>  #ifdef HAVE_DBUS
> -    if (dbus_server(loop) !=3D 0)
> +=09if (dbus_server(loop) !=3D 0)
>  #endif /* HAVE_DBUS */
> -=09    if (local_server())
> -=09=09    goto end;
> +=09=09if (local_server())
> +=09=09=09goto end;
> =20
> -    read_config(master_fd, watch_file);
> +=09read_config(master_fd, watch_file);
> =20
> -    if (watch_list_isempty()) goto end;
> +=09if (watch_list_isempty())
> +=09=09goto end;
> =20
> -    set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
> +=09set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
> =20
> -    GIOChannel *c =3D g_io_channel_unix_new(master_fd);
> +=09GIOChannel *c =3D g_io_channel_unix_new(master_fd);
> =20
> -    g_io_add_watch_full( c,
> -=09=09=09 G_PRIORITY_HIGH,
> -=09=09=09 G_IO_IN|G_IO_ERR|G_IO_HUP,
> -=09=09=09 io_channel_callback, NULL, NULL);
> +=09g_io_add_watch_full(c,
> +=09=09=09    G_PRIORITY_HIGH,
> +=09=09=09    G_IO_IN|G_IO_ERR|G_IO_HUP,
> +=09=09=09    io_channel_callback, NULL, NULL);
> =20
> -    g_main_loop_run (loop);
> +=09/* Handle SIGTERM */
> +=09g_unix_signal_add_full(G_PRIORITY_DEFAULT,
> +=09=09=09       SIGTERM,
> +=09=09=09       sigterm_handler,
> +=09=09=09       loop,
> +=09=09=09       NULL);
> +
> +=09g_main_loop_run (loop);
> =20
>  end:
> -    end_local_server();
> -    g_main_loop_unref (loop);
> -    return 0;
> +=09end_local_server();
> +=09g_main_loop_unref (loop);
> +=09return 0;
>  }
> =20
> --=20
> 2.26.0
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6nR2IACgkQviIJHj72
InWOuA/5AT9jgLppoZemR71jjLgkLdDx+U55sNkqPfFgQY5/QM62heGjyIV2u+FD
YG8OtvVAR1SQP+GcwjMzDebTFDwEvtdVxmgCftXz47nbx89WMSUwZgvZwVeH/wFE
37yr5PGPmUpeEkiusEKeuy8Vx/l/Up25TWkWI13uRTWSOVPv3z+6AtWzFam4I+DC
RaIRCBug+COkJT5XlCCu3yT3hr1EKKpuXXMZddULyOn3VVdlKJTvJcScxOhHGY1S
SostBJUiVCyqC00yD4U4ijjtMs6VijJFVTNGL7qCYOhn8gsoUhp1y8X41S65uUob
06y3xNdE8KRxsl7rTTbYR/vk6TBRCOT7NHc9GwsodM/HMNxRWh8EF2Fw+uiar6oR
GUf3O+pZtH0VokkM0JhCiVSZB5GkhDqJC3ipi2r6wFxYEUUfuGg+Wyzr8aU1PMfV
7g1Y3Fwe7521ww32TBBH4IeNbUkhL90jGdONJcIIjO4Zr7glSU5GOIXqsIGFCpxi
F10wGRr6lXMf7y5Bw729iJiaonk/IcPFNwhrqeM2XSyHjPF69wkdC42A8oMKhIBR
7KmS+RJT5EzqkyB/Pw1TEHVnl2kzw1pSJsCFtCb1WQ1LiSOnjPF+FwL1Rs8CD1Uo
N/pSy/IuRi1Q2/SWPq66zExWJKRzZHJR67oq9xo/OVvC0C0xs30=
=O/v8
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

