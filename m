Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A17CC433ED
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F411B6143E
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 08:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhDUI7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:59:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40646 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhDUI7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 04:59:21 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 24543564E51
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:58:47 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id w10so29171164pgh.5
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 01:58:47 -0700 (PDT)
X-Gm-Message-State: AOAM531gNJ/GylyRK5qH9CghV3aWRvLB3+du5A5bR/Em8/InjOtSUzuP
        P/P6BX/pY2zRJUpZI06clLZP/jDvSHFnhYU8038=
X-Google-Smtp-Source: ABdhPJzwPfkuisGsuofWMKR8jNv/wxo64t9vQhVJB82KXbCHG0+HrCfBzTsvCV1kRLoVrRERcF4nJaZ669rVFcBWoq0=
X-Received: by 2002:a62:10b:0:b029:259:fdc3:7c69 with SMTP id
 11-20020a62010b0000b0290259fdc37c69mr23503822pfb.11.1618995525809; Wed, 21
 Apr 2021 01:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210419152749.88086-1-jwcart2@gmail.com> <CAP+JOzRtCjKaXVW6jVs7k-fhZE+AkkJuP5ORUNap0r3GHy2_Sg@mail.gmail.com>
In-Reply-To: <CAP+JOzRtCjKaXVW6jVs7k-fhZE+AkkJuP5ORUNap0r3GHy2_Sg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 21 Apr 2021 10:58:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k6z6aRXtFnpzyjmkBdAYTeXouqYSePsQ-dQLxB=enHMQ@mail.gmail.com>
Message-ID: <CAJfZ7=k6z6aRXtFnpzyjmkBdAYTeXouqYSePsQ-dQLxB=enHMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] Create secil2tree to write CIL AST
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000360f9905c077c5af"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Apr 21 10:58:47 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--000000000000360f9905c077c5af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 7:08 PM James Carter <jwcart2@gmail.com> wrote:
>
> As an example of how it can be used, I have been using secil2tree
> recently to make secilc fuzzing test cases readable.
>
> Running:
> secil2tree -A build -o fuzz_613136.cil
> clusterfuzz-testcase-minimized-secilc-fuzzer-6131368317812736
>
> The attached files shows the original and the output of secil2tree.
>
> Jim
>
> On Mon, Apr 19, 2021 at 11:27 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > For debugging purposes it would be useful to be able to write out
> > the CIL AST at various points in the build process.
> >
> > This patch set creates secil2tree which can write the CIL parse tree,
> > the CIL AST after the build phase, or the CIL AST after the resolve
> > phase (with names fully-qualified).
> >
> > Within CIL the function cil_print_tree() has existed from early in
> > CIL's development, but it was not exported in libsepol and there was no
> > way to use it except by adding a call to it where you wanted to print
> > out the CIL AST and then recompiling everything. It also used cil_log()
> > as its output, so other messages could be mixed in with the output. Thi=
s
> > patch set moves all of this code to its own file, updates it, renames i=
t
> > as cil_write_ast(), and adds libsepol functions that can be used to cal=
l
> > it after each one of the phases mentioned above.
> >
> > Both the parse and build CIL AST are valid CIL policies that can be
> > compiled with secilc, but the resolve CIL AST is not always a valid CIL
> > policy. The biggest problem is that fully-qualified names can contain
> > dots and CIL does not allow dots in declaration names. There are other
> > problems as well. It would be nice to get to the point where the output
> > for all of the trees are valid CIL, but that is a goal for the future.
> >
> > v2:
> > - Remove whitespace errors in cil_write_ast.h
> > - Use "const char*" instead of just "char*" when dealing with string
> > literals to satisfy clang.
> >
> > James Carter (3):
> >   libsepol/cil: Create functions to write the CIL AST
> >   libsepol/cil: Add functions to make use of cil_write_ast()
> >   secilc: Create the new program called secil2tree to write out CIL AST
> >
> >  libsepol/cil/include/cil/cil.h   |    3 +
> >  libsepol/cil/src/cil.c           |   92 ++
> >  libsepol/cil/src/cil_tree.c      | 1471 ----------------------------
> >  libsepol/cil/src/cil_tree.h      |    2 -
> >  libsepol/cil/src/cil_write_ast.c | 1573 ++++++++++++++++++++++++++++++
> >  libsepol/cil/src/cil_write_ast.h |   46 +
> >  libsepol/src/libsepol.map.in     |    3 +
> >  secilc/.gitignore                |    2 +
> >  secilc/Makefile                  |   20 +-
> >  secilc/secil2tree.8.xml          |   81 ++
> >  secilc/secil2tree.c              |  206 ++++
> >  11 files changed, 2024 insertions(+), 1475 deletions(-)
> >  create mode 100644 libsepol/cil/src/cil_write_ast.c
> >  create mode 100644 libsepol/cil/src/cil_write_ast.h
> >  create mode 100644 secilc/secil2tree.8.xml
> >  create mode 100644 secilc/secil2tree.c
> >
> > --
> > 2.26.3
> >

