Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7130275A
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905159; cv=none; b=rH2XF1FAGr64XyiR5/xt6DaOe0Vj9sMre/guNk3IhY7e/PYyTmB+AJZwIcqgkwHfHLMT1rIfS60TaHDWDCzazE+Hd/vdOjI8nosyVy3dZVKy5yjX36lOMEhAHDhK63BM60/N/Xav5t/s1UKJ5ZK5p2B2U86Bt7ui9ELYRegJCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905159; c=relaxed/simple;
	bh=5eN9YYsIajt0vEAlwCpsXXYaNjqKy/ydu7NDajX7Vfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk5wExTsxBC6FWLavM67ThZChrcHcw5OxF3l0nQzyVd2MOd8gVz0l+YVsYMB/MuGVRmAPtCCoBewBUPmzs5kvftYs8+VSPJfdpXXbp7/LEfBE4PwgbbVJUyF+/wl8jNl935Hs7F/YHbiEdk4Fa7CoEnLFI8b4iqhQLXjQCf0BtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOC1ti57; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOC1ti57"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24af8cd99ddso30178835ad.0
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756905155; x=1757509955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOYIlElV5x5DS9TUkA5qu6vgRMcrBaVq+AN4CTq4VT4=;
        b=gOC1ti577fYJeNWArN4zY5XnFbH33BgK/qkL0/Mj5onsTFLGzRZVJBm472L4VL+3yk
         XUEou12DaL5jkF8A4JLmuwV3k0I4RHfNMTp0g3u9vWTCwaSPcAQl+LWWaI65RWVpSD6R
         Y35gJ7Bal5gL2QlQp4UQMqf5x+lObeHhfV3RnReY7hF20QHdY/935tjVxoiYO/rslbMV
         BJnsOPzSWK3XwpwcWCzje86S1S9T5quFObACjFxSyIV4L93D5WsNRuGjdC8ifJ/5M272
         i72fYzY/FwrtOyglf2odP+bbkxP5YqM9rZ8w9oyJZIDknStQ9RcrQN8gpPIK1rj6OSJL
         +dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905155; x=1757509955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOYIlElV5x5DS9TUkA5qu6vgRMcrBaVq+AN4CTq4VT4=;
        b=F+tc7OLXZ3NS0isk3S3zF1+wEEppkHy0K/11EJnikUL7TWBxB6cIwA64cwSucrCMt+
         TPcsa2q58rU2DVe4Ct4eWCTfL/GtNKKASO2ytmxQgNGmxrMg4DARKmGBI/X4IgvbohDE
         7nU4tGLkPPiLtFkp5HUsi8z/s541wmoBvut6hvOxGZWbUqqXgDCh7hejuNt1HF+cDkvY
         ySZb7tGGhr23/IWfGQrV/cB5R5tCqC5VwLT8qpnBAWRHI5sf9eLT7vBRHP+HmgIFx7z4
         IAwouRn4Lu0/lAfcAkUc5HNuFeWluZXhth/RaCr5lAHSfVJrg4ZNIhn2NZM0TU11L0F6
         4xIA==
X-Gm-Message-State: AOJu0YzN8WXhMvDrCtHQ+DH4lLklu7kwoB2W0Wve6CB1FnyzWWiydOeq
	fQIQ22QqYzVBtd8u4osnotkp9JQJuWQnpXsnJdY6msUJDKRsXjy3Yqg2kEmib0shl5WeMo4Ok7B
	u34L8XmZvN3I9dEUoa7C4r2AYn9MPu1E=
X-Gm-Gg: ASbGncthvU+nHyWmkXKLBwyIyfQALOJk/v+aYLg/zBgOzY/MrIshVDCSQDdmU08BB7B
	HjOIilBuXZ0+h3aKESj26lc6+kOQz0WckgYLExNmt2md4HZ7UDMbOkvqtGO/fg4rqC+riQQbDPu
	DmHe8Z9nDyjgqhS8K4NBaGHxilRS0d0Kr/rE/DdLMMDArW54LqvAvLbh7/+RQNwIBq7FFpAlxUe
	GkXBY97aDxjZ7wJSg==
X-Google-Smtp-Source: AGHT+IHQLRFoKwcXMQ7ODC5hVlIJ5YJWjmMceU9fhaSan1oxsLQf3n05X9Dkb07iJChifTvE7TxzsNXtEATTLQ0MnMg=
X-Received: by 2002:a17:902:ecc6:b0:249:1440:5999 with SMTP id
 d9443c01a7336-24944b90a10mr202022485ad.61.1756905154691; Wed, 03 Sep 2025
 06:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829181746.1727-1-ericsu@linux.microsoft.com>
 <CAEjxPJ5+kru_a1uUh1_F6vqVnpCzsLHYFaTe_V71D7AmxS0rug@mail.gmail.com> <CAEjxPJ6eNvr3z6cvCnNtoqgyL2dAiVnNBSuAhxKf14FxBTZB_w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6eNvr3z6cvCnNtoqgyL2dAiVnNBSuAhxKf14FxBTZB_w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Sep 2025 09:12:23 -0400
