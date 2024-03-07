Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80017130AD0
	for <selinux@vger.kernel.org>; Thu,  7 Mar 2024 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841043; cv=none; b=OOpYHqqffqoqa9oe9vuMC4EZpWugOFwjGTvN6A+Fay3eg08mENMR14Lsmm8gNrJ5dTUFPy5FBC6orbXd6DouMSH7J6WiHCwv0xlDc+p97HccETfZ1XOeTCgeN4fuBNu2G+PuvcrfeMMmG1t5WdYT1K9Dw1I+65Yv9zO1eNFAWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841043; c=relaxed/simple;
	bh=L8esZavT9ndDeGbj9mpU/tOVRLn3IhUXzllVTE6oXPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMiH3sCpfA+I9RFheOexYGPuI5iFhnOSxfjh1AMWzFylBGZvP/juCtjOt3KXC4QDdKMuYs/qO9hjo1ZO0Lfze4laDRcuyiSROumstIgxpJ+lfm9V/J80kQF2FFH9/4Hil1ILas/a7d16Ea/x0N3ntWxD4uN0/ab8lYanr3K23TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAmnCQLW; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAmnCQLW"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47299367f78so404725137.0
        for <selinux@vger.kernel.org>; Thu, 07 Mar 2024 11:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709841040; x=1710445840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSIrk5kJJYe9yARAKihoZzLtKy8x66//iIs0hBnoSL4=;
        b=eAmnCQLWlEc/cozORffQeyef/cAQC1z55BHuMw1GK9iqoGhWsrZ8yqldGHvHNxi22O
         CcsK3E9Af1ilnGM/6SHiK2wY97gTmcqeWojkY5neSo3OV944G+4+7TbG9BXF5/dI01Yk
         UsTqmUjtiXFcpl5uGV0VarRwhw3PY6lUJtNlarofS837GzIZ8C1Vj7/Y9qKFLYWkAPew
         NJZiVx3UHnPi6xfnAfEOfKhj3uoU4BaQlWEmYe7FWyY7hQYEKVGy45TkB8VdBkLkeN1Z
         m8bMVOqECVD1XylToFImGS+oTjBIYkxOb1Kr0LpfPsjXFF2jRI/RIcXlDY/m57yfJnrh
         pgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709841040; x=1710445840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSIrk5kJJYe9yARAKihoZzLtKy8x66//iIs0hBnoSL4=;
        b=lI6kccue69yJYxSQ9tfiRCzU6z+sOsEQFiN+A8cXMDFUZyEcgwNpQdJ0/wl240zP3N
         YjCNPmx/Oqo0bHuSnVY9olWuAN7SjCXaNE0Pd/EyrzwSfF9D2ETLTrftmCDRROGcNi2o
         z0BxlxO2S6p0qH76n1E9LDqHQoL1S3IUmsAtsL69SwRx4t/K40/oZw65qRSXrlREpflE
         qo21STzbuNXR5KoFxUz52zs2QhkRM518aRQ6qlJlUUuvSenPPwt571uDnWsqMmleNEY7
         ZrLWIsmhEMncxlbyZmfxR2Vn9gG9CKIq8ebvWd1Yvh4NHZg/ZNl591ZZlsFCQrIXvQIa
         trIw==
X-Gm-Message-State: AOJu0YxlrXREnZg/dozJNJ7cX4B8i3KYZQZxKkupF4TuBiAJv2PCgn3+
	z1EwH112Z+acf7X0xRzOTirLv3xe+T0EIw4zzf6k9UwjtefymMz91qUs8+60kWIgSwAM0ad+ONJ
	ctWsKNxKdkZJE/BtrLu5LcAtAh0a1Hvp9Gwk=
X-Google-Smtp-Source: AGHT+IEpQZMysHe5wRb2G6fwmfKW8XVtROV3PhX2zzSwhvSEm83L39+OfuXy0UbUBQmNBo72S7nbvgVIOYcbGCWLHCA=
X-Received: by 2002:a05:6102:18d9:b0:473:79c:edde with SMTP id
 jj25-20020a05610218d900b00473079ceddemr1725435vsb.31.1709841040258; Thu, 07
 Mar 2024 11:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131130840.48155-1-cgzones@googlemail.com> <20240131130840.48155-3-cgzones@googlemail.com>
In-Reply-To: <20240131130840.48155-3-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 7 Mar 2024 14:50:29 -0500
Message-ID: <CAP+JOzTy98k5U7itKiFJ7khjQN=UCbpm0HKWwb36=jqzKTrpbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/9] libselinux/utils: introduce selabel_compare
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a utility around selabel_cmp(3).
>
> Can be used by users to compare a pre-compiled fcontext file to an
> original text-based file context definition file.
>
> Can be used for development to verify compilation and parsing of the
> pre-compiled fcontext format works correctly.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I don't have any comments on the code.

It took me a while to get this to work. It was very confusing. Not
because of your code, but because of the behavior of selabel_cmp(). It
is not intuitive and I think that it needs to be better documented. It
will absolutely not work as expected on a copy of the contexts
directory.


