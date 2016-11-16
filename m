MIME-Version: 1.0
In-Reply-To: <1479252622-20935-1-git-send-email-william.c.roberts@intel.com>
References: <1479252622-20935-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 16:33:35 -0800
Message-ID: <CAFftDdoxXB51B0-ZOG761oeSzHAes9njM7uJLDcmZCGgbKaVRg@mail.gmail.com>
Subject: Re: [PATCH take2 v5] libsepol: fix checkpolicy dontaudit compiler bug
To: William Roberts <william.c.roberts@intel.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>

>                 memset(&avdatum, 0, sizeof avdatum);
> +               /*
> +                * AUDITDENY and DONTAUDIT are &= assigned, versus |= for
> +                * others. Initialize the data accordingly.
> +                */
> +               avdatum.data = (key->specified &
> +                              (AVRULE_AUDITDENY | AVRULE_DONTAUDIT)) ? ~0 : 0;

Nak this, surprising this is working and producing correct output, but
we would want to check
against the AVTAB defines...

This patch, while simple, for some reason is getting the best of me :-P

>                 /* this is used to get the node - insertion is actually unique */
>                 node = avtab_insert_nonunique(avtab, key, &avdatum);
>                 if (!node) {
<snip>