Hello,
Thanks for this tool! It looks great and it seems to work quite well.

Anyway, while building with some warning flags, gcc reported issues
about using non-const pointers to hold literal strings. For example:

../cil/src/cil_write_ast.c: In function =E2=80=98datum_to_str=E2=80=99:
../cil/src/cil_write_ast.c:51:28: error: return discards =E2=80=98const=E2=
=80=99
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
   51 |  return datum ? datum->fqn : "<?DATUM>";
      |         ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
../cil/src/cil_write_ast.c: In function =E2=80=98write_expr=E2=80=99:
../cil/src/cil_write_ast.c:122:12: error: assignment discards =E2=80=98cons=
t=E2=80=99
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
  122 |     op_str =3D "<?OP>";
      |            ^

With the attached patch, the code compiles fine. Feel free to directly
modify the first patch with these fixes.

Thanks,
Nicolas

--000000000000360f9905c077c5af
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-Fix-Wdiscarded-qualifiers-issues.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-Wdiscarded-qualifiers-issues.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_knr81f220>
X-Attachment-Id: f_knr81f220

RnJvbSA1MDlhZmZhMDM3M2I3ODRhNzI2ZjUxZWYxZjE4NDZmMWVmYTIzMjdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNvbGFzIElvb3NzIDxuaWNvbGFzLmlvb3NzQG00eC5vcmc+
CkRhdGU6IFR1ZSwgMjAgQXByIDIwMjEgMTY6MzM6MDEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBG
aXggLVdkaXNjYXJkZWQtcXVhbGlmaWVycyBpc3N1ZXMKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rp
bmc6IDhiaXQKCkJ1aWxzIHdpdGggJ2djYyAtV2Rpc2NhcmRlZC1xdWFsaWZpZXJzJyBsZWFkcyB0
byBlcnJvcnMgc3VjaCBhczoKCiAgICAuLi9jaWwvc3JjL2NpbF93cml0ZV9hc3QuYzogSW4gZnVu
Y3Rpb24g4oCYZGF0dW1fdG9fc3Ry4oCZOgogICAgLi4vY2lsL3NyYy9jaWxfd3JpdGVfYXN0LmM6
NTE6Mjg6IGVycm9yOiByZXR1cm4gZGlzY2FyZHMg4oCYY29uc3TigJkKICAgIHF1YWxpZmllciBm
cm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAg
ICAgICA1MSB8ICByZXR1cm4gZGF0dW0gPyBkYXR1bS0+ZnFuIDogIjw/REFUVU0+IjsKICAgICAg
ICAgIHwgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+Xn5+fn5+fn5+fn5+CgogICAgLi4vY2ls
L3NyYy9jaWxfd3JpdGVfYXN0LmM6IEluIGZ1bmN0aW9uIOKAmHdyaXRlX2V4cHLigJk6CiAgICAu
Li9jaWwvc3JjL2NpbF93cml0ZV9hc3QuYzoxMjI6MTI6IGVycm9yOiBhc3NpZ25tZW50IGRpc2Nh
cmRzCiAgICDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlCiAg
ICBbLVdlcnJvcj1kaXNjYXJkZWQtcXVhbGlmaWVyc10KICAgICAgMTIyIHwgICAgIG9wX3N0ciA9
ICI8P09QPiI7CiAgICAgICAgICB8ICAgICAgICAgICAgXgoKU2lnbmVkLW9mZi1ieTogTmljb2xh
cyBJb29zcyA8bmljb2xhcy5pb29zc0BtNHgub3JnPgotLS0KIGxpYnNlcG9sL2NpbC9zcmMvY2ls
X3dyaXRlX2FzdC5jIHwgMTIgKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2NpbC9zcmMvY2ls
X3dyaXRlX2FzdC5jIGIvbGlic2Vwb2wvY2lsL3NyYy9jaWxfd3JpdGVfYXN0LmMKaW5kZXggNmNi
NTY3YTY5ZDViLi42MmZhZWZlMzFkZWUgMTAwNjQ0Ci0tLSBhL2xpYnNlcG9sL2NpbC9zcmMvY2ls
X3dyaXRlX2FzdC5jCisrKyBiL2xpYnNlcG9sL2NpbC9zcmMvY2lsX3dyaXRlX2FzdC5jCkBAIC00
MSwxMiArNDEsMTIgQEAKICNpbmNsdWRlICJjaWxfd3JpdGVfYXN0LmgiCiAKIAotc3RhdGljIGlu
bGluZSBjaGFyICpkYXR1bV9vcl9zdHIoc3RydWN0IGNpbF9zeW10YWJfZGF0dW0gKmRhdHVtLCBj
aGFyICpzdHIpCitzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKmRhdHVtX29yX3N0cihzdHJ1Y3Qg
Y2lsX3N5bXRhYl9kYXR1bSAqZGF0dW0sIGNvbnN0IGNoYXIgKnN0cikKIHsKIAlyZXR1cm4gZGF0
dW0gPyBkYXR1bS0+ZnFuIDogc3RyOwogfQogCi1zdGF0aWMgaW5saW5lIGNoYXIgKmRhdHVtX3Rv
X3N0cihzdHJ1Y3QgY2lsX3N5bXRhYl9kYXR1bSAqZGF0dW0pCitzdGF0aWMgaW5saW5lIGNvbnN0
IGNoYXIgKmRhdHVtX3RvX3N0cihzdHJ1Y3QgY2lsX3N5bXRhYl9kYXR1bSAqZGF0dW0pCiB7CiAJ
cmV0dXJuIGRhdHVtID8gZGF0dW0tPmZxbiA6ICI8P0RBVFVNPiI7CiB9CkBAIC04Miw3ICs4Miw3
IEBAIHN0YXRpYyB2b2lkIHdyaXRlX2V4cHIoRklMRSAqb3V0LCBzdHJ1Y3QgY2lsX2xpc3QgKmV4
cHIpCiAJCQlmcHJpbnRmKG91dCwgIiVzIiwgZGF0dW1fdG9fc3RyKGN1cnItPmRhdGEpKTsKIAkJ
CWJyZWFrOwogCQljYXNlIENJTF9PUDogewotCQkJY2hhciAqb3Bfc3RyID0gTlVMTDsKKwkJCWNv
bnN0IGNoYXIgKm9wX3N0ciA9IE5VTEw7CiAJCQllbnVtIGNpbF9mbGF2b3Igb3BfZmxhdm9yID0g
KGVudW0gY2lsX2ZsYXZvciljdXJyLT5kYXRhOwogCQkJc3dpdGNoIChvcF9mbGF2b3IpIHsKIAkJ
CWNhc2UgQ0lMX0FORDoKQEAgLTEyNiw3ICsxMjYsNyBAQCBzdGF0aWMgdm9pZCB3cml0ZV9leHBy
KEZJTEUgKm91dCwgc3RydWN0IGNpbF9saXN0ICpleHByKQogCQkJYnJlYWs7CiAJCX0KIAkJY2Fz
ZSBDSUxfQ09OU19PUEVSQU5EOiB7Ci0JCQljaGFyICpvcGVyYW5kX3N0ciA9IE5VTEw7CisJCQlj
b25zdCBjaGFyICpvcGVyYW5kX3N0ciA9IE5VTEw7CiAJCQllbnVtIGNpbF9mbGF2b3Igb3BlcmFu
ZF9mbGF2b3IgPSAoZW51bSBjaWxfZmxhdm9yKWN1cnItPmRhdGE7CiAJCQlzd2l0Y2ggKG9wZXJh
bmRfZmxhdm9yKSB7CiAJCQljYXNlIENJTF9DT05TX1UxOgpAQCAtNDkwLDkgKzQ5MCw5IEBAIHN0
YXRpYyB2b2lkIHdyaXRlX2NhbGxfYXJnc190cmVlKEZJTEUgKm91dCwgc3RydWN0IGNpbF90cmVl
X25vZGUgKmFyZ19ub2RlKQogCX0KIH0KIAotc3RhdGljIGNoYXIgKl9fbWFjcm9fcGFyYW1fZmxh
dm9yX3RvX3N0cmluZyhlbnVtIGNpbF9mbGF2b3IgZmxhdm9yKQorc3RhdGljIGNvbnN0IGNoYXIg
Kl9fbWFjcm9fcGFyYW1fZmxhdm9yX3RvX3N0cmluZyhlbnVtIGNpbF9mbGF2b3IgZmxhdm9yKQog
ewotCWNoYXIgKnN0ciA9IE5VTEw7CisJY29uc3QgY2hhciAqc3RyID0gTlVMTDsKIAlzd2l0Y2go
Zmxhdm9yKSB7CiAJY2FzZSBDSUxfVFlQRToKIAkJc3RyID0gQ0lMX0tFWV9UWVBFOwotLSAKMi4z
MS4wCgo=
--000000000000360f9905c077c5af--

