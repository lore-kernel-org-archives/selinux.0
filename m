Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677E29A9
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177666; cv=none; b=PE/BHJuKR+GU2VD+24fB8mmFhlNYXQznBdfLSGepaQWgUrPkTeyTRUNLXI3fDuTq3he6tEp6OLWzED7Iiof/P3lTfW6TDe5ZzEPjfIWPx3O+AUsLdv4LbGNxUBAtFJiEpV1JybS0HYjn2OrpNnXjNM0Ov27j8BuHAbQFhG/7l4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177666; c=relaxed/simple;
	bh=2lraCrWGcu5dKtkIkyKhLlIBGvmbml/DHCXNes6jSJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gsgrl6YjtBcLSb/RBZ1hHSmFd6O9MLq2e4IPhDA9Y71zLGSdYWjxwQhv1NPYTsn4ZqhsMDq4U0fdydZvd16XwVMPXcxpmHO6baFaomhm2KB6D3E1M6pDEu7vuIP8opMBEu66qEorDcXIeGdx5uMbJoUJweR/CiqMH1xCTXI2sN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=m4DcNtxZ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m4DcNtxZ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c24ef5eebfso546384b6e.2
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710177663; x=1710782463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53KIhIVGT/tIKQHIpemxk+XtzxfRT5ph1xMBpmDPs5o=;
        b=m4DcNtxZZm5WtG8/Pa3VSY7LlGJsvPmlo+RCbzFKzZect28LAB6/98bC1jny04mLIS
         d+7CncXwgzLG1SgedsJIfS/W7ygXDYUum1gkEoqdEJn8rELBx7mNzKiVKoDaJiNFD2j3
         sNqL/jLUypUrYfjularVJSIIiPj/HPtVgfoO0eTnXo5066KXh0Scb2X4xuIISBxMPJ8M
         0JLFNIxA0ycXuyf1z78Vw+mWvF7zsDQteoWelOVqP35SErnS1iaQP0Wzr0UhP8jwETpl
         Sr1eVzf5ifk4pPadxNVRI+ISIzqQOeuvnJCBHwrwdZQBG9ipCZ0vbK8/fbJX8dseUYxh
         cLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710177663; x=1710782463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53KIhIVGT/tIKQHIpemxk+XtzxfRT5ph1xMBpmDPs5o=;
        b=DA87w3hmBw+yyRYqg9aUY0kYdBVYSwgNjHmqtTrUHTUksZW0Z7R8c8GR3AOV9zWSTD
         RXWl/PCUB2ECFIlzD63rXfm2rtrtQhkVO3eJNMcAwe66LUk5p6eYWXwx2d8BcMKfUYUj
         fJC58qR7rIwRx8c2cMczj8tdbHR4SRGbNfGGUGyefWqEWch11P3hVLXZbeF7GUWxULm7
         5O2EtydPSjC2+E4ivxXmBZ1WjlCjAp4skMElGkZfslvZ+NbD8CMvfgv8+eGLPlBz6jJU
         8lvHN5O1cWYO6CHTXnxBEadz+JnqOAfnV9YU7vMzyXFpadEFJOgPGhd5nFk+wrNwsvr3
         Tnhw==
X-Gm-Message-State: AOJu0YzFCJKG6q/LlQ34Uf1TBkCqCGbVzlLo/6QmCKNm8udQpckiWWSn
	00PhMzuzLVE0sOdqMBaECfA6LdTnxhUresC75LaA8qTCX1hQxBQvbH2U6UJnaH9ftqKLc+dxiwu
	wyVrGQWamAq0TfZMOqRcUPTsNzn8=
X-Google-Smtp-Source: AGHT+IEHXgSvT8PwYBvKKSYAbkAvERyFYoHCityh6tS2xIJ2yh1wbpBR0NuncgDStCDJ0XwT+8YFLCCj1xszt5ZYGzc=
X-Received: by 2002:a05:6808:1151:b0:3c2:101a:96e3 with SMTP id
 u17-20020a056808115100b003c2101a96e3mr10011976oiu.52.1710177663242; Mon, 11
 Mar 2024 10:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131130840.48155-1-cgzones@googlemail.com>
 <20240131130840.48155-3-cgzones@googlemail.com> <CAP+JOzTy98k5U7itKiFJ7khjQN=UCbpm0HKWwb36=jqzKTrpbA@mail.gmail.com>