With all that, not everything worked as I thought it would.

current =3D installed contexts directory
the other file is by itself (and not in a copy of the contexts directory)

1) current file_contexts.bin vs file_contexts [Expected]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
file_contexts
spec /etc/selinux/targeted/contexts/files/file_contexts.bin is equal
to spec file_contexts

2) current file_contexts vs file_contexts [Not expected, diff says
they are equal]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts file_con=
texts
selabel_cmp: mismatch regex_str left remnant in stem tmp
selabel_cmp: mismatch child node tmp stem (root)
spec /etc/selinux/targeted/contexts/files/file_contexts is
uncomparable to spec file_contexts

3) current file_contexts.bin vs file_contexts_1 [Expected]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
file_contexts_1
spec /etc/selinux/targeted/contexts/files/file_contexts.bin is equal
to spec file_contexts_1

4) file_contexts vs file_contexts_1 [Expected]
selabel_compare file_contexts file_contexts_1
spec file_contexts is equal to spec file_contexts_1


I realize now that selabel_cmp() can only find a superset or a subset
if the only difference occurs at the very end. The longer file must be
exactly like the shorter file except for the additional lines at the
end.

I tried testing with the zebra module disabled, so it should have been
a subset of the current policy, but, of course, selabel_cmp() was not
sophisticated enough to say that. It just says that everything is
uncomparable. It would be nice if something said that.


The following worked only in the most trivial case where I could just
use diff instead.
contexts1 =3D copy of original contexts directory
contexts2 =3D copy of new contexts directory with new selabel db

1) current file_contexts vs contexts1 file_contexts [Expected, but Confusin=
g]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts
contexts1/files/file_contexts
contexts1/files/file_contexts.bin:  Old compiled fcontext format, skipping
contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
format, skipping
spec /etc/selinux/targeted/contexts/files/file_contexts is equal to
spec contexts1/files/file_contexts

2) current file_contexts.bin vs contexts1 file_contexts [Not expected.
Expected to be able to compare the current file_contexts.bin with old
text file_contexts]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
contexts1/files/file_contexts
contexts1/files/file_contexts.bin:  Old compiled fcontext format, skipping
contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
format, skipping
selabel_cmp: mismatch regex_str right remnant in stem tmp
selabel_cmp: mismatch child node tmp stem (root)
spec /etc/selinux/targeted/contexts/files/file_contexts.bin is
uncomparable to spec contexts1/files/file_contexts

3) current file_contexts.bin vs contexts1 file_contexts.bin [Expected,
but confusing]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
contexts1/files/file_contexts.bin
contexts1/files/file_contexts.bin:  Old compiled fcontext format, skipping
contexts1/files/file_contexts.bin:  Old compiled fcontext format, skipping
ERROR: selabel_open - Could not obtain handle for
contexts1/files/file_contexts.bin:  No such file or directory

4) current file_contexts vs contexts2 file_contexts [Expected]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts
contexts2/files/file_contexts
spec /etc/selinux/targeted/contexts/files/file_contexts is equal to
spec contexts2/files/file_contexts

5) current file_contexts.bin vs contexts2 file_contexts [Not expected.
Expected to be able to compare the current file_contexts.bin with
contexts2 text file_contexts]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
contexts2/files/file_contexts
selabel_cmp: mismatch regex_str right remnant in stem tmp
selabel_cmp: mismatch child node tmp stem (root)
spec /etc/selinux/targeted/contexts/files/file_contexts.bin is
uncomparable to spec contexts2/files/file_contexts

6) current file_contexts.bin vs contexts2 file_contexts.bin [Expected]
selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
contexts2/files/file_contexts.bin
spec /etc/selinux/targeted/contexts/files/file_contexts.bin is equal
to spec contexts2/files/file_contexts.bin

7) contexts1 file_contexts vs contexts2 file_contexts [Expected, but confus=
ing]
selabel_compare contexts1/files/file_contexts  contexts2/files/file_context=
s
contexts1/files/file_contexts.bin:  Old compiled fcontext format, skipping
contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
format, skipping
spec contexts1/files/file_contexts is equal to spec
contexts2/files/file_contexts

8) contexts1 file_contexts vs contexts2 file_contexts.cpy (which is a
copy of file_contexts) [Not expected. Expected them to be equal]
selabel_compare contexts1/files/file_contexts contexts2/files/file_contexts=
.cpy
contexts1/files/file_contexts.bin:  Old compiled fcontext format, skipping
contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
format, skipping
selabel_cmp: mismatch regex_str left remnant in stem tmp
selabel_cmp: mismatch child node tmp stem (root)
spec contexts1/files/file_contexts is uncomparable to spec
contexts2/files/file_contexts.cpy

With all of the issues, I wonder how useful this actually would be. It
might cause more confusion then anything.

Thanks,
Jim

