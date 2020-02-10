Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F2C352A3
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F592080C
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Y7lnj3G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBJQHl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:07:41 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:2472 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJQHl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 11:07:41 -0500
X-EEMSG-check-017: 57480237|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="57480237"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 16:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581350858; x=1612886858;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BaSRv0i5RKnWvYUXsKQp90w/Olr1Z9+PVspLSMY+GaA=;
  b=Y7lnj3G8wTlS5AHKDuPmnHVWoP7mHWNiwMq8UOzhpowwzgUW62G60oHu
   NlAk9Oe/6JOBN6rr6J3Ae1dycBd3YbR7ASd/nVI76rzreeDNL56sAPqJr
   HqDttcM0BfeAJwLmTH0onicVMchCQO3JVCTW/DdUj46yEE/iqntMrl0y5
   XrI8KJumNgY56uJgMTNlImtehy18VYIAuDg424QBym70fnQNryCIlhlKT
   +sWcss6TzeOgd5qIuk2L2MflvCUWaDGv6IZvibgTTpqLAP4cmzbPKIwai
   BwOz7i3OL1NNfwdCM+eO5WbK7VWsROBwvHfztYXNRb02+GSfbEItZs5tK
   A==;
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="32874516"
IronPort-PHdr: =?us-ascii?q?9a23=3AQd2rpBQpNT7MSeaEXIXZHFqzr9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBCEt8tkgFKBZ4jH8fUM07OQ7/m8HzJZqsnR+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTo3ZEZutayGFrKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXxreLW6hxmo8EigzPXxVsa10F?=
 =?us-ascii?q?ZWripFj8LDumoR2BzU78iKTOZ28ES52TuXygze5e5JLVo0mKbGMZIt3LE9mo?=
 =?us-ascii?q?QJvUjeGCL9hV/4g7WMdko+/+il8+HnYrL7qZCCL4J0kQT+Mrg2msy4HOQ4Lh?=
 =?us-ascii?q?ACX2iF9uS4073u5VH5T69Qjv03j6nZq4rWJcUdpq63BA9VyZgs5AqlAze60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBk4fpIE3BLOr9Dfe+h1SgiDZrx/bYMb39GpjBM3fOnbj7cb?=
 =?us-ascii?q?t99kJQ0hQ/wN9B655OF70NOPfzVVXwtNzcAB85KQu0w+P/BdVmy4weQnmCAr?=
 =?us-ascii?q?OZMazOsV+I4fgjI++XZIAPojr9JP8l5+D2gX8jhVAdZbWp3YcQaH2gGfRmJk?=
 =?us-ascii?q?KZYWHqgtgbDWgFoBEzTPb0h1KfUT5cfWqyU7gg6TE8DYKsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZnhCCl+WDHfoa5+EVOwWZy+JOM9ujCELVbi7RI89zx2hqAj6y79/JO?=
 =?us-ascii?q?rO5iIYrY7j1MRy5+DLjhE96zh0D8Wb02GQQGB5hX0IRzAo06Blu0B9yUmM0b?=
 =?us-ascii?q?J+g/NGEdxf/fRJUh01Nc2U8+svLNb+QA/DNvKOU1CvSdilSWU2S9UqxdYFbm?=
 =?us-ascii?q?5nFtmihwyF1C2vVftdr7GXHtQQ+7/AxXL4LMY1n27C3bQ9lVMvatFCOW2vmu?=
 =?us-ascii?q?h08A2FVKDTlEDMrLqnbaQR2mb28W6HyWef9BVDXBVYTbTOXXdZYFDf69v++B?=
 =?us-ascii?q?WRHPeVFb07P14Zmoa5IaxQZ4is1A4XSQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D8AgBMf0Fe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGZgEBAQaBEiWJcIonhT2BZwkBAQEBAQEBAQErDAEBg3tFA?=
 =?us-ascii?q?oJqOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMCAQUjFUEQCw4KAgIRFQICV?=
 =?us-ascii?q?wYBDAYCAQGCYz8BglYlD6c8gTKFSoMmgTgGgQ4qjD15gQeBEScMA4JdPoJkA?=
 =?us-ascii?q?oEegQaCUYJeBI1iiWBGl2qCRIJOhH6OegYblkiERy2ON4hslEoigVgrCAIYC?=
 =?us-ascii?q?CEPO4JsUBgNjiYDF4NQinEjAzCOaAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Feb 2020 16:07:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01AG6fCe040760;
        Mon, 10 Feb 2020 11:06:41 -0500
