Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0844C04AB6
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03F62075B
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 17:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE1RBR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 13:01:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42572 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1RBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 13:01:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id w9so14831729oic.9
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 10:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6vWpLjsVkMxLIbNUm2Ll376Ouo083cWXrl3FcHYHaGM=;
        b=Ov5gOXrXJxrm8tO2LEyx4X4LkTow3VzyzY2yZZLAwqEpy1cVZb8LUYilqz86vigSU9
         3cNu5rYJYMyT529ow+rejURZlYiaAy0pbfSKPRWWJlCreno8ghcN0CgL8o91X80Svjmc
         Q77eKawCWcvXL1eskyPjAsOWDFNQDa6C53v2aexYIprBfyVvMmlY+Lc983WTcK3NPduz
         JQDyJv9CfjGO3j6/RzzoSZOv4QhDd2GJHMwASDzuuGTHH+QZ+jAY9ps9wxQdcccG4qLH
         1I2Dv/W+yxmREhptw51NHUb8pZllEQoHuo8B5Fgp9LHGE9dR/1QDXVSVlp84pRqmwoey
         74kw==
X-Gm-Message-State: APjAAAVENF4STfIefJ1A/0MpsLUSW4eBt+VbaHn27FqF42Rkg+1RSYyR
        g6Zn1iIEGApYB9pIt6tMYaRwmi3Owa1ISh99MC1idg==
X-Google-Smtp-Source: APXvYqz7TTyH2dV5kBzKw/sKSjBHTdD+i/nTD+QqI+HTC1fjC1GWXV9cmneYkoWJeoNBtz28BP6gopWoCZjHFr2XNdw=
X-Received: by 2002:aca:3387:: with SMTP id z129mr3366563oiz.166.1559062876567;
 Tue, 28 May 2019 10:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190528145912.13827-1-omosnace@redhat.com> <20190528145912.13827-5-omosnace@redhat.com>
 <20190528163207.GA12099@brutus.lan>
In-Reply-To: <20190528163207.GA12099@brutus.lan>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 28 May 2019 19:01:08 +0200
Message-ID: <CAFqZXNtcc9Uqy3r_y5wW5yAAs5QbdXuBvHk17j-kEzQOcXfG2w@mail.gmail.com>
Subject: Re: [PATCH userspace v2 4/7] secilc: add flag to enable policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 28, 2019 at 6:32 PM Dominick Grift <dac.override@gmail.com> wrote:
>
> On Tue, May 28, 2019 at 04:59:09PM +0200, Ondrej Mosnacek wrote:
> > Add a command-line option -O/--optimize to optimize the final policydb
> > using sepol_policydb_optimize() before writing it out.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  secilc/secilc.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/secilc/secilc.c b/secilc/secilc.c
> > index ad6862ba..26996ef9 100644
> > --- a/secilc/secilc.c
> > +++ b/secilc/secilc.c
> > @@ -68,6 +68,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
> >       printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
> >       printf("  -X, --expand-size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
> >       printf("                                 members.\n");
> > +     printf("  -n, --no-optimize              do not optimize final policy\n");
>
> I think something may have gone wrong here.

Ouch, you're right, I accidentally squashed the conversion into the
wrong patch (5/7). Will fix it up tomorrow.


>
> >       printf("  -v, --verbose                  increment verbosity level\n");
> >       printf("  -h, --help                     display usage information\n");
> >       exit(1);
> > @@ -97,6 +98,7 @@ int main(int argc, char *argv[])
> >       int policyvers = POLICYDB_VERSION_MAX;
> >       int attrs_expand_generated = 0;
> >       int attrs_expand_size = -1;
> > +     int optimize_policy = 1;
> >       int opt_char;
> >       int opt_index = 0;
> >       char *fc_buf = NULL;
> > @@ -117,12 +119,13 @@ int main(int argc, char *argv[])
> >               {"filecontexts", required_argument, 0, 'f'},
> >               {"expand-generated", no_argument, 0, 'G'},
> >               {"expand-size", required_argument, 0, 'X'},
> > +             {"no-optimize", no_argument, 0, 'n'},
> >               {0, 0, 0, 0}
> >       };
> >       int i;
> >
> >       while (1) {
> > -             opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:", long_opts, &opt_index);
> > +             opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:n", long_opts, &opt_index);
> >               if (opt_char == -1) {
> >                       break;
> >               }
> > @@ -211,6 +214,9 @@ int main(int argc, char *argv[])
> >                               }
> >                               break;
> >                       }
> > +                     case 'n':
> > +                             optimize_policy = 0;
> > +                             break;
> >                       case 'h':
> >                               usage(argv[0]);
> >                       case '?':
> > @@ -294,6 +300,14 @@ int main(int argc, char *argv[])
> >               goto exit;
> >       }
> >
> > +     if (optimize_policy) {
> > +             rc = sepol_policydb_optimize(pdb);
> > +             if (rc != SEPOL_OK) {
> > +                     fprintf(stderr, "Failed to optimize policydb\n");
> > +                     goto exit;
> > +             }
> > +     }
> > +
> >       if (output == NULL) {
> >               int size = snprintf(NULL, 0, "policy.%d", policyvers);
> >               output = malloc((size + 1) * sizeof(char));
> > --
> > 2.20.1
> >
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift



--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