> ---
> v2:
>    split nested block into own function
> ---
>  libselinux/utils/.gitignore        |   1 +
>  libselinux/utils/selabel_compare.c | 122 +++++++++++++++++++++++++++++
>  2 files changed, 123 insertions(+)
>  create mode 100644 libselinux/utils/selabel_compare.c
>
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index b3311360..2e10b14f 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -16,6 +16,7 @@ getseuser
>  matchpathcon
>  policyvers
>  sefcontext_compile
> +selabel_compare
>  selabel_digest
>  selabel_get_digests_all_partial_matches
>  selabel_lookup
> diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/selabe=
l_compare.c
> new file mode 100644
> index 00000000..9ca6eff1
> --- /dev/null
> +++ b/libselinux/utils/selabel_compare.c
> @@ -0,0 +1,122 @@
> +#include <getopt.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <selinux/label.h>
> +
> +
> +static void usage(const char *progname)
> +{
> +       fprintf(stderr,
> +               "usage: %s [-b backend] [-v] file1 file2\n\n"
> +               "Where:\n\t"
> +               "-b           The backend - \"file\", \"media\", \"x\", \=
"db\" or \"prop\" (defaults to \"file\")\n\t"
> +               "-v           Validate entries against loaded policy.\n\t=
"
> +               "file1/file2  Files containing the specs.\n",
> +               progname);
> +}
> +
> +static int compare(const char *file1, const char *file2, const char *val=
idate, unsigned int backend)
> +{
> +       struct selabel_handle *hnd1, *hnd2;
> +       const struct selinux_opt selabel_option1[] =3D {
> +               { SELABEL_OPT_PATH, file1 },
> +               { SELABEL_OPT_VALIDATE, validate }
> +       };
> +       const struct selinux_opt selabel_option2[] =3D {
> +               { SELABEL_OPT_PATH, file2 },
> +               { SELABEL_OPT_VALIDATE, validate }
> +       };
> +       enum selabel_cmp_result result;
> +
> +       hnd1 =3D selabel_open(backend, selabel_option1, 2);
> +       if (!hnd1) {
> +               fprintf(stderr, "ERROR: selabel_open - Could not obtain h=
andle for %s:  %m\n", file1);
> +               return EXIT_FAILURE;
> +       }
> +
> +       hnd2 =3D selabel_open(backend, selabel_option2, 2);
> +       if (!hnd2) {
> +               fprintf(stderr, "ERROR: selabel_open - Could not obtain h=
andle for %s:  %m\n", file2);
> +               selabel_close(hnd1);
> +               return EXIT_FAILURE;
> +       }
> +
> +       result =3D selabel_cmp(hnd1, hnd2);
> +
> +       selabel_close(hnd2);
> +       selabel_close(hnd1);
> +
> +       switch (result) {
> +       case SELABEL_SUBSET:
> +               printf("spec %s is a subset of spec %s\n", file1, file2);
> +               break;
> +       case SELABEL_EQUAL:
> +               printf("spec %s is equal to spec %s\n", file1, file2);
> +               break;
> +       case SELABEL_SUPERSET:
> +               printf("spec %s is a superset of spec %s\n", file1, file2=
);
> +               break;
> +       case SELABEL_INCOMPARABLE:
> +               printf("spec %s is uncomparable to spec %s\n", file1, fil=
e2);
> +               break;
> +       default:
> +               fprintf(stderr, "ERROR: selabel_cmp - Unexpected result %=
d\n", result);
> +               return EXIT_FAILURE;
> +       }
> +
> +       return EXIT_SUCCESS;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       unsigned int backend =3D SELABEL_CTX_FILE;
> +       int opt;
> +       const char *validate =3D NULL, *file1 =3D NULL, *file2 =3D NULL;
> +
> +       if (argc < 3) {
> +               usage(argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       while ((opt =3D getopt(argc, argv, "b:v")) > 0) {
> +               switch (opt) {
> +               case 'b':
> +                       if (!strcasecmp(optarg, "file")) {
> +                               backend =3D SELABEL_CTX_FILE;
> +                       } else if (!strcmp(optarg, "media")) {
> +                               backend =3D SELABEL_CTX_MEDIA;
> +                       } else if (!strcmp(optarg, "x")) {
> +                               backend =3D SELABEL_CTX_X;
> +                       } else if (!strcmp(optarg, "db")) {
> +                               backend =3D SELABEL_CTX_DB;
> +                       } else if (!strcmp(optarg, "prop")) {
> +                               backend =3D SELABEL_CTX_ANDROID_PROP;
> +                       } else if (!strcmp(optarg, "service")) {
> +                               backend =3D SELABEL_CTX_ANDROID_SERVICE;
> +                       } else {
> +                               fprintf(stderr, "Unknown backend: %s\n", =
optarg);
> +                               usage(argv[0]);
> +                               return EXIT_FAILURE;
> +                       }
> +                       break;
> +               case 'v':
> +                       validate =3D (char *)1;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       if (argc !=3D optind + 2) {
> +               usage(argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       file1 =3D argv[optind++];
> +       file2 =3D argv[optind];
> +
> +       return compare(file1, file2, validate, backend);
> +}
> --
> 2.43.0
>
>
