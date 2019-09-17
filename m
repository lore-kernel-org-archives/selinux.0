Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7535BC4CECD
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 07:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B8420644
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 07:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7E2wWRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbfIQHEy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:04:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403930AbfIQHEy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 03:04:54 -0400
X-Greylist: delayed 66733 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 03:04:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568703892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99+h19yIeZjFBTOJyvLYcGljdfdGw4/JbX4nBUv4w1c=;
        b=Y7E2wWRxvzKk/kNOsncJTQfW0nC2ozTM7MpbX+mX6pWi1R5h1l+lUmTx9IspmjqCwAh2rY
        Q4whiFNyQ/iDr02cVujgtkh9E1mujw+VvtQQ9H6UxjdawEqntWl2m+YVpxeLhsE6b4T4es
        jlGmVWUO6JxdLANcP0fLDOCUaUTF3YY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-YIOJ28M1MNCW0HCYlh6SoA-1; Tue, 17 Sep 2019 03:04:48 -0400
Received: by mail-oi1-f198.google.com with SMTP id c205so1201934oib.10
        for <selinux@vger.kernel.org>; Tue, 17 Sep 2019 00:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=99+h19yIeZjFBTOJyvLYcGljdfdGw4/JbX4nBUv4w1c=;
        b=NS+WptnAiKXXB9ff45O64MsjTHrZS7W6uuG0oM7cebDNn/MhB/PdRR9QRd4MUrN5x+
         YO/WfxfEpKbusEUttTkAbb/nQnaqx40F6hfbo5biK4T8KP40HkvxC92HSkP9uDbWHduz
         PqHi01sG2ULJxREKcXyK/uHt0erF/fqWx5R4nsXUnMfITRJUUndvssvzB2yEdw34ufKN
         0ye1QFKFNHTVnEZ2J6vzbLaTH8OFVDkhMh+qK9AXIJMX1+oRgEPyIEZs0V/dvLuhFK7h
         eJ7s6RyiyPUG5idqVLyd4tdmLdtDwmJT/9nRSY440cZETr29LP5jIgW3VSQG93poyt/9
         /axQ==
X-Gm-Message-State: APjAAAVfxLQ63/zjV+U3GlUWn7TD1CZ/bs52ZR8QFsLBw+7eu4D4IKMQ
        V8Cjz7mzOO3Mgc3e3ZYb5kNQpNtT/ruqoYO1IfxzNsHbTd5HfaGqA/n0b0G0N3oc4gyxwXH2dDT
        3kItqt1O95yE4waL/oLluesO6nX5PL5/dhA==
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr1599667otn.197.1568703887573;
        Tue, 17 Sep 2019 00:04:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+I55EmgrwQTGqZhWKFGrizkbcBN9DKApJXSoirZ942gIsCh+CNkhaNUJ7XLtLSPI1uOjR67GZvGbZ5eeqnXk=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr1599637otn.197.1568703887113;
 Tue, 17 Sep 2019 00:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190909131701.29588-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190909131701.29588-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 17 Sep 2019 09:04:35 +0200