X-Gm-Features: Ac12FXxFrljmJ7LrfXho9Q8rM7fZm9gfzbpwq0dtBUqTVqQViKtYNJ8X_2RhThg
Message-ID: <CAEjxPJ5Zq9cnYJEnHsawZuQyTJ=QyhMHdBnuj1fwLtNwrih+VA@mail.gmail.com>
Subject: Re: [PATCH testsuite v4] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 2, 2025 at 10:09=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 29, 2025 at 2:17=E2=80=AFPM Eric Suen <ericsu@linux.microso=
ft.com> wrote:
> > >
> > > This patch adds new tests to verify the SELinux support for BPF token
> > > access control, as introduced in the corresponding kernel patch:
> > >   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.m=
icrosoft.com/
> >
> > No need to re-spin just for this, but I would have also provided the
> > link to the libsepol patch on which this depends.
> > Just for future reference if you need to re-spin this for other
> > reasons or for future patches.
> >
> > > Four new tests are added to cover both positive and negative scenario=
s,
> > > ensuring that the SELinux policy enforcement on BPF token usage behav=
es
> > > as expected.
> > >   - Successful map_create and prog_load when SELinux permissions are
> > >     granted.
> > >   - Enforcement of SELinux policy restrictions when access is denied.
> > >
> > > For testing purposes, you can update the base policy by manually
> > > modifying your base module and tweaking /usr/share/selinux/devel as
> > > follows:
> > >   sudo semodule -c -E base
> > >   sudo cp base.cil base.cil.orig
> > >   sudo sed -i "s/map_create/map_create map_create_as/" base.cil
> > >   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
> > >   sudo semodule -i base.cil
> > >   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
> > >   sudo semodule -i bpf_token_perms.cil
> > >   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
> > >       /usr/share/selinux/devel/include/support/all_perms.spt.orig
> > >   sudo sed -i "s/map_create/map_create map_create_as/" \
> > >       /usr/share/selinux/devel/include/support/all_perms.spt
> > >   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
> > >       /usr/share/selinux/devel/include/support/all_perms.spt
> > >
> > > When finished testing, you can semodule -r base bpf_token_perms to
> > > undo the two module changes and restore your all_perms.spt file from
> > > the saved .orig file.
> > >
> > > Changes in v2:
> > > - Removed allow rule for 'kernel_t' in test_bpf.te which was added du=
e
> > >   to a bug in the kernel
> > > - Cleaned up other unnecessary rules in test_bpf.te
> > > - Added token_test.c which was missing from previous patch
> > >
> > > Changes in v3:
> > > - Added original license in 'token_test.c'
> > > - Updated patch description to
> > >     - replace 'base.sil' with 'base.cil'
> > >     - Remove extra quotation mark in 'sudo 'sed -i "s/"map_create'
> > >
> > > Changes in v4:
> > > - Updated 'token_test.c' to write error messages only when DEBUG
> > >   is defined
> >
> > Likewise, no need to re-spin just for this, but for future patches,
> > please put the Changelog below the "---" line just prior to the
> > diffstat output.
> > This allows the reviewer to see it for review purposes but omits it
> > from the final commit message since it ceases to be relevant once a
> > patch is merged.
>
> One item that will need to be fixed before this is merged is adding
> conditional guards to the policy/Makefile and tests/bpf/test so the
> policy rules with the new permissions are omitted if the policy
> headers do not yet define them and the tests are skipped if the loaded
> policy doesn't include the definitions. You can see existing examples
> of this elsewhere in the testsuite.

Likely the easiest way to handle this for the policy rules would be to
split the new rules into a separate .te file, e.g. test_bpf_token.te,
and then the policy/Makefile can just omit it entirely if the
requisite permission definitions and policy capability are not defined
(see the nlmsg test dependencies in policy/Makefile for an example but
note that your change does not depend on a specific policy version
number so those checks can be omitted). For the test itself, you can
follow the example of tests/nnp_nosuid/test, which checks to see if a
policy capability is defined and if so, enables additional tests to
run, and do likewise for your additions to tests/bpf/test.

>
> >
> > >
> > > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > > ---
> > >  policy/test_bpf.te     |  39 +++
> > >  tests/bpf/Makefile     |   5 +-
> > >  tests/bpf/bpf_common.h |  10 +
> > >  tests/bpf/bpf_test.c   |  59 +++--
> > >  tests/bpf/test         |  21 +-
> > >  tests/bpf/token_test.c | 559 +++++++++++++++++++++++++++++++++++++++=
++
> > >  6 files changed, 674 insertions(+), 19 deletions(-)
> > >  create mode 100644 tests/bpf/token_test.c
> > >
> > > diff --git a/policy/test_bpf.te b/policy/test_bpf.te
> > > index 5eab0bd..45da852 100644
> > > --- a/policy/test_bpf.te
> > > +++ b/policy/test_bpf.te
> > > @@ -57,3 +57,42 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
> > >  allow test_bpf_deny_prog_run_t self:process { setrlimit };
> > >  allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_ad=
min };
> > >  allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_wr=
ite prog_load };
> > > +
> > > +################### Allow map_create_as and prog_load_as ###########=
########
> > > +fs_list_bpf_dirs(test_bpf_t)
> > > +allow test_bpf_t bpf_t:filesystem mount;
> > > +allow test_bpf_t root_t:dir mounton;
> > > +allow test_bpf_t self:bpf { map_create_as prog_load_as };
> > > +allow test_bpf_t self:cap2_userns { bpf perfmon };
> > > +allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin=
 };
