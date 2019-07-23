Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2781C76186
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626B42253D
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pmiIzFW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfGWUVx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:21:53 -0400
Received: from usfb19pa16.eemsg.mail.mil ([214.24.26.87]:33581 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfGWUVw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jul 2019 16:21:52 -0400
X-EEMSG-check-017: 223777609|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Jul 2019 20:21:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1563913308; x=1595449308;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=gVtN9NeSo/YQlsCupy25lHiVA9fisvKQgcVzCV/q6Ss=;
  b=pmiIzFW1ItVStugFvpBhLNap2g/XFTw5tnNrm6S1Xh2ApZBa6L5zAasd
   Xbc23Jeafr75FzLLx3xWeENAnkwnRRFuHryKXcXC7S2Kf2SlqWBUj1rEh
   XwCpyzmDeocBlpXJsxVjyGXC6UKKntSAtpA2dzW072tl3NKFjf1aO99/W
   rg/+Wa+puuAtkgKoqrZkxnl3pqQEfQipSRD2ygX8Td+pFOT4gqMCJPr3W
   PLNyLQeCMmjLnLAAXJCMMny1C5xjjqxqD/mcPyeem1Pgd5k/JCZ+A/N6X
   TTn030Bwo9nkDoo8vjtZFbNMYWcYQ/WnwAgfIgZi7E+Pyy4GRcyX9WxA+
   A==;
X-IronPort-AV: E=Sophos;i="5.64,300,1559520000"; 
   d="scan'208";a="30539184"
IronPort-PHdr: =?us-ascii?q?9a23=3Ao/0O/Ban5/0MUaDQiJhqg3n/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps29bR7h7PlgxGXEQZ/co6odzbaP6ea/CSdZvcvJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/Tu8QVjoduN6k8xx?=
 =?us-ascii?q?vUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBeyGw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmtiE6yrgctp?=
 =?us-ascii?q?66eigH0JcnyADFa/yBbYeI5gjvVOGLITd3nH5ld7W/hxG98Uik1OL8Tc600E?=
 =?us-ascii?q?tQriVZjNbArGwC1xvW6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaOcQaqbK5Aw9SyIoj7QqwDyy639?=
 =?us-ascii?q?gCmHkHLVZFdAqGj4jvJV7OPOj1Aeqwjlmjijtmx+3KMqf/DpjCMHTPiqrtca?=
 =?us-ascii?q?5460FGyQozyd5f54hTCrEEOP/zQVL+tMfDAx8lMw273+bnCNJn2oMYQmKAGL?=
 =?us-ascii?q?WVMKzVsV+W/u4vOfWDZJcJuDbhLPgo//jujX4lll8aeammx4AXZGq5HvRhJE?=
 =?us-ascii?q?WZemHsj8wEEWoFsQsyVuvqiEeNUTRLfXa9Q7o85i0nCIKhFYrCSZ2tgLqd0y?=
 =?us-ascii?q?e7BJJWYG9GB0uDEXfvcIWEVPMMZzyILsB9lTwEUKCrS5U92hG2qA/6171nI/?=
 =?us-ascii?q?LO+i0ZqZ3j1MJ65/fOmh4q6TN7F8Sd3HuMT2FygGwIXCQ707tjoUx8zFeDzb?=
 =?us-ascii?q?Z3g+ZeFdNN+/NFSBs1NZnZz+ZiEdD9RhrBfsuVSFahWtimGi8+TtYww98Ifk?=
 =?us-ascii?q?Z8FM6vjg7M3yW0Gb8Zjb+LC4Iu8qLawXfxI9xxy3Hc1Kku3BEaRZ5pNGahgq?=
 =?us-ascii?q?dkvynUAJXS2xGflq2tca0Hmi/K83yY5W/SrAdfSgEmFe3VQHYUZkLQopyt9l?=
 =?us-ascii?q?7ERL+nD7sPPQxGxsqPbKBNb4utxW9HT/fqItiWQ2uwnWqrTUKSx7iMZZDmTG?=
 =?us-ascii?q?4q3CzcDkUfuwoP/HCaOBI4CzvnqGXbWngmDl/rYkXx4cFgp36hCEw51QeHaw?=
 =?us-ascii?q?tmzbXm1AQSgKmnV/4L3r8C8BwkojFwEUf1i8naEPKctgFhe+Naetp771BZgz?=
 =?us-ascii?q?GK/zdhN4CtevgxzmUVdB566ga3jUR6?=
X-IPAS-Result: =?us-ascii?q?A2AoDQAAazdd/wHyM5BmHgEGBwaBZ4FtKm1RATIqhB2SF?=
 =?us-ascii?q?lABAQEGgQkIJX6IZJEXCQEBAQEBAQEBAS0HAQIBAYN6RgKCTiM4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEFAQFshR4MgjopAYJmAQEBAQIBIwQRUQsYAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?wGBdgUPD6sEfzOEMgELAYEIgyyBQgaBDCiEcoZtF3iBB4ERJwyCKjU+h0+CW?=
 =?us-ascii?q?ASMGAaIU4EulEQJghuCH4Q5jS4GG4ItlV2NNYExhheSFyE3gSErCAIYCCEPg?=
 =?us-ascii?q?ycTgjgCAReDToUUhVsjAzABAYEEAQGOXgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Jul 2019 20:21:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6NKLiVa026678;
        Tue, 23 Jul 2019 16:21:44 -0400
Subject: Re: [PATCH] Restorecon: factor out a lookup helper for context
 matches
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        xunchang <xunchang@google.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20190311222442.49824-1-xunchang@google.com>
 <3a5038d7-cb5b-de62-23ee-e22324a8a989@tycho.nsa.gov>
 <CAJfZ7=mdnfCS6-PH-Mpu=237jZdfm9k0wpwcj-=W8YacOGa7eA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <43d3c491-4fd3-22ee-2074-56320af29389@tycho.nsa.gov>
Date:   Tue, 23 Jul 2019 16:21:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mdnfCS6-PH-Mpu=237jZdfm9k0wpwcj-=W8YacOGa7eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/23/19 4:06 PM, Nicolas Iooss wrote:
> On Wed, Jun 19, 2019 at 4:45 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 3/11/19 6:24 PM, xunchang wrote:
>>> We used to hash the file_context and skip the restorecon on the top
>>> level directory if the hash doesn't change. But the file_context might
>>> change after an update; and some users experienced long restorecon
>>> time as they have lots of files under directories like /data/media.
>>> Therefore, we try to skip unnecessary restores if the file context
>>> relates to the given directory doesn't change.
>>>
>>> This CL is the first step that factors out a lookup helper function
>>> and returns an array of matched pointers instead of a single one.
>>> The old loopup_common function is then modified to take the first
>>> element in the array.
>>>
>>> This change has already been submitted in android selinux branch. And
>>> porting it upstream will make these two branches more consistent and
>>> save some work for the future merges.
>>
>> There were some changes to this patch before it landed in AOSP, so they
>> aren't quite consistent.  Do you want to submit the final patch?
> 
> Hello,
> 
> What are the states of this patch and the one which has been posted in
> April (https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/)?
> I do not follow what happens in Android but if the patches have been
> modified there, it seems a good idea to post the modified patches to
> selinux@vger.kernel.org.

FWIW, the Android patch that was ultimately merged can be seen and 
downloaded from 
https://android-review.googlesource.com/c/platform/external/selinux/+/918713. 
  The posted patch was the version 1 patch.


> 
> Thanks,
> Nicolas
> 
>>>
>>> Signed-off-by: Tianjie Xu <xunchang@google.com>
>>> ---
>>>    libselinux/include/selinux/label.h |   4 ++
>>>    libselinux/src/label.c             |   9 +++
>>>    libselinux/src/label_file.c        | 111 +++++++++++++++++++++++------
>>>    libselinux/src/label_internal.h    |   2 +
>>>    4 files changed, 106 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
>>> index 277287ed..e537aa11 100644
>>> --- a/libselinux/include/selinux/label.h
>>> +++ b/libselinux/include/selinux/label.h
>>> @@ -7,6 +7,7 @@
>>>    #define _SELABEL_H_
>>>
>>>    #include <stdbool.h>
>>> +#include <stdint.h>
>>>    #include <sys/types.h>
>>>    #include <selinux/selinux.h>
>>>
>>> @@ -105,6 +106,9 @@ int selabel_lookup_raw(struct selabel_handle *handle, char **con,
>>>
>>>    bool selabel_partial_match(struct selabel_handle *handle, const char *key);
>>>
>>> +bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
>>> +                                      const char *key, uint8_t* digest);
>>> +
>>>    int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>>>                              const char *key, const char **aliases, int type);
>>>    int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
>>> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
>>> index 8d586bda..1d16f685 100644
>>> --- a/libselinux/src/label.c
>>> +++ b/libselinux/src/label.c
>>> @@ -274,6 +274,15 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
>>>        return rec->func_partial_match(rec, key);
>>>    }
>>>
>>> +bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
>>> +                                      const char *key, uint8_t *digest) {
>>> +     if (!rec->func_hash_all_partial_matches) {
>>> +             return false;
>>> +     }
>>> +
>>> +     return rec->func_hash_all_partial_matches(rec, key, digest);
>>> +}
>>> +
>>>    int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>>>                              const char *key, const char **aliases, int type)
>>>    {
>>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>>> index b81fd552..90cbd666 100644
>>> --- a/libselinux/src/label_file.c
>>> +++ b/libselinux/src/label_file.c
>>> @@ -843,22 +843,38 @@ static void closef(struct selabel_handle *rec)
>>>        free(data);
>>>    }
>>>
>>> -static struct spec *lookup_common(struct selabel_handle *rec,
>>> -                                          const char *key,
>>> -                                          int type,
>>> -                                          bool partial)
>>> +// Finds all the matches of |key| in the given context. Returns the result in
>>> +// the allocated array and updates the match count. If match_count is NULL,
>>> +// stops early once the 1st match is found.
>>> +static const struct spec **lookup_all(struct selabel_handle *rec,
>>> +                                      const char *key,
>>> +                                      int type,
>>> +                                      bool partial,
>>> +                                      size_t *match_count)
>>>    {
>>>        struct saved_data *data = (struct saved_data *)rec->data;
>>>        struct spec *spec_arr = data->spec_arr;
>>>        int i, rc, file_stem;
>>>        mode_t mode = (mode_t)type;
>>>        const char *buf;
>>> -     struct spec *ret = NULL;
>>>        char *clean_key = NULL;
>>>        const char *prev_slash, *next_slash;
>>>        unsigned int sofar = 0;
>>>        char *sub = NULL;
>>>
>>> +     const struct spec **result = NULL;
>>> +     if (match_count) {
>>> +             *match_count = 0;
>>> +             result = calloc(data->nspec, sizeof(struct spec*));
>>> +     } else {
>>> +             result = calloc(1, sizeof(struct spec*));
>>> +     }
>>> +     if (!result) {
>>> +             selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes of data\n",
>>> +                         data->nspec * sizeof(struct spec*));
>>> +             goto finish;
>>> +     }
>>> +
>>>        if (!data->nspec) {
>>>                errno = ENOENT;
>>>                goto finish;
>>> @@ -899,18 +915,33 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>>>                 * specified or if the mode matches the file mode then we do
>>>                 * a regex check        */
>>>                if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
>>> -                 (!mode || !spec->mode || mode == spec->mode)) {
>>> +                             (!mode || !spec->mode || mode == spec->mode)) {
>>>                        if (compile_regex(data, spec, NULL) < 0)
>>>                                goto finish;
>>>                        if (spec->stem_id == -1)
>>>                                rc = regex_match(spec->regex, key, partial);
>>>                        else
>>>                                rc = regex_match(spec->regex, buf, partial);
>>> -                     if (rc == REGEX_MATCH) {
>>> -                             spec->matches++;
>>> -                             break;
>>> -                     } else if (partial && rc == REGEX_MATCH_PARTIAL)
>>> +
>>> +                     if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
>>> +                             if (rc == REGEX_MATCH) {
>>> +                                     spec->matches++;
>>> +                             }
>>> +
>>> +                             if (strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
>>> +                                     errno = ENOENT;
>>> +                                     goto finish;
>>> +                             }
>>> +
>>> +                             if (match_count) {
>>> +                                     result[*match_count] = spec;
>>> +                                     *match_count += 1;
>>> +                                     // Continue to find all the matches.
>>> +                                     continue;
>>> +                             }
>>> +                             result[0] = spec;
>>>                                break;
>>> +                     }
>>>
>>>                        if (rc == REGEX_NO_MATCH)
>>>                                continue;
>>> @@ -921,19 +952,58 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>>>                }
>>>        }
>>>
>>> -     if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
>>> -             /* No matching specification. */
>>> -             errno = ENOENT;
>>> -             goto finish;
>>> -     }
>>> -
>>> -     errno = 0;
>>> -     ret = &spec_arr[i];
>>> -
>>>    finish:
>>>        free(clean_key);
>>>        free(sub);
>>> -     return ret;
>>> +     if (result && !result[0]) {
>>> +             free(result);
>>> +             result = NULL;
>>> +     }
>>> +     return result;
>>> +}
>>> +
>>> +static struct spec *lookup_common(struct selabel_handle *rec,
>>> +                                  const char *key,
>>> +                                  int type,
>>> +                                  bool partial) {
>>> +     const struct spec **matches = lookup_all(rec, key, type, partial, NULL);
>>> +     if (!matches) {
>>> +             return NULL;
>>> +     }
>>> +     struct spec *result = (struct spec*)matches[0];
>>> +     free(matches);
>>> +     return result;
>>> +}
>>> +
>>> +static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
>>> +{
>>> +     assert(digest);
>>> +
>>> +     size_t total_matches;
>>> +     const struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
>>> +     if (!matches) {
>>> +             return false;
>>> +     }
>>> +
>>> +     Sha1Context context;
>>> +     Sha1Initialise(&context);
>>> +     size_t i;
>>> +     for (i = 0; i < total_matches; i++) {
>>> +             char* regex_str = matches[i]->regex_str;
>>> +             mode_t mode = matches[i]->mode;
>>> +             char* ctx_raw = matches[i]->lr.ctx_raw;
>>> +
>>> +             Sha1Update(&context, regex_str, strlen(regex_str) + 1);
>>> +             Sha1Update(&context, &mode, sizeof(mode_t));
>>> +             Sha1Update(&context, ctx_raw, strlen(ctx_raw) + 1);
>>> +     }
>>> +
>>> +     SHA1_HASH sha1_hash;
>>> +     Sha1Finalise(&context, &sha1_hash);
>>> +     memcpy(digest, sha1_hash.bytes, SHA1_HASH_SIZE);
>>> +
>>> +     free(matches);
>>> +     return true;
>>>    }
>>>
>>>    static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>>> @@ -1133,6 +1203,7 @@ int selabel_file_init(struct selabel_handle *rec,
>>>        rec->func_stats = &stats;
>>>        rec->func_lookup = &lookup;
>>>        rec->func_partial_match = &partial_match;
>>> +     rec->func_hash_all_partial_matches = &hash_all_partial_matches;
>>>        rec->func_lookup_best_match = &lookup_best_match;
>>>        rec->func_cmp = &cmp;
>>>
>>> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
>>> index 0e020557..1fa5ade6 100644
>>> --- a/libselinux/src/label_internal.h
>>> +++ b/libselinux/src/label_internal.h
>>> @@ -87,6 +87,8 @@ struct selabel_handle {
>>>        void (*func_close) (struct selabel_handle *h);
>>>        void (*func_stats) (struct selabel_handle *h);
>>>        bool (*func_partial_match) (struct selabel_handle *h, const char *key);
>>> +     bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
>>> +                                            const char *key, uint8_t *digest);
>>>        struct selabel_lookup_rec *(*func_lookup_best_match)
>>>                                                    (struct selabel_handle *h,
>>>                                                    const char *key,
>>>
>>
> 