Message-ID: <CAFqZXNtRmH_B1iXnxHGoBvrgveYuxQpL1+4JSrP1+11rRpKH=Q@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add key and key_socket tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
X-MC-Unique: YIOJ28M1MNCW0HCYlh6SoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 9, 2019 at 3:17 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Test all permissions associated with the key and key_socket classes.
>
> Note that kernel 5.3 commit keys: Fix request_key() lack of Link perm
> check on found key ("504b69eb3c95180bc59f1ae9096ad4b10bbbf254")
> added an additional check for link perm on request_key(). The tests
> will support earlier kernels.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  README.md                   |   3 +-
>  defconfig                   |   8 ++
>  policy/Makefile             |   4 +
>  policy/test_keys.te         | 161 ++++++++++++++++++++++++
>  tests/Makefile              |   4 +
>  tests/keys/.gitignore       |   3 +
>  tests/keys/Makefile         |   8 ++
>  tests/keys/key_sock.c       |  67 ++++++++++
>  tests/keys/keyctl.c         | 241 ++++++++++++++++++++++++++++++++++++
>  tests/keys/keyctl_relabel.c |  93 ++++++++++++++
>  tests/keys/test             |  98 +++++++++++++++
>  11 files changed, 689 insertions(+), 1 deletion(-)
>  create mode 100644 policy/test_keys.te
>  create mode 100644 tests/keys/.gitignore
>  create mode 100644 tests/keys/Makefile
>  create mode 100644 tests/keys/key_sock.c
>  create mode 100644 tests/keys/keyctl.c
>  create mode 100644 tests/keys/keyctl_relabel.c
>  create mode 100755 tests/keys/test
>
> diff --git a/README.md b/README.md
> index 26784f8..fe72a91 100644
> --- a/README.md
> +++ b/README.md
> @@ -65,7 +65,8 @@ following command:
>                 netlabel_tools \
>                 iptables \
>                 lksctp-tools-devel \
> -               attr
> +               attr \
> +               keyutils-libs-devel
>
>  The testsuite requires a pre-existing base policy configuration of SELin=
ux,
>  using either the old example policy or the reference policy as the basel=
ine.
> diff --git a/defconfig b/defconfig
> index d7f0ea5..c00e291 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -62,3 +62,11 @@ CONFIG_ANDROID_BINDER_IPC=3Dy
>  # This will configure the Dynamically Allocated Binder Devices added
>  # to 5.0+ kernels:
>  CONFIG_ANDROID_BINDERFS=3Dy
> +
> +# Key implementations.
> +# These are enabled to test the key and key_socket controls in
> +# tests/keys; they are not required for SELinux operation itself.
> +CONFIG_KEYS=3Dy
> +CONFIG_KEYS_COMPAT=3Dy
> +CONFIG_KEY_DH_OPERATIONS=3Dy
> +CONFIG_NET_KEY=3Dm
> diff --git a/policy/Makefile b/policy/Makefile
> index 305b572..9258a93 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(PO=
LDEV)/include/kernel/coren
>  TARGETS +=3D test_sctp.te
>  endif
>
> +ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt=
 && echo true),true)

You might want to include a grep for KEYCTL_RESTRICT_KEYRING in
keyutils.h to make sure a recent enough keyutils library is installed.
For example, on RHEL-8 there is some old keyutils version (1.5.10+)
and the test fails to build there.