Subject: Re: [PATCH v3] libselinux: Eliminate use of security_compute_user()
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200208073607.21229-1-plautrba@redhat.com>
 <CAFqZXNufhUP7XJ1p0Te_AjVKZJpcyRi0QFyN4YdePkFZ6k3-iQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1bb8f5cb-7fbd-d525-3137-f94b6c2a11fa@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 11:09:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNufhUP7XJ1p0Te_AjVKZJpcyRi0QFyN4YdePkFZ6k3-iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 10:00 AM, Ondrej Mosnacek wrote:
> I haven't looked at the whole patch properly yet, but noting what I
> found so far (see below)...
> 
> On Sat, Feb 8, 2020 at 8:36 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>> get_ordered_context_list() code used to ask the kernel to compute the complete
>> set of reachable contexts using /sys/fs/selinux/user aka
>> security_compute_user(). This set can be so huge so that it doesn't fit into a
>> kernel page and security_compute_user() fails. Even if it doesn't fail,
>> get_ordered_context_list() throws away the vast majority of the returned
>> contexts because they don't match anything in
>> /etc/selinux/targeted/contexts/default_contexts or
>> /etc/selinux/targeted/contexts/users/
>>
>> get_ordered_context_list() is rewritten to compute set of contexts based on
>> /etc/selinux/targeted/contexts/users/ and
>> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
>> contexts, using security_check_context(), from this set.
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>
>> v3 changes:
>>
>> - check return values of context_range_set() and context_str()
>> - do not add duplicate entries to reachable contexts
>>
>>
>> libselinux/src/get_context_list.c | 219 ++++++++++++++----------------
>>   1 file changed, 103 insertions(+), 116 deletions(-)
>>
>> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
>> index 689e46589f30..cc39f8c6a96c 100644
>> --- a/libselinux/src/get_context_list.c
>> +++ b/libselinux/src/get_context_list.c
> 
> <snip>
> 
>> -static int get_context_order(FILE * fp,
>> +static int get_context_user(FILE * fp,
>>                               char * fromcon,
>> -                            char ** reachable,
>> -                            unsigned int nreach,
>> -                            unsigned int *ordering, unsigned int *nordered)
>> +                            const char * user,
>> +                            char ***reachable,
>> +                            unsigned int *nreachable)
>>   {
>>          char *start, *end = NULL;
>>          char *line = NULL;
>> -       size_t line_len = 0;
>> +       size_t line_len = 0, usercon_len;
>> +       size_t user_len = strlen(user);
>>          ssize_t len;
>>          int found = 0;
>> -       const char *fromrole, *fromtype;
>> +       const char *fromrole, *fromtype, *fromlevel;
>>          char *linerole, *linetype;
>> -       unsigned int i;
>> +       char **new_reachable = NULL;
>> +       char *usercon_str;
>>          context_t con;
>> +       context_t usercon;
>> +
>>          int rc;
>>
>>          errno = -EINVAL;
>> @@ -180,6 +158,7 @@ static int get_context_order(FILE * fp,
>>                  return -1;
>>          fromrole = context_role_get(con);
>>          fromtype = context_type_get(con);
>> +       fromlevel = context_range_get(con);
>>          if (!fromrole || !fromtype) {
>>                  context_free(con);
>>                  return -1;
>> @@ -243,23 +222,89 @@ static int get_context_order(FILE * fp,
>>                  if (*end)
>>                          *end++ = 0;
>>
>> -               /* Check for a match in the reachable list. */
>> -               rc = find_partialcon(reachable, nreach, start);
>> -               if (rc < 0) {
>> -                       /* No match, skip it. */
>> +               /* Check whether a new context is valid */
>> +               if (SIZE_MAX - user_len < strlen(start) + 1) {
> 
> You need to also account for either the null character or the colon
> (not sure which one you missed).
> 
>> +                       fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
>> +                       errno = EINVAL;
>> +                       rc = -1;
>> +                       goto out;
>> +               }
>> +               usercon_len = user_len + strlen(start) + 1;
>> +               usercon_str = malloc(usercon_len);
> 
> Again, you are not accounting for one of '\0' or ':' here.
> 
>> +               if (!usercon_str) {
>> +                       rc = -1;
>> +                       goto out;
>> +               }
>> +
>> +               /* set range from fromcon in the new usercon */
>> +               snprintf(usercon_str, usercon_len - 1, "%s:%s", user, start);
> 
> The second argument should be just usercon_len (assuming you fix the
> above) - see snprintf(3):
> 
> "The functions snprintf() and vsnprintf() write at most size bytes
> (including the terminating null byte ('\0')) to str."
> 
> So this should always result in a string with 2 last characters
> truncated (followed by a null character and an unused byte). Or am I
> missing something? Did you get correct strings when you tested this?

It is truncating the "s0" level from start but then we are explicitly 
overriding the level via context_range_set(), so the bug gets masked.
