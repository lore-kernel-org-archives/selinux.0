Subject: Re: [patch] libsepol: eliminate unaligned accesses (Was: Re: wrong
	magic number (using old sources))
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux770@tortenboxer.de, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <7e0fb38c0708211221g39b4fd73y3e1ee8ef8e6a8417@mail.gmail.com>
References: <20070810101003.128080@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net> <20070811180730.308640@gmx.net>
	 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20070815154407.250820@gmx.net>
	 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20070816080523.135750@gmx.net>
	 <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1187715923.1451.164.camel@moss-spartans.epoch.ncsc.mil>
	 <7e0fb38c0708211221g39b4fd73y3e1ee8ef8e6a8417@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 15:33:48 -0400
Message-Id: <1187724828.1451.210.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 15:21 -0400, Eric Paris wrote:
> Not sure why I went over this patch, but looks pretty good 5 or so
> comments inline.
> 
> 
> *****policydb.c
> > @@ -2683,12 +2697,13 @@
> >  static int range_trans_rule_read(range_trans_rule_t ** r,
> >                                  struct policy_file *fp)
> >  {
> > -       uint32_t *buf, nel;
> > +       uint32_t buf[2], nel;
> 
> why buf[2] ?   looks like buf[1] would suffice.

True, fixed.  Cut-and-paste.

> >         unsigned int i;
> >         range_trans_rule_t *rt, *lrt = NULL;
> > +       int rc;
> >
> > -       buf = next_entry(fp, sizeof(uint32_t));
> > -       if (!buf)
> > +       rc = next_entry(buf, fp, sizeof(uint32_t));
> > +       if (rc < 0)
> >                 return -1;
> >         nel = le32_to_cpu(buf[0]);
> >         for (i = 0; i < nel; i++) {
> 
> 
> 
> > @@ -2799,11 +2818,12 @@
> >                              struct policy_file *fp)
> >  {
> >         avrule_block_t *last_block = NULL, *curblock;
> > -       uint32_t *buf, num_blocks, nel;
> > +       uint32_t buf[2], num_blocks, nel;
> 
> Another why buf[2]

Ditto.

> 
> > +       int rc;
> >
> > -       if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
> > +       rc = next_entry(buf, fp, sizeof(uint32_t));
> > +       if (rc < 0)
> >                 return -1;
> > -       }
> >         num_blocks = le32_to_cpu(buf[0]);
> >         nel = num_blocks;
> >         while (num_blocks > 0) {
> 
> 
> 
> ******module.c
> > @@ -415,9 +418,9 @@
> >                               struct sepol_policy_file *spf, int verbose)
> >  {
> >         struct policy_file *file = &spf->pf;
> > -       uint32_t *buf, nsec;
> > +       uint32_t buf[5], nsec;
> 
> why buf[5]  isn't 1 enough here?

Ditto.

> 
> >         size_t *offsets, len;
> > -       int retval = -1;
> > +       int rc;
> >         unsigned i, seen = 0;
> >
> >         if (module_package_read_offsets(mod, file, &offsets, &nsec))
> 
> 
> > @@ -593,7 +596,7 @@
> >
> >        cleanup:
> >         free(offsets);
> > -       return retval;
> > +       return -1;
> why throw away rc?  just generally useless here?

rc gets overwritten as we read each section of the package, and we want
to ensure that we don't ultimately return success when we failed.  And
it wasn't useful to preserve a distinct return value anyway.

> >  }
> >  int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
> 
> 
> 
> > Index: trunk/libsepol/src/avtab.c
> > ===================================================================
> > --- trunk/libsepol/src/avtab.c  (revision 2520)
> > +++ trunk/libsepol/src/avtab.c  (working copy)
> > @@ -337,8 +337,8 @@
> >                     int (*insertf) (avtab_t * a, avtab_key_t * k,
> >                                     avtab_datum_t * d, void *p), void *p)
> >  {
> > -       uint16_t *buf16, enabled;
> > -       uint32_t *buf32, items, items2, val;
> > +       uint16_t buf16[4], enabled;
> > +       uint32_t buf32[7], items, items2, val;
> 
> looks like buf32 was allowed to be up to 8 but now only 7.  Just know
> something about how this will be used that you know 7 is enough?  I
> didn't dig into it.

The old code was wrong (and the new code is consistent with the kernel).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