> +TARGETS +=3D test_keys.te
> +endif
> +
>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
>  endif
> diff --git a/policy/test_keys.te b/policy/test_keys.te
> new file mode 100644
> index 0000000..9c65ec8
> --- /dev/null
> +++ b/policy/test_keys.te
> @@ -0,0 +1,161 @@
> +#
> +################# KEY selinux-testsuite policy module ##################=
####
> +#
> +attribute keydomain;
> +
> +#
> +############################## Define Macro ############################=
####
> +#
> +# Do not use domain_type() macro as it has allow 'key { link search }'
> +# in base module so 'allow domain self:key ~{ link search };' will not w=
ork
> +# here. Add these instead to allow key perms to be controlled by this mo=
dule:
> +#
> +define(`key_domain_type',`
> +       allow $1 proc_t:dir { search };
> +       allow $1 proc_t:lnk_file { read };
> +       allow $1 self:dir { search };
> +       allow $1 self:file { open read write };
> +')
> +
> +#
> +####################### Main key class tests #####################
> +#
> +type test_key_t;
> +key_domain_type(test_key_t)
> +unconfined_runs_test(test_key_t)
> +typeattribute test_key_t testdomain;
> +typeattribute test_key_t keydomain;
> +
> +allow test_key_t self:process { setkeycreate };
> +allow test_key_t self:key { create write search read view link setattr }=
;
> +
> +# Set new context on a keyring:
> +type test_newcon_key_t;
> +key_domain_type(test_newcon_key_t)
> +unconfined_runs_test(test_newcon_key_t)
> +typeattribute test_newcon_key_t testdomain;
> +typeattribute test_newcon_key_t keydomain;
> +
> +allow test_key_t test_newcon_key_t:key { create write search view };
> +
> +################# Deny process { setkeycreate } #######################
> +type test_no_setkeycreate_t;
> +key_domain_type(test_no_setkeycreate_t)
> +unconfined_runs_test(test_no_setkeycreate_t)
> +typeattribute test_no_setkeycreate_t testdomain;
> +typeattribute test_no_setkeycreate_t keydomain;
> +
> +###################### Deny key { create } ###########################
> +type test_key_no_create_t;
> +key_domain_type(test_key_no_create_t)
> +unconfined_runs_test(test_key_no_create_t)
> +typeattribute test_key_no_create_t testdomain;
> +typeattribute test_key_no_create_t keydomain;
> +
> +allow test_key_no_create_t self:process { setkeycreate };
> +allow test_key_no_create_t self:key { write search read view link setatt=
r };
> +
> +###################### Deny key { write } ###########################
> +type test_key_no_write_t;
> +key_domain_type(test_key_no_write_t)
> +unconfined_runs_test(test_key_no_write_t)
> +typeattribute test_key_no_write_t testdomain;
> +typeattribute test_key_no_write_t keydomain;
> +
> +allow test_key_no_write_t self:process { setkeycreate };
> +allow test_key_no_write_t self:key { create search read view link setatt=
r };
> +
> +###################### Deny key { search } ###########################
> +type test_key_no_search_t;
> +key_domain_type(test_key_no_search_t)
> +unconfined_runs_test(test_key_no_search_t)
> +typeattribute test_key_no_search_t testdomain;
> +typeattribute test_key_no_search_t keydomain;
> +
> +allow test_key_no_search_t self:process { setkeycreate };
> +allow test_key_no_search_t self:key { create write read view link setatt=
r };
> +
> +###################### Deny key { view } ###########################
> +type test_key_no_view_t;
> +key_domain_type(test_key_no_view_t)
> +unconfined_runs_test(test_key_no_view_t)
> +typeattribute test_key_no_view_t testdomain;
> +typeattribute test_key_no_view_t keydomain;
> +
> +allow test_key_no_view_t self:process { setkeycreate };
> +allow test_key_no_view_t self:key { create write search read link setatt=
r };
> +
> +###################### Deny key { read } ###########################
> +type test_key_no_read_t;
> +key_domain_type(test_key_no_read_t)
> +unconfined_runs_test(test_key_no_read_t)
> +typeattribute test_key_no_read_t testdomain;
> +typeattribute test_key_no_read_t keydomain;
> +
> +allow test_key_no_read_t self:process { setkeycreate };
> +allow test_key_no_read_t self:key { create write search view link setatt=
r };
> +
> +###################### Deny key { link } ###########################
> +type test_key_no_link_t;
> +key_domain_type(test_key_no_link_t)
> +unconfined_runs_test(test_key_no_link_t)
> +typeattribute test_key_no_link_t testdomain;
> +typeattribute test_key_no_link_t keydomain;
> +
> +allow test_key_no_link_t self:process { setkeycreate };
> +allow test_key_no_link_t self:key { create write search read view setatt=
r };
> +
> +###################### Deny key { setattr } ###########################
> +type test_key_no_setattr_t;
> +key_domain_type(test_key_no_setattr_t)
> +unconfined_runs_test(test_key_no_setattr_t)
> +typeattribute test_key_no_setattr_t testdomain;
> +typeattribute test_key_no_setattr_t keydomain;
> +
> +allow test_key_no_setattr_t self:process { setkeycreate };
> +allow test_key_no_setattr_t self:key { create write search read view lin=
k };
> +
> +#
> +######################## Test key_socket class #########################=
##
> +#
> +type test_key_sock_t;
> +domain_type(test_key_sock_t)
> +unconfined_runs_test(test_key_sock_t)
> +typeattribute test_key_sock_t testdomain;
> +typeattribute test_key_sock_t keydomain;
> +
> +# key_socket rules:
> +allow test_key_sock_t self:rawip_socket { create };
> +allow test_key_sock_t self:capability { net_admin };
> +allow test_key_sock_t self:key_socket { create write };
> +# For CONFIG_NET_KEY=3Dm
> +allow test_key_sock_t kernel_t:system { module_request };
> +
> +################## Deny capability { net_admin } #######################=
###
> +type test_key_sock_no_net_admin_t;
> +domain_type(test_key_sock_no_net_admin_t)
> +unconfined_runs_test(test_key_sock_no_net_admin_t)
> +typeattribute test_key_sock_no_net_admin_t testdomain;
> +typeattribute test_key_sock_no_net_admin_t keydomain;
> +
> +# key_socket rules:
> +allow test_key_sock_no_net_admin_t self:rawip_socket { create };
> +allow test_key_sock_no_net_admin_t self:key_socket { create write };
> +
> +####################### Deny key_socket { create } #####################=
#####
> +type test_key_sock_no_create_t;
> +domain_type(test_key_sock_no_create_t)
> +unconfined_runs_test(test_key_sock_no_create_t)
> +typeattribute test_key_sock_no_create_t testdomain;
> +typeattribute test_key_sock_no_create_t keydomain;
> +
> +# key_socket rules:
> +allow test_key_sock_no_create_t self:rawip_socket { create };
> +allow test_key_sock_no_create_t self:capability { net_admin };
> +allow test_key_sock_no_create_t self:key_socket { write };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain #######=
#####
> +#
> +miscfiles_domain_entry_test_files(keydomain)
> +userdom_sysadm_entry_spec_domtrans_to(keydomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 63aa325..d1dbf38 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -42,6 +42,10 @@ ifeq ($(shell grep -q binder $(POLDEV)/include/support=
/all_perms.spt && test -e
>  SUBDIRS +=3D binder
>  endif
>
> +ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt=
 && test -e $(INCLUDEDIR)/keyutils.h && echo true),true)
> +SUBDIRS +=3D keys
> +endif
> +
>  ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=3D" infiniband_endp=
ort/ibendport_test.conf | cut -d'=3D' -f 2),1)
>  SUBDIRS +=3D infiniband_endport
>  endif
> diff --git a/tests/keys/.gitignore b/tests/keys/.gitignore
> new file mode 100644
> index 0000000..4a0a48d
> --- /dev/null
> +++ b/tests/keys/.gitignore
> @@ -0,0 +1,3 @@
> +keyctl
> +keyctl_relabel
> +key_sock
> diff --git a/tests/keys/Makefile b/tests/keys/Makefile
> new file mode 100644
> index 0000000..3a00df5
> --- /dev/null
> +++ b/tests/keys/Makefile
> @@ -0,0 +1,8 @@
> +TARGETS =3D keyctl key_sock keyctl_relabel
> +
> +LDLIBS +=3D -lselinux -lkeyutils
> +
> +all: $(TARGETS)
> +
> +clean:
> +       rm -f $(TARGETS)
> diff --git a/tests/keys/key_sock.c b/tests/keys/key_sock.c
> new file mode 100644
> index 0000000..8ac1f45
> --- /dev/null
> +++ b/tests/keys/key_sock.c
> @@ -0,0 +1,67 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/socket.h>
> +#include <linux/pfkeyv2.h>
> +#include <selinux/selinux.h>
> +
> +static void usage(char *progname)
> +{
> +       fprintf(stderr,
> +               "usage:  %s [-v]\n"
> +               "Where:\n\t"
> +               "-v  Print information.\n", progname);
> +       exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       char *context;
> +       int opt, sock, result;
> +       bool verbose =3D false;
> +
> +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> +               switch (opt) {
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +               }
> +       }
> +
> +       result =3D getcon(&context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain process context\n");
> +               exit(-1);
> +       }
> +       if (verbose)
> +               printf("Process context: %s\n", context);
> +
> +       sock =3D socket(PF_KEY, SOCK_RAW, PF_KEY_V2);
> +       if (sock < 0) {
> +               fprintf(stderr, "Failed to open PF_KEY socket: %s\n",
> +                       strerror(errno));
> +               exit(errno);
> +       }
> +       if (verbose)
> +               printf("Opened PF_KEY socket\n");
> +
> +       /* Write nothing to socket for test, expect EMSGSIZE error */
> +       result =3D write(sock, NULL, 0);
> +       if (result < 0 && errno =3D=3D EMSGSIZE) {
> +               result =3D 0;
> +               if (verbose)
> +                       printf("Written to PF_KEY socket\n");
> +       } else if (result < 0 && errno !=3D EMSGSIZE) {
> +               result =3D -1;
> +               fprintf(stderr, "Failed write to PF_KEY socket: %s\n",
> +                       strerror(errno));
> +       }
> +
> +       close(sock);
> +       return result;
> +}
> diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
> new file mode 100644
> index 0000000..6d85be7
> --- /dev/null
> +++ b/tests/keys/keyctl.c
> @@ -0,0 +1,241 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <keyutils.h>
> +#include <selinux/selinux.h>
> +
> +/* This is used as the payload for each add_key() */
> +static const char payload[] =3D
> +       " -----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQK=
BgQDN4FHsPjlJf03r9KfNt1Ma9/D6\nQDEiR/cfhZrNUPgHRrC+E4dj52VJSonPFJ6HaLlUi5pZ=
q2t1LqPNrMfFKCNn12m+\nWw4aduBJM7u1RUPSNxrlfDAJZkdtNALOO/ds3U93hZrxOYNetzbnj=
ILDu5JT1nbI\n4aC60SkdlCw1TxmvXwIDAQAB\n-----END PUBLIC KEY-----\n";
> +
> +static void usage(char *progname)
> +{
> +       fprintf(stderr,
> +               "usage:  %s [-v]\n"
> +               "Where:\n\t"
> +               "-v  Print information.\n", progname);
> +       exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int opt, result;
> +       char *context, *keycreate_con;
> +       char r_con[256];
> +       bool verbose =3D false;
> +       key_serial_t retrieved, search, link, compute, newring,
> +                    private, prime, base, test_key;
> +       struct keyctl_dh_params params;
> +
> +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> +               switch (opt) {
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +               }
> +       }
> +
> +       result =3D getcon(&context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain process context\n");
> +               exit(1);
> +       }
> +       if (verbose)
> +               printf("Process context: %s\n", context);
> +
> +       result =3D getkeycreatecon(&keycreate_con);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain keycreate context\n");
> +               exit(2);
> +       }
> +       if (verbose)
> +               printf("Current keycreate context: %s\n", keycreate_con);
> +       free(keycreate_con);
> +
> +       /* Set context requires process { setkeycreate } and key { create=
 } */
