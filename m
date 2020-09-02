Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7455DC433E2
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF3207EA
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 08:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DrUSlSd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBIjL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:39:11 -0400
Received: from m12-16.163.com ([220.181.12.16]:46670 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIBIil (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 2 Sep 2020 04:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lUTeL
        Tzl7lzy+Iy0XxoBHUeab4DelJ8tHKpi4tR6muo=; b=DrUSlSd9aZhG4ISLz90jj
        ZADyQeq0pVXjptBLRmnI4fLz+fcAFzy4R6zu56TeyurAKfbxgopKFEZ+RuUBX2Kk
        iT3AAPqWLx6e+RBiQgy3KXpLREvLhNPpqajiYO5J9NGMT63hXtrHjYGOcEo3kOZf
        5hiRmQP4fw/nIEY4QVh0k4=
Received: from localhost (unknown [106.37.187.137])
        by smtp12 (Coremail) with SMTP id EMCowABHGv4KWk9fIxz9Tg--.38100S2;
        Wed, 02 Sep 2020 16:38:34 +0800 (CST)
Date:   Wed, 2 Sep 2020 16:38:34 +0800
From:   liwugang <liwugang@163.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] Optimize the calculation of security.sehash
Message-ID: <20200902083834.GA4400@mi-OptiPlex-9020>
References: <20200901114245.3657-1-liwugang@163.com>
 <CAEjxPJ7RU037b3m0rhzNQnGFJuX9UXZirpUwEXdeQfGxjUWwDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7RU037b3m0rhzNQnGFJuX9UXZirpUwEXdeQfGxjUWwDw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CM-TRANSID: EMCowABHGv4KWk9fIxz9Tg--.38100S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryUGw4xXr17Xw48JFy3twb_yoWrZF43pa
        yDGF13XrW8GFWxGrn7CF1UAFyYvw4ruF13GF4UG34rKr98ur1vqa92krya9FnrJr1fJ3WS
        vF1YqrWDuayUZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07US9aPUUUUU=
X-Originating-IP: [106.37.187.137]
X-CM-SenderInfo: 5olz3wxdqjqiywtou0bp/1tbiuwqTs1PAImMkewAAsc
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 01, 2020 at 08:39:55AM -0400, Stephen Smalley wrote:
> On Tue, Sep 1, 2020 at 7:59 AM liwugang <liwugang@163.com> wrote:
> >
> > The hash of each directory should be determined by the file contexts of
> > the current directory and subdirectories, but the existing logic also
> > includes the ancestor directories. The first optimization is to exclude
> > them. So it should be break When the first complete match found in function
> > lookup_all.
> >
> > If the current directory has corresponding file contexts and subdirectories
> > have not, subdirectories will use the current direcorty's. There is no need
> > to calculate the hash for the subdirectories. It will save time, espacially
> > for user data(/data/media/0/). The second optimization is not to check the
> > hash of the subdirectories.
> >
> > Example:
> > /data/(.*)?           u:object_r:system_data_file:s0
> > /data/backup(/.*)?    u:object_r:backup_data_file:s0
> >
> > If the file context of "/data/(.*)?" changes and "/data/backup(/.*)?" does not
> > change, directory(/data/backup) and the subdirectories will restorecon because of
> > hash changed. But actually there is no need the restorecon.
> >
> > Signed-off-by: liwugang <liwugang@163.com>
> > ---
> >  libselinux/include/selinux/label.h            |  5 +--
> >  libselinux/src/label.c                        | 11 +++---
> >  libselinux/src/label_file.c                   | 17 +++++++---
> >  libselinux/src/label_internal.h               |  6 ++--
> >  libselinux/src/selinux_restorecon.c           | 34 ++++++++++++++-----
> >  .../selabel_get_digests_all_partial_matches.c |  3 +-
> >  6 files changed, 55 insertions(+), 21 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> > index e8983606..d91ceb6f 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -110,9 +110,10 @@ extern bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
> >                                                     const char *key,
> >                                                     uint8_t **calculated_digest,
> >                                                     uint8_t **xattr_digest,
> > -                                                   size_t *digest_len);
> > +                                                   size_t *digest_len,
> > +                                                   size_t *num_matches);
> >  extern bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> > -                                            const char *key, uint8_t* digest);
> > +                                            const char *key, uint8_t* digest, size_t *num_matches);
> >
> >  extern int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
> >                                      const char *key, const char **aliases, int type);
> 
> This is a public API and a stable ABI for libselinux, so you cannot
> make incompatible changes to it.
> You would need to introduce a new API with the extended interface.
> 

OK, I will add new API.

> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 6eeeea68..c99eb251 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -955,7 +955,10 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
> >                                 if (match_count) {
> >                                         result[*match_count] = spec;
> >                                         *match_count += 1;
> > -                                       // Continue to find all the matches.
> > +                                       if (rc == REGEX_MATCH) {
> > +                                               break;
> > +                                       }
> > +                                       // Continue to find the matches until the first full match found.
> 
> I'm not sure this works the way you intend.  /data/(.*)? is a full
> match for /data/backup.  Do you want to stop there and not include
> /data/backup(/.*)? This also changes behavior of an existing API/ABI
> in an incompatible manner.
> 

My original intention is that /data/backup(/.*)? is always after /data/(.*)?,
traversing from back to front, The /data/backup(/.*)? will first be meet
the condition. But after checking the code, the function sort_specs don't
sort the entries. just put the entries with the meta characters in the front.
So it can't guarantee the sequence I want.
I think I also need add the function to sort the entries.

> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> > index 6993be6f..417b619c 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> 
> Last I looked, Android wasn't using the upstream selinux_restorecon
> (which was actually a back-port / adaptation of Android's
> selinux_android_restorecon to upstream) at all, so any changes here
> won't actually affect Android relabeling AFAIK.

Yes, I think upstream will also benefit from this patch. 
Thanks very much to review the patch.

