Return-Path: <SRS0=MPXq=TJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D0C04A6B
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 00:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF60F214AF
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 00:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEIAVb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 May 2019 20:21:31 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:44198 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfEIAVb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 May 2019 20:21:31 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 20:21:30 EDT
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 5659C5C0F61; Thu,  9 May 2019 02:13:45 +0200 (CEST)
Date:   Thu, 9 May 2019 02:13:45 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] selinux: provide __le variables explicitly
Message-ID: <20190509001345.GA23407@osadl.at>
References: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
 <CAHC9VhSU7pzWby78gHkYKm3t1LopSCoHBfmp=uBc+mF234K8mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSU7pzWby78gHkYKm3t1LopSCoHBfmp=uBc+mF234K8mg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 08, 2019 at 05:47:32PM -0400, Paul Moore wrote:
> On Wed, May 8, 2019 at 2:27 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > While the endiannes is being handled properly sparse was unable to verify
> > this due to type inconsistency. So introduce an additional __le32
> > respectively _le64 variable to be passed to le32/64_to_cpu() to allow
> > sparse to verify proper typing. Note that this patch does not change
> > the generated binary on little-endian systems - on 32bit powerpc it
> > does change the binary.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> >
> > Problem located by an experimental coccinelle script to locate
> > patters that make sparse unhappy (false positives):
> >
> > sparse complaints on different architectures fixed by this patch are:
> >
> > ppc6xx_defconfig
> >   CHECK   security/selinux/ss/ebitmap.c
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> >
> > Little-endian systems:
> >
> > loongson3_defconfig
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> >
> > x86_64_defconfig
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> >
> > Patch was compile-tested with: x86_64_defconfig,loongson3_defconfig (both
> > little-endian) and ppc603_defconfig (big-endian).
> >
> > On little-endian systems the patch has no impact on the generated binary
> > (which is expected) but on the 32bit powerpc it does change the binary
> > which is not expected but since I'm not able to generate the .lst files
> > in security/selinux/ss/ due to the lack of a Makefile it is not clear
> > if this is an unexpected side-effect or due only to the introduction of
> > the additional variables. From my understanding the patch does not change
> > the program logic so if the code was correct on big-endian systems before
> > it should still be correct now.
> 
> This is a bit worrisome, but I tend to agree that this patch *should*
> be correct.  I'm thinking you're probably right in that the resulting
> binary difference could be due to the extra variable.  Have you tried
> any other big-endian arches?
>

just tried ppc64_defconfig + AUDIT=y, SECURITY=y, SECURITY_NETWORK=y, SECURITY_SELINUX=y

sparse will complain in the original version about:
  CHECK   security/selinux/ss/ebitmap.c
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64

which is the same as 32bit ppc - after the patch is applied that is resolved
and and the generated ebitmap.o files are binary identical.

I just had chosen ppc6xx_defconfig as my big-endian test-target as SELINUX
was on there by default so I assumed it would be the most reasonable
compile-test target.

thx!
hofrat
 
> > Patch is against 5.1 (localversion-next is next-20190506)
> >
> >  security/selinux/ss/ebitmap.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> > index 8f624f8..09929fc 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -347,7 +347,9 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >  {
> >         struct ebitmap_node *n = NULL;
> >         u32 mapunit, count, startbit, index;
> > +       __le32 ebitmap_start;
> >         u64 map;
> > +       __le64 mapbits;
> >         __le32 buf[3];
> >         int rc, i;
> >
> > @@ -381,12 +383,12 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >                 goto bad;
> >
> >         for (i = 0; i < count; i++) {
> > -               rc = next_entry(&startbit, fp, sizeof(u32));
> > +               rc = next_entry(&ebitmap_start, fp, sizeof(u32));
> >                 if (rc < 0) {
> >                         pr_err("SELinux: ebitmap: truncated map\n");
> >                         goto bad;
> >                 }
> > -               startbit = le32_to_cpu(startbit);
> > +               startbit = le32_to_cpu(ebitmap_start);
> >
> >                 if (startbit & (mapunit - 1)) {
> >                         pr_err("SELinux: ebitmap start bit (%d) is "
> > @@ -423,12 +425,12 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >                         goto bad;
> >                 }
> >
> > -               rc = next_entry(&map, fp, sizeof(u64));
> > +               rc = next_entry(&mapbits, fp, sizeof(u64));
> >                 if (rc < 0) {
> >                         pr_err("SELinux: ebitmap: truncated map\n");
> >                         goto bad;
> >                 }
> > -               map = le64_to_cpu(map);
> > +               map = le64_to_cpu(mapbits);
> >
> >                 index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
> >                 while (map) {
> > --
> > 2.1.4
> >
> 
> 
> -- 
> paul moore
> www.paul-moore.com