> +       result =3D setkeycreatecon(context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed setkeycreatecon(): %s\n",
> +                       strerror(errno));
> +               exit(3);
> +       }
> +       if (verbose)
> +               printf("Set keycreate context: %s\n", context);
> +       free(context);
> +
> +       result =3D getkeycreatecon(&keycreate_con);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain keycreate context\n");
> +               exit(4);
> +       }
> +       if (verbose)
> +               printf("New keycreate context: %s\n", keycreate_con);
> +       free(keycreate_con);
> +
> +       /*
> +        * Add three keys as these will be required by the
> +        * keyctl(KEYCTL_DH_COMPUTE, ..) function.
> +        * These require key { create write } permissions.
> +        */
> +       private =3D add_key("user", "private", payload, strlen(payload),
> +                         KEY_SPEC_PROCESS_KEYRING);
> +       if (private < 0) {
> +               fprintf(stderr, "Failed add_key(private): %s\n",
> +                       strerror(errno));
> +               exit(5);
> +       }
> +
> +       prime =3D add_key("user", "prime", payload, strlen(payload),
> +                       KEY_SPEC_PROCESS_KEYRING);
> +       if (prime < 0) {
> +               fprintf(stderr, "Failed add_key(prime): %s\n",
> +                       strerror(errno));
> +               exit(6);
> +       }
> +
> +       base =3D add_key("user", "base", payload, strlen(payload),
> +                      KEY_SPEC_PROCESS_KEYRING);
> +       if (base < 0) {
> +               fprintf(stderr, "Failed add_key(base): %s\n",
> +                       strerror(errno));
> +               exit(7);
> +       }
> +
> +       if (verbose) {
> +               printf("Private key ID: 0x%x\n", private);
> +               printf("Prime key ID:   0x%x\n", prime);
> +               printf("Base key ID:    0x%x\n", base);
> +       }
> +
> +       /* Requires key { search }. From kernel 5.3 also requires { link =
} */
> +       retrieved =3D request_key("user", "private", NULL,
> +                               KEY_SPEC_PROCESS_KEYRING);
> +       if (retrieved < 0) {
> +               fprintf(stderr, "Failed to request 'private' key: %s\n",
> +                       strerror(errno));
> +               exit(8);
> +       }
> +
> +       /* Requires key { search } */
> +       search =3D keyctl(KEYCTL_SEARCH, KEY_SPEC_PROCESS_KEYRING, "user"=
,
> +                       "base", 0);
> +       if (search < 0) {
> +               fprintf(stderr, "Failed to find 'base' key: %s\n",
> +                       strerror(errno));
> +               exit(9);
> +       }
> +
> +       /* Requires key { view } */
> +       result =3D keyctl(KEYCTL_GET_SECURITY, search, r_con, sizeof(r_co=
n));
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain key context: %s\n",
> +                       strerror(errno));
> +               exit(10);
> +       }
> +
> +       if (verbose) {
> +               printf("Requested 'private' key ID: 0x%x\n", retrieved);
> +               printf("Searched 'base' key ID:     0x%x\n", search);
> +               printf("Searched 'base' key context:\n\t%s\n", r_con);
> +       }
> +
> +       /* Compute DH key, only obtain the length for test, not the key. =
*/
> +       params.priv =3D private;
> +       params.prime =3D prime;
> +       params.base =3D base;
> +
> +       /* Requires key { create read write } */
> +       compute =3D keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
> +       if (compute < 0) {
> +               fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
> +                       strerror(errno));
> +               exit(11);
> +       }
> +       if (verbose)
> +               printf("KEYCTL_DH_COMPUTE key ID size: %d\n", compute);
> +
> +       /* To test key { link }, need to generate a new keyring ID first =
*/
> +       newring =3D add_key("keyring", "my-keyring", NULL, 0,
> +                         KEY_SPEC_THREAD_KEYRING);
> +       if (newring < 0) {
> +               fprintf(stderr, "Failed to add new keyring: %s\n",
> +                       strerror(errno));
> +               exit(12);
> +       }
> +       if (verbose)
> +               printf("New keyring ID: 0x%x\n", newring);
> +
> +       /* Requires key { write link } */
> +       link =3D keyctl(KEYCTL_LINK, base, newring);
> +       if (link < 0) {
> +               fprintf(stderr, "Failed KEYCTL_LINK: %s\n",
> +                       strerror(errno));
> +               exit(13);
> +       }
> +       if (verbose)
> +               printf("Link key ID:    0x%x\n", newring);
> +
> +       /* Requires key { setattr } */
> +       link =3D keyctl(KEYCTL_RESTRICT_KEYRING, newring, NULL, NULL);
> +       if (link < 0) {
> +               fprintf(stderr, "Failed KEYCTL_RESTRICT_KEYRING: %s\n",
> +                       strerror(errno));
> +               exit(14);
> +       }
> +       if (verbose)
> +               printf("Restricted keyring\n");
> +
> +       /* Requires key { search } from 5.X key { inval } */
> +       test_key =3D keyctl(KEYCTL_INVALIDATE, private);
> +       if (test_key < 0) {
> +               fprintf(stderr, "Failed KEYCTL_INVALIDATE(private): %s\n"=
,
> +                       strerror(errno));
> +               exit(15);
> +       }
> +       if (verbose)
> +               printf("Invalidated 'private' key\n");
> +
> +       /* Requires key { write setattr } from 5.X key { revoke } */
> +       test_key =3D keyctl(KEYCTL_REVOKE, prime);
> +       if (test_key < 0) {
> +               fprintf(stderr, "Failed KEYCTL_REVOKE(prime): %s\n",
> +                       strerror(errno));
> +               exit(16);
> +       }
> +       if (verbose)
> +               printf("Revoked 'prime' key\n");
> +
> +       /* Requires key { write } from 5.X key { clear } */
> +       test_key =3D keyctl(KEYCTL_CLEAR, newring);
> +       if (test_key < 0) {
> +               fprintf(stderr, "Failed KEYCTL_CLEAR(newring): %s\n",
> +                       strerror(errno));
> +               exit(17);
> +       }
> +       if (verbose)
> +               printf("Cleared 'newring' keyring\n");
> +
> +       /* To test key { join }, need to join session first */
> +       test_key =3D keyctl(KEYCTL_JOIN_SESSION_KEYRING, "user");
> +       if (test_key < 0) {
> +               fprintf(stderr, "Failed KEYCTL_JOIN_SESSION_KEYRING,: %s\=
n",
> +                       strerror(errno));
> +               exit(18);
> +       }
> +       /* Requires key { link } from 5.X key { join } */
> +       test_key =3D keyctl(KEYCTL_SESSION_TO_PARENT);
> +       if (test_key < 0) {
> +               fprintf(stderr, "Failed KEYCTL_SESSION_TO_PARENT: %s\n",
> +                       strerror(errno));
> +               exit(19);
> +       }
> +       if (verbose)
> +               printf("Joined session to parent\n");
> +
> +       return 0;
> +}
> diff --git a/tests/keys/keyctl_relabel.c b/tests/keys/keyctl_relabel.c
> new file mode 100644
> index 0000000..0276c7a
> --- /dev/null
> +++ b/tests/keys/keyctl_relabel.c
> @@ -0,0 +1,93 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <keyutils.h>
> +#include <selinux/selinux.h>
> +
> +static void usage(char *progname)
> +{
> +       fprintf(stderr,
> +               "usage:  %s [-v] newcon\n"
> +               "Where:\n\t"
> +               "-v      Print information.\n\t"
> +               "newcon  New keyring context.\n", progname);
> +       exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int opt, result;
> +       char *context, *keycreate_con;
> +       char r_con[256];
> +       bool verbose =3D false;
> +       key_serial_t newring;
> +
> +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> +               switch (opt) {
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +               }
> +       }
> +
> +       if (optind >=3D argc)
> +               usage(argv[0]);
> +
> +       result =3D getcon(&context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain process context\n");
> +               exit(1);
> +       }
> +       if (verbose)
> +               printf("Process context: %s\n", context);
> +       free(context);
> +
> +       result =3D setkeycreatecon(argv[optind]);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed setkeycreatecon(): %s\n",
> +                       strerror(errno));
> +               exit(2);
> +       }
> +
> +       result =3D getkeycreatecon(&keycreate_con);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain keycreate context\n");
> +               exit(3);
> +       }
> +       if (verbose)
> +               printf("New keycreate context: %s\n", keycreate_con);
> +       free(keycreate_con);
> +
> +       newring =3D add_key("keyring", "my-keyring", NULL, 0,
> +                         KEY_SPEC_THREAD_KEYRING);
> +       if (newring < 0) {
> +               fprintf(stderr, "Failed to add new keyring: %s\n",
> +                       strerror(errno));
> +               exit(4);
> +       }
> +
> +       result =3D keyctl(KEYCTL_GET_SECURITY, newring, r_con, sizeof(r_c=
on));
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain key context: %s\n",
> +                       strerror(errno));
> +               exit(5);
> +       }
> +
> +       if (strcmp(argv[optind], r_con)) {
> +               fprintf(stderr, "Relabel error - expected: %s got: %s\n",
> +                       argv[optind], r_con);
> +               exit(6);
> +       }
> +
> +       if (verbose) {
> +               printf("'my-keyring' key ID: 0x%x\n", newring);
> +               printf("'my-keyring' context:\n\t%s\n", r_con);
> +       }
> +
> +       return 0;
> +}
> diff --git a/tests/keys/test b/tests/keys/test
> new file mode 100755
> index 0000000..4916e7c
> --- /dev/null
> +++ b/tests/keys/test
> @@ -0,0 +1,98 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir =3D $0;
> +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +    $test_count =3D 13;
> +
> +    # allow info to be shown during tests
> +    $v =3D $ARGV[0];
> +    if ($v) {
> +        if ( $v ne "-v" ) {
> +            plan skip_all =3D> "Invalid option (use -v)";
> +        }
> +    }
> +    else {
> +        $v =3D " ";
> +    }
> +
> +    # From kernel 5.3 request_key() requires additional check of key { l=
ink }
> +    $kvercur =3D `uname -r`;
> +    chomp($kvercur);
> +    $kverminstream =3D "5.3";
> +    $test_link_53  =3D 0;
> +
> +    $result =3D `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $result >=3D 0 ) {
> +        $test_link_53 =3D 1;
> +    }
> +
> +    plan tests =3D> $test_count;
> +}
> +
> +############ Test keyctl #############
> +print "Test key class permissions\n";
> +$result =3D system "runcon -t test_key_t $basedir/keyctl $v";
> +ok( $result eq 0 );
> +
> +# Deny process { setkeycreate }
> +$result =3D system "runcon -t test_no_setkeycreate_t $basedir/keyctl $v =
2>&1";
> +ok( $result >> 8 eq 3 );
> +
> +# Deny key { create }
> +$result =3D system "runcon -t test_key_no_create_t $basedir/keyctl $v 2>=
&1";
> +ok( $result >> 8 eq 3 );
> +
> +# Deny key { write }
> +$result =3D system "runcon -t test_key_no_write_t $basedir/keyctl $v 2>&=
1";
> +ok( $result >> 8 eq 5 );
> +
> +# Deny key { search }
> +$result =3D system "runcon -t test_key_no_search_t $basedir/keyctl $v 2>=
&1";
> +ok( $result >> 8 eq 8 );
> +
> +# Deny key { view }
> +$result =3D system "runcon -t test_key_no_view_t $basedir/keyctl $v 2>&1=
";
> +ok( $result >> 8 eq 10 );
> +
> +# Deny key { read }
> +$result =3D system "runcon -t test_key_no_read_t $basedir/keyctl $v 2>&1=
";
> +ok( $result >> 8 eq 11 );
> +
> +# Deny key { link }
> +$result =3D system "runcon -t test_key_no_link_t $basedir/keyctl $v 2>&1=
";
> +if ($test_link_53) {
> +    ok( $result >> 8 eq 8 );
> +}
> +else {
> +    ok( $result >> 8 eq 13 );
> +}
> +
> +# Deny key { setattr }
> +$result =3D system "runcon -t test_key_no_setattr_t $basedir/keyctl $v 2=
>&1";
> +ok( $result >> 8 eq 14 );
> +
> +########### Change keyring context ##############
> +print "Change keyring context\n";
> +$result =3D system
> +"runcon -t test_key_t $basedir/keyctl_relabel $v system_u:system_r:test_=
newcon_key_t:s0";
> +ok( $result eq 0 );
> +
> +############ Test key_socket #############
> +print "Test key_socket class\n";
> +$result =3D system "runcon -t test_key_sock_t $basedir/key_sock $v";
> +ok( $result eq 0 );
> +
> +# Deny capability { net_admin } - EPERM
> +$result =3D
> +  system "runcon -t test_key_sock_no_net_admin_t $basedir/key_sock $v 2>=
&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny key_socket { create } - EACCES
> +$result =3D
> +  system "runcon -t test_key_sock_no_create_t $basedir/key_sock $v 2>&1"=
;
> +ok( $result >> 8 eq 13 );
> +
> +exit;
> --
> 2.21.0
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