> > > +allow test_bpf_t self:user_namespace create;
> > > +
> > > +############################ Deny map_create_as ####################=
########
> > > +type test_bpf_deny_map_create_as_t;
> > > +testsuite_domain_type(test_bpf_deny_map_create_as_t)
> > > +typeattribute test_bpf_deny_map_create_as_t bpfdomain;
> > > +allow test_bpf_deny_map_create_as_t self:process { setrlimit };
> > > +allow test_bpf_deny_map_create_as_t self:capability { sys_resource s=
ys_admin };
> > > +
> > > +fs_list_bpf_dirs(test_bpf_deny_map_create_as_t)
> > > +allow test_bpf_deny_map_create_as_t bpf_t:filesystem mount;
> > > +allow test_bpf_deny_map_create_as_t root_t:dir mounton;
> > > +allow test_bpf_deny_map_create_as_t self:bpf { map_create map_read m=
ap_write prog_load prog_load_as };
> > > +allow test_bpf_deny_map_create_as_t self:cap2_userns { bpf };
> > > +allow test_bpf_deny_map_create_as_t self:cap_userns { setgid setuid =
sys_admin };
> > > +allow test_bpf_deny_map_create_as_t self:user_namespace create;
> > > +
> > > +############################ Deny prog_load_as #####################=
########
> > > +type test_bpf_deny_prog_load_as_t;
> > > +testsuite_domain_type(test_bpf_deny_prog_load_as_t)
> > > +typeattribute test_bpf_deny_prog_load_as_t bpfdomain;
> > > +allow test_bpf_deny_prog_load_as_t self:process { setrlimit };
> > > +allow test_bpf_deny_prog_load_as_t self:capability { sys_resource sy=
s_admin };
> > > +
> > > +fs_list_bpf_dirs(test_bpf_deny_prog_load_as_t)
> > > +allow test_bpf_deny_prog_load_as_t bpf_t:filesystem mount;
> > > +allow test_bpf_deny_prog_load_as_t root_t:dir mounton;
> > > +allow test_bpf_deny_prog_load_as_t self:bpf { map_create map_create_=
as map_read map_write prog_load };
> > > +allow test_bpf_deny_prog_load_as_t self:cap2_userns { bpf perfmon };
> > > +allow test_bpf_deny_prog_load_as_t self:cap_userns { net_admin setgi=
d setuid sys_admin };
> > > +allow test_bpf_deny_prog_load_as_t self:user_namespace create;
> > > diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> > > index 1ae8ce9..cacefbe 100644
> > > --- a/tests/bpf/Makefile
> > > +++ b/tests/bpf/Makefile
> > > @@ -1,5 +1,5 @@
> > >  TARGETS =3D bpf_test
> > > -DEPS =3D bpf_common.c bpf_common.h
> > > +SRCS =3D bpf_test.c bpf_common.c token_test.c
> > >  LDLIBS +=3D -lselinux -lbpf
> > >
> > >  # export so that BPF_ENABLED entries get built correctly on local bu=
ild
> > > @@ -14,4 +14,5 @@ clean:
> > >         rm -f $(TARGETS) test_sock flag *_flag
> > >         @set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; d=
one
> > >
> > > -$(TARGETS): $(DEPS)
> > > +$(TARGETS): $(SRCS)
> > > +       $(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
> > > \ No newline at end of file
> > > diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
> > > index 44ac28f..adba522 100644
> > > --- a/tests/bpf/bpf_common.h
> > > +++ b/tests/bpf/bpf_common.h
> > > @@ -12,6 +12,8 @@
> > >  extern int create_bpf_map(void);
> > >  extern int create_bpf_prog(void);
> > >  extern void bpf_setrlimit(void);
> > > +extern int test_bpf_map_create(void);
> > > +extern int test_bpf_prog_load(void);
> > >
> > >  /* edited eBPF instruction library */
> > >  /* Short form of mov, dst_reg =3D imm32 */
> > > @@ -32,3 +34,11 @@ extern void bpf_setrlimit(void);
> > >                                                .off   =3D 0,         =
             \
> > >                                                         .imm   =3D 0 =
})
> > >
> > > +/* Raw code statement block */
> > > +#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)                 \
> > > +       ((struct bpf_insn) {                                    \
> > > +               .code  =3D CODE,                                  \
> > > +                       .dst_reg =3D DST,                            =
     \
> > > +                               .src_reg =3D SRC,                    =
             \
> > > +                                       .off   =3D OFF,              =
                     \
> > > +                                               .imm   =3D IMM })
> > > diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
> > > index 3c6a29c..a8dc383 100644
> > > --- a/tests/bpf/bpf_test.c
> > > +++ b/tests/bpf/bpf_test.c
> > > @@ -1,28 +1,38 @@
> > >  #include "bpf_common.h"
> > >
> > > +#define write_verbose(verbose, fmt, ...) \
> > > +       do { \
> > > +               if (verbose) \
> > > +                       printf(fmt "\n", ##__VA_ARGS__); \
> > > +       } while (0)
> > > +
> > >  static void usage(char *progname)
> > >  {
> > >         fprintf(stderr,
> > > -               "usage:  %s -m|-p [-v]\n"
> > > +               "usage:  %s -m|-p|-c|-l [-v]\n"
> > >                 "Where:\n\t"
> > >                 "-m    Create BPF map fd\n\t"
> > >                 "-p    Create BPF prog fd\n\t"
> > > +               "-c    Test BPF token map create\n\t"
> > > +               "-l    Test BPF token program load\n\t"
> > >                 "-v Print information.\n", progname);
> > >         exit(-1);
> > >  }
> > >
> > >  int main(int argc, char *argv[])
> > >  {
> > > -       int opt, result, fd;
> > > -       bool verbose =3D false;
> > > +       int opt, result, ret;
> > > +       bool verbose =3D false, is_fd =3D true;
> > >         char *context;
> > >
> > >         enum {
> > >                 MAP_FD =3D 1,
> > > -               PROG_FD
> > > +               PROG_FD,
> > > +               MAP_CREATE,
> > > +               PROG_LOAD,
> > >         } bpf_fd_type;
> > >
> > > -       while ((opt =3D getopt(argc, argv, "mpv")) !=3D -1) {
> > > +       while ((opt =3D getopt(argc, argv, "mpclv")) !=3D -1) {
> > >                 switch (opt) {
> > >                 case 'm':
> > >                         bpf_fd_type =3D MAP_FD;
> > > @@ -30,6 +40,12 @@ int main(int argc, char *argv[])
> > >                 case 'p':
> > >                         bpf_fd_type =3D PROG_FD;
> > >                         break;
> > > +               case 'c':
> > > +                       bpf_fd_type =3D MAP_CREATE;
> > > +                       break;
> > > +               case 'l':
> > > +                       bpf_fd_type =3D PROG_LOAD;
> > > +                       break;
> > >                 case 'v':
> > >                         verbose =3D true;
> > >                         break;
> > > @@ -44,8 +60,7 @@ int main(int argc, char *argv[])
> > >                 exit(-1);
> > >         }
> > >
> > > -       if (verbose)
> > > -               printf("Process context:\n\t%s\n", context);
> > > +       write_verbose(verbose, "Process context:\n\n%s", context);
> > >
> > >         free(context);
> > >
> > > @@ -54,24 +69,36 @@ int main(int argc, char *argv[])
> > >
> > >         switch (bpf_fd_type) {
> > >         case MAP_FD:
> > > -               if (verbose)
> > > -                       printf("Creating BPF map\n");
> > > +               write_verbose(verbose, "Creating BPF map");
> > >
> > > -               fd =3D create_bpf_map();
> > > +               ret =3D create_bpf_map();
> > >                 break;
> > >         case PROG_FD:
> > > -               if (verbose)
> > > -                       printf("Creating BPF prog\n");
> > > +               write_verbose(verbose, "Creating BPF prog");
> > > +
> > > +               ret =3D create_bpf_prog();
> > > +               break;
> > > +       case MAP_CREATE:
> > > +               is_fd =3D false;
> > > +               write_verbose(verbose, "Testing BPF map create");
> > > +
> > > +               ret =3D test_bpf_map_create();
> > > +               break;
> > > +       case PROG_LOAD:
> > > +               is_fd =3D false;
> > > +               write_verbose(verbose, "Testing BPF prog load");
> > >
> > > -               fd =3D create_bpf_prog();
> > > +               ret =3D test_bpf_prog_load();
> > >                 break;
> > >         default:
> > >                 usage(argv[0]);
> > >         }
> > >
> > > -       if (fd < 0)
> > > -               return fd;
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       if (is_fd)
> > > +               close(ret);
> > >
> > > -       close(fd);
> > >         return 0;
> > >  }
> > > diff --git a/tests/bpf/test b/tests/bpf/test
> > > index a3fd856..14bda32 100755
> > > --- a/tests/bpf/test
> > > +++ b/tests/bpf/test
> > > @@ -9,8 +9,10 @@ BEGIN {
> > >
> > >      $test_bpf_count       =3D 7;
> > >      $test_fdreceive_count =3D 4;
> > > +    $test_bpf_token_count =3D 4;
> > >
> > > -    $test_count =3D $test_bpf_count + $test_fdreceive_count;
> > > +    $test_count =3D
> > > +      $test_bpf_count + $test_fdreceive_count + $test_bpf_token_coun=
t;
> > >
> > >      # allow info to be shown during tests
> > >      $v =3D $ARGV[0];
> > > @@ -67,6 +69,13 @@ ok( $result eq 0 );
> > >  $result =3D system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
> > >  ok( $result eq 0 );
> > >
> > > +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
> > > +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
> > > +ok( $result eq 0 );
> > > +
> > > +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
> > > +ok( $result eq 0 );
> > > +
> > >  # Deny map_create permission
> > >  $result =3D
> > >    system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m =
$v 2>&1";
> > > @@ -92,6 +101,16 @@ $result =3D
> > >    system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v=
 2>&1";
> > >  ok($result);
> > >
> > > +# BPF token - deny BPF_MAP_CREATE_AS
> > > +$result =3D
> > > +  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test =
-c $v 2>&1";
> > > +ok($result);
> > > +
> > > +# BPF token - deny BPF_PROG_LOAD_AS
> > > +$result =3D
> > > +  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -=
l $v 2>&1";
> > > +ok($result);
> > > +
> > >  #
> > >  ################ BPF Tests for fdreceive #######################
> > >  #
> > > diff --git a/tests/bpf/token_test.c b/tests/bpf/token_test.c
> > > new file mode 100644
> > > index 0000000..64f5222
> > > --- /dev/null
> > > +++ b/tests/bpf/token_test.c
> > > @@ -0,0 +1,559 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Code derived from: linux/source/tools/testing/selftests/bpf/prog_=
tests/token.c
> > > + * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
> > > + */
> > > +
> > > +#include "bpf_common.h"
> > > +#include "signal.h"
> > > +#include "linux/mount.h"
> > > +#include <linux/unistd.h>
> > > +#include "sys/wait.h"
> > > +#include "sys/socket.h"
> > > +#include "fcntl.h"
> > > +#include "sched.h"
> > > +#include <bpf/btf.h>
> > > +
> > > +#define bit(n) (1ULL << (n))
> > > +
> > > +#define zclose(fd) do { if (fd >=3D 0) close(fd); fd =3D -1; } while=
 (0)
> > > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > +
> > > +#ifdef DEBUG
> > > +#define _CHECK(condition, format...) ({    \
> > > +       int __ret =3D !!(condition); \
> > > +       int __save_errno =3D errno;   \
> > > +       if (__ret) {    \
> > > +               fprintf(stderr, ##format);   \
> > > +       }   \
> > > +       errno =3D __save_errno;   \
> > > +       __ret;  \
> > > +})
> > > +#else
> > > +#define _CHECK(condition, format...) ({    \
> > > +       int __ret =3D !!(condition); \
> > > +       __ret;  \
> > > +})
> > > +#endif
> > > +
> > > +#define ASSERT_OK(res, name) ({     \
> > > +       long long ___res =3D (res);       \
> > > +       bool ___ok =3D ___res =3D=3D 0;       \
> > > +       _CHECK(!___ok, \
> > > +                       "%s failed. unexpected error: %lld (errno %d)=
\n",  \
> > > +                        name, ___res, errno);  \
> > > +       ___ok;                          \
> > > +})
> > > +
> > > +#define ASSERT_GT(actual, expected, name) ({    \
> > > +       typeof(actual) ___act =3D (actual);   \
> > > +       typeof(expected) ___exp =3D (expected);   \
> > > +       bool ___ok =3D ___act > ___exp;       \
> > > +       _CHECK(!___ok,  \
> > > +                       "unexpected %s: actual %lld <=3D expected %ll=
d (errno %d)\n",   \
> > > +                       (name), (long long)(___act), (long long)(___e=
xp), errno);  \
> > > +       ___ok;  \
> > > +})
> > > +
> > > +#define ASSERT_GE(actual, expected, name) ({    \
> > > +       typeof(actual) ___act =3D (actual);       \
> > > +       typeof(expected) ___exp =3D (expected);   \
> > > +       bool ___ok =3D ___act >=3D ___exp;          \
> > > +       _CHECK(!___ok,  \
> > > +                       "unexpected %s: actual %lld < expected %lld (=
errno %d)\n",   \
> > > +                       (name), (long long)(___act), (long long)(___e=
xp), errno);          \
> > > +       ___ok;  \
> > > +})
> > > +
> > > +#define ASSERT_EQ(actual, expected, name) ({    \
> > > +       typeof(actual) ___act =3D (actual);           \
> > > +       typeof(expected) ___exp =3D (expected);       \
> > > +       bool ___ok =3D ___act =3D=3D ___exp;              \
> > > +       _CHECK(!___ok,   \
> > > +                       "unexpected %s: actual %lld !=3D expected %ll=
d (errno %d)\n",   \
> > > +                       (name), (long long)(___act), (long long)(___e=
xp), errno);          \
> > > +       ___ok;  \
> > > +})
> > > +
> > > +#define ASSERT_OK_PTR(ptr, name) ({     \
> > > +       const void *___res =3D (ptr);         \
> > > +       int ___err =3D libbpf_get_error(___res);  \
> > > +       bool ___ok =3D ___err =3D=3D 0;           \
> > > +       _CHECK(!___ok,  \
> > > +                       "%s unexpected error: %d\n", name, ___err);  =
\
> > > +       ___ok;      \
> > > +})
> > > +
> > > +struct bpffs_opts {
> > > +       __u64 cmds;
> > > +       __u64 maps;
> > > +       __u64 progs;
> > > +       __u64 attachs;
> > > +       const char *cmds_str;
> > > +       const char *maps_str;
> > > +       const char *progs_str;
> > > +       const char *attachs_str;
> > > +};
> > > +
> > > +typedef int (*child_callback_fn)(int bpffs_fd);
> > > +
> > > +static inline int sys_mount(const char *dev_name, const char *dir_na=
me,
> > > +                           const char *type, unsigned long flags,
> > > +                           const void *data)
> > > +{
> > > +       return syscall(__NR_mount, dev_name, dir_name, type, flags, d=
ata);
> > > +}
> > > +
> > > +static inline int sys_fsopen(const char *fsname, unsigned int flags)
> > > +{
> > > +       return syscall(__NR_fsopen, fsname, flags);
> > > +}
> > > +
> > > +static inline int sys_fsconfig(int fs_fd, unsigned int cmd, const ch=
ar *key,
> > > +                              const void *val, int aux)
> > > +{
> > > +       return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
> > > +}
> > > +
> > > +static inline int sys_fsmount(int fs_fd, unsigned int flags,
> > > +                             unsigned int ms_flags)
> > > +{
> > > +       return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
> > > +}
> > > +
> > > +static int set_delegate_mask(int fs_fd, const char *key, __u64 mask,
> > > +                            const char *mask_str)
> > > +{
> > > +       char buf[32];
> > > +       int err;
> > > +
> > > +       if (!mask_str) {
> > > +               if (mask =3D=3D ~0ULL) {
> > > +                       mask_str =3D "any";
> > > +               } else {
> > > +                       snprintf(buf, sizeof(buf), "0x%llx", (unsigne=
d long long)mask);
> > > +                       mask_str =3D buf;
> > > +               }
> > > +       }
> > > +
> > > +       err =3D sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
> > > +                          mask_str, 0);
> > > +       if (err < 0)
> > > +               err =3D -errno;
> > > +       return err;
> > > +}
> > > +
> > > +static int create_bpffs_fd(void)
> > > +{
> > > +       int fs_fd;
> > > +
> > > +       /* create VFS context */
> > > +       fs_fd =3D sys_fsopen("bpf", 0);
> > > +       ASSERT_GE(fs_fd, 0, "fs_fd");
> > > +
> > > +       return fs_fd;
> > > +}
> > > +
> > > +static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
> > > +{
> > > +       int mnt_fd, err;
> > > +
> > > +       /* set up token delegation mount options */
> > > +       err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds,=
 opts->cmds_str);