In-Reply-To: <CAP+JOzTy98k5U7itKiFJ7khjQN=UCbpm0HKWwb36=jqzKTrpbA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 11 Mar 2024 18:20:52 +0100
Message-ID: <CAJ2a_DcD-8qT_3-595h1fzF+6LN1NnsOma_nztbh__XesCBxhA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/9] libselinux/utils: introduce selabel_compare
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 at 20:50, James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jan 31, 2024 at 8:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a utility around selabel_cmp(3).
> >
> > Can be used by users to compare a pre-compiled fcontext file to an
> > original text-based file context definition file.
> >
> > Can be used for development to verify compilation and parsing of the
> > pre-compiled fcontext format works correctly.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

First of all many thanks for testing!

> I don't have any comments on the code.
>
> It took me a while to get this to work. It was very confusing. Not
> because of your code, but because of the behavior of selabel_cmp(). It
> is not intuitive and I think that it needs to be better documented. It
> will absolutely not work as expected on a copy of the contexts
> directory.
>
>
> With all that, not everything worked as I thought it would.
>
> current =3D installed contexts directory
> the other file is by itself (and not in a copy of the contexts directory)
>
> 1) current file_contexts.bin vs file_contexts [Expected]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
> file_contexts
> spec /etc/selinux/targeted/contexts/files/file_contexts.bin is equal
> to spec file_contexts
>
> 2) current file_contexts vs file_contexts [Not expected, diff says
> they are equal]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts file_c=
ontexts
> selabel_cmp: mismatch regex_str left remnant in stem tmp
> selabel_cmp: mismatch child node tmp stem (root)
> spec /etc/selinux/targeted/contexts/files/file_contexts is
> uncomparable to spec file_contexts

Since the database is opened via selabel_open(3)
filecontexts.(homedirs|local) are implicitly loaded too.
It would be confusing if the selabel_compare helper would deviate from
that default behavior.
Also currently there is no information in the in-memory database from
which/how-many files the database was loaded.
Maybe that should be added so the selabel_compare helper could give a hint?

> 3) current file_contexts.bin vs file_contexts_1 [Expected]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
> file_contexts_1
> spec /etc/selinux/targeted/contexts/files/file_contexts.bin is equal
> to spec file_contexts_1
>
> 4) file_contexts vs file_contexts_1 [Expected]
> selabel_compare file_contexts file_contexts_1
> spec file_contexts is equal to spec file_contexts_1
>
>
> I realize now that selabel_cmp() can only find a superset or a subset
> if the only difference occurs at the very end. The longer file must be
> exactly like the shorter file except for the additional lines at the
> end.

Thanks, this is indeed a shortcoming in v2 (regex prefix length were
not considered). Fixed in wip-v3:
https://github.com/SELinuxProject/selinux/compare/f07e4c3b66416f6337d6a2ea1=
e0d69555f8704ad..090af7e6510edb90f4e7df55346e5023ac190b66

> I tried testing with the zebra module disabled, so it should have been
> a subset of the current policy, but, of course, selabel_cmp() was not
> sophisticated enough to say that. It just says that everything is
> uncomparable. It would be nice if something said that.
>
>
> The following worked only in the most trivial case where I could just
> use diff instead.
> contexts1 =3D copy of original contexts directory
> contexts2 =3D copy of new contexts directory with new selabel db
>
> 1) current file_contexts vs contexts1 file_contexts [Expected, but Confus=
ing]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts
> contexts1/files/file_contexts
> contexts1/files/file_contexts.bin:  Old compiled fcontext format, skippin=
g
> contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
> format, skipping
> spec /etc/selinux/targeted/contexts/files/file_contexts is equal to
> spec contexts1/files/file_contexts

What is confusing here?

> 2) current file_contexts.bin vs contexts1 file_contexts [Not expected.
> Expected to be able to compare the current file_contexts.bin with old
> text file_contexts]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
> contexts1/files/file_contexts
> contexts1/files/file_contexts.bin:  Old compiled fcontext format, skippin=
g
> contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
> format, skipping
> selabel_cmp: mismatch regex_str right remnant in stem tmp
> selabel_cmp: mismatch child node tmp stem (root)
> spec /etc/selinux/targeted/contexts/files/file_contexts.bin is
> uncomparable to spec contexts1/files/file_contexts

