Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LJLEJI018278
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 15:21:14 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7LJLCtV029075
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 19:21:12 GMT
Received: by wx-out-0506.google.com with SMTP id h30so1741558wxd
        for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 12:21:12 -0700 (PDT)
Message-ID: <7e0fb38c0708211221g39b4fd73y3e1ee8ef8e6a8417@mail.gmail.com>
Date: Tue, 21 Aug 2007 15:21:12 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: [patch] libsepol: eliminate unaligned accesses (Was: Re: wrong magic number (using old sources))
Cc: selinux770@tortenboxer.de, selinux@tycho.nsa.gov,
        "Joshua Brindle" <method@manicmethod.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
In-Reply-To: <1187715923.1451.164.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810101003.128080@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net> <20070811180730.308640@gmx.net>
	 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20070815154407.250820@gmx.net>
	 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20070816080523.135750@gmx.net>
	 <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1187715923.1451.164.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not sure why I went over this patch, but looks pretty good 5 or so
comments inline.


*****policydb.c
> @@ -2683,12 +2697,13 @@
>  static int range_trans_rule_read(range_trans_rule_t ** r,
>                                  struct policy_file *fp)
>  {
> -       uint32_t *buf, nel;
> +       uint32_t buf[2], nel;

why buf[2] ?   looks like buf[1] would suffice.

>         unsigned int i;
>         range_trans_rule_t *rt, *lrt = NULL;
> +       int rc;
>
> -       buf = next_entry(fp, sizeof(uint32_t));
> -       if (!buf)
> +       rc = next_entry(buf, fp, sizeof(uint32_t));
> +       if (rc < 0)
>                 return -1;
>         nel = le32_to_cpu(buf[0]);
>         for (i = 0; i < nel; i++) {



> @@ -2799,11 +2818,12 @@
>                              struct policy_file *fp)
>  {
>         avrule_block_t *last_block = NULL, *curblock;
> -       uint32_t *buf, num_blocks, nel;
> +       uint32_t buf[2], num_blocks, nel;

Another why buf[2]

> +       int rc;
>
> -       if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
> +       rc = next_entry(buf, fp, sizeof(uint32_t));
> +       if (rc < 0)
>                 return -1;
> -       }
>         num_blocks = le32_to_cpu(buf[0]);
>         nel = num_blocks;
>         while (num_blocks > 0) {



******module.c
> @@ -415,9 +418,9 @@
>                               struct sepol_policy_file *spf, int verbose)
>  {
>         struct policy_file *file = &spf->pf;
> -       uint32_t *buf, nsec;
> +       uint32_t buf[5], nsec;

why buf[5]  isn't 1 enough here?

>         size_t *offsets, len;
> -       int retval = -1;
> +       int rc;
>         unsigned i, seen = 0;
>
>         if (module_package_read_offsets(mod, file, &offsets, &nsec))


> @@ -593,7 +596,7 @@
>
>        cleanup:
>         free(offsets);
> -       return retval;
> +       return -1;
why throw away rc?  just generally useless here?
>  }
>  int sepol_module_package_info(struct sepol_policy_file *spf, int *type,



> Index: trunk/libsepol/src/avtab.c
> ===================================================================
> --- trunk/libsepol/src/avtab.c  (revision 2520)
> +++ trunk/libsepol/src/avtab.c  (working copy)
> @@ -337,8 +337,8 @@
>                     int (*insertf) (avtab_t * a, avtab_key_t * k,
>                                     avtab_datum_t * d, void *p), void *p)
>  {
> -       uint16_t *buf16, enabled;
> -       uint32_t *buf32, items, items2, val;
> +       uint16_t buf16[4], enabled;
> +       uint32_t buf32[7], items, items2, val;

looks like buf32 was allowed to be up to 8 but now only 7.  Just know
something about how this will be used that you know 7 is enough?  I
didn't dig into it.

>         avtab_key_t key;
>         avtab_datum_t datum;
>         unsigned set;
> @@ -349,20 +349,20 @@
>         memset(&datum, 0, sizeof(avtab_datum_t));
>
>         if (vers < POLICYDB_VERSION_AVTAB) {
> -               buf32 = next_entry(fp, sizeof(uint32_t));
> -               if (!buf32) {
> +               rc = next_entry(buf32, fp, sizeof(uint32_t));
> +               if (rc < 0) {
>                         ERR(fp->handle, "truncated entry");
>                         return -1;
>                 }
>                 items2 = le32_to_cpu(buf32[0]);
>
> -               if (items2 < 5 || items2 > 8) {
> +               if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
>                         ERR(fp->handle, "invalid item count");
>                         return -1;
>                 }
>
> -               buf32 = next_entry(fp, sizeof(uint32_t) * items2);
> -               if (!buf32) {
> +               rc = next_entry(buf32, fp, sizeof(uint32_t) * items2);
> +               if (rc < 0) {
>                         ERR(fp->handle, "truncated entry");
>                         return -1;
>                 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