> > > +       if (!ASSERT_OK(err, "fs_cfg_cmd"))
> > > +               return err;
> > > +       err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps,=
 opts->maps_str);
> > > +       if (!ASSERT_OK(err, "fs_cfg_maps"))
> > > +               return err;
> > > +       err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->prog=
s, opts->progs_str);
> > > +       if (!ASSERT_OK(err, "fs_cfg_progs"))
> > > +               return err;
> > > +       err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->at=
tachs,
> > > +                               opts->attachs_str);
> > > +       if (!ASSERT_OK(err, "fs_cfg_attachs"))
> > > +               return err;
> > > +
> > > +       /* instantiate FS object */
> > > +       err =3D sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, =
0);
> > > +       if (err < 0)
> > > +               return -errno;
> > > +
> > > +       /* create O_PATH fd for detached mount */
> > > +       mnt_fd =3D sys_fsmount(fs_fd, 0, 0);
> > > +       if (err < 0)
> > > +               return -errno;
> > > +
> > > +       return mnt_fd;
> > > +}
> > > +
> > > +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> > > +{
> > > +       ssize_t ret;
> > > +
> > > +       do {
> > > +               ret =3D write(fd, buf, count);
> > > +       } while (ret < 0 && errno =3D=3D EINTR);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int write_file(const char *path, const void *buf, size_t coun=
t)
> > > +{
> > > +       int fd;
> > > +       ssize_t ret;
> > > +
> > > +       fd =3D open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLO=
W);
> > > +       if (fd < 0)
> > > +               return -1;
> > > +
> > > +       ret =3D write_nointr(fd, buf, count);
> > > +       close(fd);
> > > +       if (ret < 0 || (size_t)ret !=3D count)
> > > +               return -1;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int create_and_enter_userns(void)
> > > +{
> > > +       uid_t uid;
> > > +       gid_t gid;
> > > +       char map[100];
> > > +
> > > +       uid =3D getuid();
> > > +       gid =3D getgid();
> > > +
> > > +       if (unshare(CLONE_NEWUSER))
> > > +               return -1;
> > > +
> > > +       if (write_file("/proc/self/setgroups", "deny", sizeof("deny")=
 - 1) &&
> > > +           errno !=3D ENOENT)
> > > +               return -1;
> > > +
> > > +       snprintf(map, sizeof(map), "0 %d 1", uid);
> > > +       if (write_file("/proc/self/uid_map", map, strlen(map)))
> > > +               return -1;
> > > +
> > > +
> > > +       snprintf(map, sizeof(map), "0 %d 1", gid);
> > > +       if (write_file("/proc/self/gid_map", map, strlen(map)))
> > > +               return -1;
> > > +
> > > +       if (setgid(0))
> > > +               return -1;
> > > +
> > > +       if (setuid(0))
> > > +               return -1;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int sendfd(int sockfd, int fd)
> > > +{
> > > +       struct msghdr msg =3D {};
> > > +       struct cmsghdr *cmsg;
> > > +       int fds[1] =3D { fd }, err;
> > > +       char iobuf[1];
> > > +       struct iovec io =3D {
> > > +               .iov_base =3D iobuf,
> > > +               .iov_len =3D sizeof(iobuf),
> > > +       };
> > > +       union {
> > > +               char buf[CMSG_SPACE(sizeof(fds))];
> > > +               struct cmsghdr align;
> > > +       } u;
> > > +
> > > +       msg.msg_iov =3D &io;
> > > +       msg.msg_iovlen =3D 1;
> > > +       msg.msg_control =3D u.buf;
> > > +       msg.msg_controllen =3D sizeof(u.buf);
> > > +       cmsg =3D CMSG_FIRSTHDR(&msg);
> > > +       cmsg->cmsg_level =3D SOL_SOCKET;
> > > +       cmsg->cmsg_type =3D SCM_RIGHTS;
> > > +       cmsg->cmsg_len =3D CMSG_LEN(sizeof(fds));
> > > +       memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
> > > +
> > > +       err =3D sendmsg(sockfd, &msg, 0);
> > > +       if (err < 0)
> > > +               err =3D -errno;
> > > +       if (!ASSERT_EQ(err, 1, "sendmsg"))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int recvfd(int sockfd, int *fd)
> > > +{
> > > +       struct msghdr msg =3D {};
> > > +       struct cmsghdr *cmsg;
> > > +       int fds[1], err;
> > > +       char iobuf[1];
> > > +       struct iovec io =3D {
> > > +               .iov_base =3D iobuf,
> > > +               .iov_len =3D sizeof(iobuf),
> > > +       };
> > > +       union {
> > > +               char buf[CMSG_SPACE(sizeof(fds))];
> > > +               struct cmsghdr align;
> > > +       } u;
> > > +
> > > +       msg.msg_iov =3D &io;
> > > +       msg.msg_iovlen =3D 1;
> > > +       msg.msg_control =3D u.buf;
> > > +       msg.msg_controllen =3D sizeof(u.buf);
> > > +
> > > +       err =3D recvmsg(sockfd, &msg, 0);
> > > +       if (err < 0)
> > > +               err =3D -errno;
> > > +       if (!ASSERT_EQ(err, 1, "recvmsg"))
> > > +               return -EINVAL;
> > > +
> > > +       cmsg =3D CMSG_FIRSTHDR(&msg);
> > > +       if (!ASSERT_OK_PTR(cmsg, "cmsg_null") ||
> > > +           !ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(fds)), "cmsg_l=
en") ||
> > > +           !ASSERT_EQ(cmsg->cmsg_level, SOL_SOCKET, "cmsg_level") ||
> > > +           !ASSERT_EQ(cmsg->cmsg_type, SCM_RIGHTS, "cmsg_type"))
> > > +               return -EINVAL;
> > > +
> > > +       memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
> > > +       *fd =3D fds[0];
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int wait_for_pid(pid_t pid)
> > > +{
> > > +       int status, ret;
> > > +
> > > +again:
> > > +       ret =3D waitpid(pid, &status, 0);
> > > +       if (ret =3D=3D -1) {
> > > +               if (errno =3D=3D EINTR)
> > > +                       goto again;
> > > +
> > > +               return -1;
> > > +       }
> > > +
> > > +       if (!WIFEXITED(status))
> > > +               return -1;
> > > +
> > > +       return WEXITSTATUS(status);
> > > +}
> > > +
> > > +static int child(int sock_fd, struct bpffs_opts *bpffs_opts,
> > > +                child_callback_fn callback)
> > > +{
> > > +       int mnt_fd =3D -1, fs_fd =3D -1, err =3D 0, bpffs_fd =3D -1, =
token_fd =3D -1;
> > > +
> > > +       err =3D create_and_enter_userns();
> > > +       if (!ASSERT_OK(err, "create_and_enter_userns"))
> > > +               goto cleanup;
> > > +
> > > +       err =3D unshare(CLONE_NEWNS);
> > > +       if (!ASSERT_OK(err, "create_mountns"))
> > > +               goto cleanup;
> > > +
> > > +       err =3D sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> > > +       if (!ASSERT_OK(err, "remount_root"))
> > > +               goto cleanup;
> > > +
> > > +       fs_fd =3D create_bpffs_fd();
> > > +       if (!ASSERT_GE(fs_fd, 0, "create_bpffs_fd")) {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       err =3D sendfd(sock_fd, fs_fd);
> > > +       if (!ASSERT_OK(err, "send_fs_fd"))
> > > +               goto cleanup;
> > > +       zclose(fs_fd);
> > > +
> > > +       err =3D recvfd(sock_fd, &mnt_fd);
> > > +       if (!ASSERT_OK(err, "recv_mnt_fd"))
> > > +               goto cleanup;
> > > +
> > > +       bpffs_fd =3D openat(mnt_fd, ".", 0, O_RDWR);
> > > +       if (!ASSERT_GE(bpffs_fd, 0, "bpffs_open")) {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       err =3D callback(bpffs_fd);
> > > +       if (!ASSERT_OK(err, "test_callback"))
> > > +               goto cleanup;
> > > +
> > > +       err =3D 0;
> > > +
> > > +cleanup:
> > > +       zclose(sock_fd);
> > > +       zclose(mnt_fd);
> > > +       zclose(fs_fd);
> > > +       zclose(bpffs_fd);
> > > +       zclose(token_fd);
> > > +
> > > +       exit(-err);
> > > +}
> > > +
> > > +static int parent(int child_pid, struct bpffs_opts *bpffs_opts, int =
sock_fd)
> > > +{
> > > +       int fs_fd =3D -1, mnt_fd =3D -1, token_fd =3D -1, err;
> > > +
> > > +       err =3D recvfd(sock_fd, &fs_fd);
> > > +       if (!ASSERT_OK(err, "recv_bpffs_fd"))
> > > +               goto cleanup;
> > > +
> > > +       mnt_fd =3D materialize_bpffs_fd(fs_fd, bpffs_opts);
> > > +       if (!ASSERT_GE(mnt_fd, 0, "materialize_bpffs_fd")) {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +       zclose(fs_fd);
> > > +
> > > +       err =3D sendfd(sock_fd, mnt_fd);
> > > +       if (!ASSERT_OK(err, "send_mnt_fd"))
> > > +               goto cleanup;
> > > +       zclose(mnt_fd);
> > > +
> > > +       err =3D wait_for_pid(child_pid);
> > > +       if (!ASSERT_OK(err, "waitpid_child")) {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +cleanup:
> > > +       zclose(sock_fd);
> > > +       zclose(fs_fd);
> > > +       zclose(mnt_fd);
> > > +       zclose(token_fd);
> > > +
> > > +       if (child_pid > 0)
> > > +               (void)kill(child_pid, SIGKILL);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int subtest(struct bpffs_opts *bpffs_opts, child_callback_fn =
child_cb)
> > > +{
> > > +       int sock_fds[2] =3D { -1, -1 };
> > > +       int child_pid =3D 0, err;
> > > +
> > > +       err =3D socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
> > > +       if (!ASSERT_OK(err, "socketpair"))
> > > +               goto cleanup;
> > > +
> > > +       child_pid =3D fork();
> > > +       if (!ASSERT_GE(child_pid, 0, "fork"))
> > > +               goto cleanup;
> > > +
> > > +       if (child_pid =3D=3D 0) {
> > > +               zclose(sock_fds[0]);
> > > +               return child(sock_fds[1], bpffs_opts, child_cb);
> > > +       } else {
> > > +               zclose(sock_fds[1]);
> > > +               return parent(child_pid, bpffs_opts, sock_fds[0]);
> > > +       }
> > > +
> > > +cleanup:
> > > +       zclose(sock_fds[0]);
> > > +       zclose(sock_fds[1]);
> > > +       if (child_pid > 0)
> > > +               (void)kill(child_pid, SIGKILL);
> > > +
> > > +       return -err;
> > > +}
> > > +
> > > +static int userns_map_create(int mnt_fd)
> > > +{
> > > +       LIBBPF_OPTS(bpf_map_create_opts, map_opts);
> > > +       int err =3D 0, token_fd =3D -1, map_fd =3D -1;
> > > +
> > > +       /* create BPF token from BPF FS mount */
> > > +       token_fd =3D bpf_token_create(mnt_fd, NULL);
> > > +       if (!ASSERT_GT(token_fd, 0, "userns_map_create/token_create")=
) {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       map_opts.map_flags =3D BPF_F_TOKEN_FD;
> > > +       map_opts.token_fd =3D token_fd;
> > > +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, "userns_map_cre=
ate", 0, 8, 1,
> > > +                               &map_opts);
> > > +       if (!ASSERT_GT(map_fd, 0, "userns_map_create/bpf_map_create")=
) {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +cleanup:
> > > +       zclose(token_fd);
> > > +       zclose(map_fd);
> > > +
> > > +       if (err)
> > > +               fprintf(stderr, "Failed to create BPF map with BPF to=
ken enabled: %s\n",
> > > +                       strerror(errno));
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int userns_prog_load(int mnt_fd)
> > > +{
> > > +       LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
> > > +       int err, token_fd =3D -1, prog_fd =3D -1;
> > > +       struct bpf_insn insns[] =3D {
> > > +               /* bpf_jiffies64() requires CAP_BPF */
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ji=
ffies64),
> > > +               /* bpf_get_current_task() requires CAP_PERFMON */
> > > +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ge=
t_current_task),
> > > +               /* r0 =3D 0; exit; */
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +       size_t insn_cnt =3D ARRAY_SIZE(insns);
> > > +
> > > +       token_fd =3D bpf_token_create(mnt_fd, NULL);
> > > +       if (!ASSERT_GT(token_fd, 0, "userns_prog_load/token_create"))=
 {
> > > +               err =3D -EINVAL;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       prog_opts.prog_flags =3D BPF_F_TOKEN_FD;
> > > +       prog_opts.token_fd =3D token_fd;
> > > +       prog_opts.expected_attach_type =3D BPF_XDP;
> > > +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "G=
PL",
> > > +                               insns, insn_cnt, &prog_opts);
> > > +       if (!ASSERT_GT(prog_fd, 0, "userns_prog_load/bpf_prog_load"))=
 {
> > > +               err =3D -EPERM;
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       err =3D 0;
> > > +
> > > +cleanup:
> > > +       zclose(prog_fd);
> > > +       zclose(token_fd);
> > > +
> > > +       if (err)
> > > +               fprintf(stderr, "Failed to load BPF prog with token e=
nabled: %s\n",
> > > +                       strerror(errno));
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +int test_bpf_map_create(void)
> > > +{
> > > +       struct bpffs_opts opts =3D {
> > > +               .cmds_str =3D "map_create",
> > > +               .maps_str =3D "stack"
> > > +       };
> > > +
> > > +       return subtest(&opts, userns_map_create);
> > > +}
> > > +
> > > +int test_bpf_prog_load(void)
> > > +{
> > > +       struct bpffs_opts opts =3D {
> > > +               .cmds_str =3D "prog_load",
> > > +               .progs_str =3D "XDP",
> > > +               .attachs_str =3D "xdp",
> > > +       };
> > > +
> > > +       return subtest(&opts, userns_prog_load);
> > > +}
> > > --
> > > 2.51.0.windows.1
> > >