Gives subset with v3 (since when using a .bin extension .homedirs and
.local are not loaded).

> 3) current file_contexts.bin vs contexts1 file_contexts.bin [Expected,
> but confusing]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
> contexts1/files/file_contexts.bin
> contexts1/files/file_contexts.bin:  Old compiled fcontext format, skippin=
g
> contexts1/files/file_contexts.bin:  Old compiled fcontext format, skippin=
g
> ERROR: selabel_open - Could not obtain handle for
> contexts1/files/file_contexts.bin:  No such file or directory

Updated errno to EINVAL for this case.

> 4) current file_contexts vs contexts2 file_contexts [Expected]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts
> contexts2/files/file_contexts
> spec /etc/selinux/targeted/contexts/files/file_contexts is equal to
> spec contexts2/files/file_contexts
>
> 5) current file_contexts.bin vs contexts2 file_contexts [Not expected.
> Expected to be able to compare the current file_contexts.bin with
> contexts2 text file_contexts]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
> contexts2/files/file_contexts
> selabel_cmp: mismatch regex_str right remnant in stem tmp
> selabel_cmp: mismatch child node tmp stem (root)
> spec /etc/selinux/targeted/contexts/files/file_contexts.bin is
> uncomparable to spec contexts2/files/file_contexts

Should give subset (due to the missing .homedirs|.local) now.

> 6) current file_contexts.bin vs contexts2 file_contexts.bin [Expected]
> selabel_compare /etc/selinux/targeted/contexts/files/file_contexts.bin
> contexts2/files/file_contexts.bin
> spec /etc/selinux/targeted/contexts/files/file_contexts.bin is equal
> to spec contexts2/files/file_contexts.bin
>
> 7) contexts1 file_contexts vs contexts2 file_contexts [Expected, but conf=
using]
> selabel_compare contexts1/files/file_contexts  contexts2/files/file_conte=
xts
> contexts1/files/file_contexts.bin:  Old compiled fcontext format, skippin=
g
> contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
> format, skipping
> spec contexts1/files/file_contexts is equal to spec
> contexts2/files/file_contexts

What is confusing here? selabel_open(3) tries to open binary fcontext
files first for performance.

