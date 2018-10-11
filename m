Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97239C4161D
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA482075C
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alJZXJRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA482075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeJKVzy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:55:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38312 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKVzx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 17:55:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id l1so9095674otj.5
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/dMZBm53Afxx2e4zkEl/4wjiStFA2M//qXLBuBQ7WY=;
        b=alJZXJRdTE8yXnG1fWUkF1GLEhlYa4rcEopUKs/3gYx+5M2I/PzbmY1GCDZhH8Gitz
         FG+kcEV2PCrKL2FUvRaHWfmrs+1pi6C/a8cT7hO1rsxsjVzT7qNQzJD6LjkzmUjglTRm
         CyoCt1BGNJPVkCsM7Azva5md1912OrP1gno36TSlP9KQD6AHFagCmTxfx3gwMVbuyrUy
         y8QRqz4v5lbuVQce8lv9CUSf7IYm9TKIt9Jj02/uPWklH/1D4tnYAp/1quOGoEtLzKxD
         LWChnvtebAAUaxAqIVKtqgMmMVubxjw3a48qlmO+hSSL+Li44aJcF+Jno2ZnvRKJ82c6
         HVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/dMZBm53Afxx2e4zkEl/4wjiStFA2M//qXLBuBQ7WY=;
        b=twGtc715G1G8pezLqhDw6LrqNpsEcnP4iIBLgtUe5H3ST718YNxexT047B1M86QzMn
         wJl0tRR2WB3KMRfRjc+qCfdjC855gvFqyq0qF5CDnlW7Sbi1qtxpn7QJvFPAWoR4gaME
         meONuJMA0328PLiSjIryGgqi+XOTugkUh0N75TBHwh1gXiHNjTO8xktei4OK8ip0uDTu
         fRkBSjLTsiJyoorPBskSTaXx9717ZrLajzQnm0gHQNjzdH8YKli1aCRJ8e64JrKVy/RI
         TQO7ejQIPTnAmbteB+itoGRrIb05WqSq91jWqigHZBSIdJC7sbuOLPyk5qhQD2h2Qy8q
         NaQw==
X-Gm-Message-State: ABuFfoi/GZoWNqoxSz0WHn4hlMU5AfZ3UwueBfgkCYjJ4iejUa/1xCvJ
        /cQM/m3qoeRUrrrbdmD4kF6sz4dHdDJGAvnU7lM=
X-Google-Smtp-Source: ACcGV611be1cw3F8UdLAaRn1QlL3EFiZiNo7cpuFZk0Y+oxf96d3aIMIuQRnMt1vXWzGK2nXFP5O8eECteCst0v2ixQ=
X-Received: by 2002:a9d:2949:: with SMTP id d67mr1244344otb.74.1539268106634;
 Thu, 11 Oct 2018 07:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181011123543.14822-1-jwcart2@tycho.nsa.gov> <20181011123543.14822-3-jwcart2@tycho.nsa.gov>
In-Reply-To: <20181011123543.14822-3-jwcart2@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Oct 2018 07:28:14 -0700
Message-ID: <CAFftDdotygz0kKM=AV6+Tzat+KQ6bMQH2UEhKhth1VGr2Pwa6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy: Add option to sort ocontexts when
 creating a binary policy
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 11, 2018 at 5:37 AM James Carter <jwcart2@tycho.nsa.gov> wrote:
>
> Add an option, specified by "-S" or "--sort", to sort the ocontexts
> before writing out the binary policy.
>
> Binary policies created by semanage and secilc are always sorted, so
> this option allows checkpolicy to be consistent with those. It has
> not been made the default to maintain backwards compatibility for
> anyone who might be depending on the unsorted behavior of checkpolicy.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  checkpolicy/checkpolicy.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 12c4c405..14dc91a3 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -111,9 +111,9 @@ unsigned int policyvers = POLICYDB_VERSION_MAX;
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
>         printf
> -           ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M]"
> -            "[-c policyvers (%d-%d)] [-o output_file] [-t target_platform (selinux,xen)]"
> -            "[input_file]\n",
> +           ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
> +            "[-c policyvers (%d-%d)] [-o output_file] [-S] "
> +            "[-t target_platform (selinux,xen)] [input_file]\n",
>              progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>         exit(1);
>  }
> @@ -394,7 +394,7 @@ int main(int argc, char **argv)
>         size_t scontext_len, pathlen;
>         unsigned int i;
>         unsigned int protocol, port;
> -       unsigned int binary = 0, debug = 0, cil = 0, conf = 0;
> +       unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0;
>         struct val_to_name v;
>         int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
>         unsigned int nel, uret;
> @@ -418,11 +418,12 @@ int main(int argc, char **argv)
>                 {"mls", no_argument, NULL, 'M'},
>                 {"cil", no_argument, NULL, 'C'},
>                 {"conf",no_argument, NULL, 'F'},
> +               {"sort", no_argument, NULL, 'S'},
>                 {"help", no_argument, NULL, 'h'},
>                 {NULL, 0, NULL, 0}
>         };
>
> -       while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFVc:h", long_options, NULL)) != -1) {
> +       while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:h", long_options, NULL)) != -1) {
>                 switch (ch) {
>                 case 'o':
>                         outfile = optarg;
> @@ -462,6 +463,9 @@ int main(int argc, char **argv)
>                                 break;
>                         }
>                         usage(argv[0]);
> +               case 'S':
> +                       sort = 1;
> +                       break;
>                 case 'M':
>                         mlspol = 1;
>                         break;
> @@ -637,6 +641,14 @@ int main(int argc, char **argv)
>                                 policy_file_init(&pf);
>                                 pf.type = PF_USE_STDIO;
>                                 pf.fp = outfp;
> +                               if (sort) {
> +                                       ret = policydb_sort_ocontexts(&policydb);
> +                                       if (ret) {
> +                                               fprintf(stderr, "%s:  error sorting ocontexts\n",
> +                                               argv[0]);
> +                                               exit(1);
> +                                       }
> +                               }
>                                 ret = policydb_write(&policydb, &pf);
>                         } else {
>                                 ret = sepol_kernel_policydb_to_conf(outfp, policydbp);
> --
> 2.17.1
>

Ack.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