> 8) contexts1 file_contexts vs contexts2 file_contexts.cpy (which is a
> copy of file_contexts) [Not expected. Expected them to be equal]
> selabel_compare contexts1/files/file_contexts contexts2/files/file_contex=
ts.cpy
> contexts1/files/file_contexts.bin:  Old compiled fcontext format, skippin=
g
> contexts1/files/file_contexts.homedirs.bin:  Old compiled fcontext
> format, skipping
> selabel_cmp: mismatch regex_str left remnant in stem tmp
> selabel_cmp: mismatch child node tmp stem (root)
> spec contexts1/files/file_contexts is uncomparable to spec
> contexts2/files/file_contexts.cpy
>
> With all of the issues, I wonder how useful this actually would be. It
> might cause more confusion then anything.
>
> Thanks,
> Jim
>
> > ---
> > v2:
> >    split nested block into own function
> > ---
> >  libselinux/utils/.gitignore        |   1 +
> >  libselinux/utils/selabel_compare.c | 122 +++++++++++++++++++++++++++++
> >  2 files changed, 123 insertions(+)
> >  create mode 100644 libselinux/utils/selabel_compare.c
> >
> > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> > index b3311360..2e10b14f 100644
> > --- a/libselinux/utils/.gitignore
> > +++ b/libselinux/utils/.gitignore
> > @@ -16,6 +16,7 @@ getseuser
> >  matchpathcon
> >  policyvers
> >  sefcontext_compile
> > +selabel_compare
> >  selabel_digest
> >  selabel_get_digests_all_partial_matches
> >  selabel_lookup
> > diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/sela=
bel_compare.c
> > new file mode 100644
> > index 00000000..9ca6eff1
> > --- /dev/null
> > +++ b/libselinux/utils/selabel_compare.c
> > @@ -0,0 +1,122 @@
> > +#include <getopt.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +#include <selinux/label.h>
> > +
> > +
> > +static void usage(const char *progname)
> > +{
> > +       fprintf(stderr,
> > +               "usage: %s [-b backend] [-v] file1 file2\n\n"
> > +               "Where:\n\t"
> > +               "-b           The backend - \"file\", \"media\", \"x\",=
 \"db\" or \"prop\" (defaults to \"file\")\n\t"
> > +               "-v           Validate entries against loaded policy.\n=
\t"
> > +               "file1/file2  Files containing the specs.\n",
> > +               progname);
> > +}
> > +
> > +static int compare(const char *file1, const char *file2, const char *v=
alidate, unsigned int backend)
> > +{
> > +       struct selabel_handle *hnd1, *hnd2;
> > +       const struct selinux_opt selabel_option1[] =3D {
> > +               { SELABEL_OPT_PATH, file1 },
> > +               { SELABEL_OPT_VALIDATE, validate }
> > +       };
> > +       const struct selinux_opt selabel_option2[] =3D {
> > +               { SELABEL_OPT_PATH, file2 },
> > +               { SELABEL_OPT_VALIDATE, validate }
> > +       };
> > +       enum selabel_cmp_result result;
> > +
> > +       hnd1 =3D selabel_open(backend, selabel_option1, 2);
> > +       if (!hnd1) {
> > +               fprintf(stderr, "ERROR: selabel_open - Could not obtain=
 handle for %s:  %m\n", file1);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       hnd2 =3D selabel_open(backend, selabel_option2, 2);
> > +       if (!hnd2) {
> > +               fprintf(stderr, "ERROR: selabel_open - Could not obtain=
 handle for %s:  %m\n", file2);
> > +               selabel_close(hnd1);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       result =3D selabel_cmp(hnd1, hnd2);
> > +
> > +       selabel_close(hnd2);
> > +       selabel_close(hnd1);
> > +
> > +       switch (result) {
> > +       case SELABEL_SUBSET:
> > +               printf("spec %s is a subset of spec %s\n", file1, file2=
);
> > +               break;
> > +       case SELABEL_EQUAL:
> > +               printf("spec %s is equal to spec %s\n", file1, file2);
> > +               break;
> > +       case SELABEL_SUPERSET:
> > +               printf("spec %s is a superset of spec %s\n", file1, fil=
e2);
> > +               break;
> > +       case SELABEL_INCOMPARABLE:
> > +               printf("spec %s is uncomparable to spec %s\n", file1, f=
ile2);
> > +               break;
> > +       default:
> > +               fprintf(stderr, "ERROR: selabel_cmp - Unexpected result=
 %d\n", result);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       return EXIT_SUCCESS;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       unsigned int backend =3D SELABEL_CTX_FILE;
> > +       int opt;
> > +       const char *validate =3D NULL, *file1 =3D NULL, *file2 =3D NULL=
;
> > +
> > +       if (argc < 3) {
> > +               usage(argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       while ((opt =3D getopt(argc, argv, "b:v")) > 0) {
> > +               switch (opt) {
> > +               case 'b':
> > +                       if (!strcasecmp(optarg, "file")) {
> > +                               backend =3D SELABEL_CTX_FILE;
> > +                       } else if (!strcmp(optarg, "media")) {
> > +                               backend =3D SELABEL_CTX_MEDIA;
> > +                       } else if (!strcmp(optarg, "x")) {
> > +                               backend =3D SELABEL_CTX_X;
> > +                       } else if (!strcmp(optarg, "db")) {
> > +                               backend =3D SELABEL_CTX_DB;
> > +                       } else if (!strcmp(optarg, "prop")) {
> > +                               backend =3D SELABEL_CTX_ANDROID_PROP;
> > +                       } else if (!strcmp(optarg, "service")) {
> > +                               backend =3D SELABEL_CTX_ANDROID_SERVICE=
;
> > +                       } else {
> > +                               fprintf(stderr, "Unknown backend: %s\n"=
, optarg);
> > +                               usage(argv[0]);
> > +                               return EXIT_FAILURE;
> > +                       }
> > +                       break;
> > +               case 'v':
> > +                       validate =3D (char *)1;
> > +                       break;
> > +               default:
> > +                       usage(argv[0]);
> > +                       return EXIT_FAILURE;
> > +               }
> > +       }
> > +
> > +       if (argc !=3D optind + 2) {
> > +               usage(argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       file1 =3D argv[optind++];
> > +       file2 =3D argv[optind];
> > +
> > +       return compare(file1, file2, validate, backend);
> > +}
> > --
> > 2.43.0
> >
> >
