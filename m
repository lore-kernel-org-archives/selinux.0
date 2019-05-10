Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01492C04AB2
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD911216C4
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WdhjlmrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfEJO0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 10:26:21 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:6681 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfEJO0U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 10:26:20 -0400
X-EEMSG-check-017: 704277460|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="704277460"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 May 2019 14:26:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557498377; x=1589034377;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HD2Qp8eSFwSDiSETJquS3fkqUIP5pEGqcRgMdKv6q40=;
  b=WdhjlmrPk0k/KaNKgt1qDox+Tpo5wLEn+dImT51JL3TycHQlOlQJyvWO
   VNkraMX2QWVn0HRSFmY3zj7XJsHjnYwGlDfKXIsq5AzDlMrFs3jkNhoKE
   FjgHAymzTqIJmDcRsJzLTxVGgwI18gPiGYO04flJh67xqvOaVmn+1Gfdr
   VMICX69cXVU5n01YOvGvIM04Rb6hbHOF0cYHYRy/wQKRlB0HDuzoOFQ4g
   sU4gbBOgUeG/NsHXb/zJ/XNawMWAZNa3DF3qpYEgb9wQ6Ebw1Vz66JrjW
   gggJ7J9V19FfPw9gxXEf+/ByGb1VqS1V/ZPwBL+pgbuOBXHx5N3B8TyJm
   A==;
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="23424999"
IronPort-PHdr: =?us-ascii?q?9a23=3AvroldRDkzcUytMI11BZjUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37p8qwAkXT6L1XgUPTWs2DsrQY0rOQ4/CrBjJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+1oAjSucUbg4pvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4XkqVYDqR6yCA+xD+3t1zBInGf707Ak3e?=
 =?us-ascii?q?QvEQ/I3wIuENwBv3vWsNr7O7wfUfy3waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMTM1UkgCRvFjlWOpozjIjiby+ENvHKf7+pkS+2ui3MspgZqojey3cchkZ?=
 =?us-ascii?q?XJh4IJxVDE8iV12oA1JcaiR0Jhbt6kF4VQujicOoBrTM0iRGRotzw7yr0AoZ?=
 =?us-ascii?q?O7cykKyIgnxx7CcPOLaZSH4hXmVOuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80Kxe7w+fjCNV5zI8RRXiDAr?=
 =?us-ascii?q?WeMKzJr1CI/P4vI/KXaY8avTbyMfkl5/r0gXAlnl8deLGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL0gtcFC2gKoxY+TPbxh1KYSjNTfWi9UL885j4hFIKqF5vMRoeogLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXrobJuLW/MNaCKUP89gnScJVaauS4A/zxGirgz6xKR9Lu?=
 =?us-ascii?q?rS5CIYsYjv1N9v5+3cxlkO8mlLDsCZ0miIB1tzlG4SWyR+iKp+pUg7wRGZ1q?=
 =?us-ascii?q?J1meBDPdNW7vJNFAw9MMiYh9R3F8q6fgvcYs2DQV2mCoG+BTgsUsg7yvcUbk?=
 =?us-ascii?q?p9EsnkhRfGiXmEGbgQwoeXCYQ0/6SU5H34I8Jw2j6Sz6U6p0U3SctIc2u9j+?=
 =?us-ascii?q?hw8BaFVN2BqFmQi6v/LfdU5yXK7mrWiDPV7Uw=3D?=
X-IPAS-Result: =?us-ascii?q?A2AVAABRidVc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?wMBAQEBCwGBZippUjIohBGTXQEBAQEBAQaBCC2JTYluhRiBewkBAQEBAQEBA?=
 =?us-ascii?q?QEtBwECAQGDekYCggsjNgcOAQMBAQEEAQEBAQMBAWwcDII6KQGCZwEFIwQRQ?=
 =?us-ascii?q?RALDgoCAhIBEwICVwYBDAYCAQGCXz8BgXYUD60jfDOEMgEUQECDIYFABoELJ?=
 =?us-ascii?q?wGLThd4gQeBESeCaz6CYQICgicCgkCCWASLHocrUpQ1CYILggeEGIQ4g06EL?=
 =?us-ascii?q?gYblWktjASGVJAtAi+BVysIAhgIIQ87gmyCGxeDTIpvIwMwgQYBAY0IDReCL?=
 =?us-ascii?q?AEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 May 2019 14:26:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4AEQGMK001172;
        Fri, 10 May 2019 10:26:16 -0400
Subject: Re: [PATCH] libselinux: Eliminate use of security_compute_user()
To:     William Roberts <bill.c.roberts@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20190509084204.26198-1-plautrba@redhat.com>
 <CAFftDdpQvKewRi6LZT0BfzqXeZ5at0Azk-ECi7asf6-XF2Aukw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a3e58f4e-d491-87c2-025e-c0e667cf4e9a@tycho.nsa.gov>
Date:   Fri, 10 May 2019 10:20:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFftDdpQvKewRi6LZT0BfzqXeZ5at0Azk-ECi7asf6-XF2Aukw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/9/19 9:44 PM, William Roberts wrote:
> On Thu, May 9, 2019 at 1:43 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
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
> 
> Whats the best way to test this?

libselinux has some test utilities to exercise these interfaces 
directly, e.g. getconlist, getdefaultcon, getseuser.  Fedora re-packages 
some of them under a more unique name, e.g. selinuxconlist, 
selinuxdefcon, as part of the libselinux-utils package.

For operational testing, you'd test that user logins, cron jobs, etc are 
correctly assigned contexts.  Preferably for users assigned different 
roles and ranges in seusers and/or kernel policy.  So adding some Linux 
users mapped to different SELinux users and ranges via semanage login -a 
and then logging in as them, creating cron jobs that report the context 
in which they are run, etc.

> 
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   libselinux/src/get_context_list.c | 185 ++++++++++--------------------
>>   1 file changed, 60 insertions(+), 125 deletions(-)
>>
>> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
>> index 689e4658..a36c6253 100644
>> --- a/libselinux/src/get_context_list.c
>> +++ b/libselinux/src/get_context_list.c
>> @@ -114,61 +114,24 @@ int get_default_context(const char *user,
>>          return 0;
>>   }
>>
>> -static int find_partialcon(char ** list,
>> -                          unsigned int nreach, char *part)
>> -{
>> -       const char *conrole, *contype;
>> -       char *partrole, *parttype, *ptr;
>> -       context_t con;
>> -       unsigned int i;
>> -
>> -       partrole = part;
>> -       ptr = part;
>> -       while (*ptr && !isspace(*ptr) && *ptr != ':')
>> -               ptr++;
>> -       if (*ptr != ':')
>> -               return -1;
>> -       *ptr++ = 0;
>> -       parttype = ptr;
>> -       while (*ptr && !isspace(*ptr) && *ptr != ':')
>> -               ptr++;
>> -       *ptr = 0;
>> -
>> -       for (i = 0; i < nreach; i++) {
>> -               con = context_new(list[i]);
>> -               if (!con)
>> -                       return -1;
>> -               conrole = context_role_get(con);
>> -               contype = context_type_get(con);
>> -               if (!conrole || !contype) {
>> -                       context_free(con);
>> -                       return -1;
>> -               }
>> -               if (!strcmp(conrole, partrole) && !strcmp(contype, parttype)) {
>> -                       context_free(con);
>> -                       return i;
>> -               }
>> -               context_free(con);
>> -       }
>> -
>> -       return -1;
>> -}
>> -
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
>>          size_t line_len = 0;
>> -       ssize_t len;
>> +       ssize_t len, ulen;
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
>> @@ -180,7 +143,8 @@ static int get_context_order(FILE * fp,
>>                  return -1;
>>          fromrole = context_role_get(con);
>>          fromtype = context_type_get(con);
>> -       if (!fromrole || !fromtype) {
>> +       fromlevel = context_range_get(con);
>> +       if (!fromrole || !fromtype || !fromlevel) {
>>                  context_free(con);
>>                  return -1;
>>          }
>> @@ -243,23 +207,52 @@ static int get_context_order(FILE * fp,
>>                  if (*end)
>>                          *end++ = 0;
>>
>> -               /* Check for a match in the reachable list. */
>> -               rc = find_partialcon(reachable, nreach, start);
>> -               if (rc < 0) {
>> -                       /* No match, skip it. */
>> -                       start = end;
>> -                       continue;
>> +               /* Check whether a new context is valid */
>> +               ulen = strlen(user) + strlen(start) + 1;
> 
> is their anything guaranteeing this doesn't overflow and result in
> malloc(0) which is undefined?
> also ulen is signed, why? All uses are where a size_t is valid, I
> think it can change to a size_t.
> 
>> +               usercon_str = malloc(ulen);
> 
> spaces after tab, see:
> https://github.com/SELinuxProject/selinux/pull/146/files#diff-55a16252233f48b841c06ffbe22bb66dR211
> 
>> +               if (!usercon_str) {
>> +                       rc = -1;
>> +                       goto out;
>>                  }
>>
>> -               /* If a match is found and the entry is not already ordered
>> -                  (e.g. due to prior match in prior config file), then set
>> -                  the ordering for it. */
>> -               i = rc;
>> -               if (ordering[i] == nreach)
>> -                       ordering[i] = (*nordered)++;
>> +               /* set range from fromcon in the new usercon */
>> +               snprintf(usercon_str, ulen - 1, "%s:%s", user, start);
>> +               if (!(usercon = context_new(usercon_str))) {
> 
> You can drop the too free(usercon_str) if you rework this logic:
> usercon = context_new(usercon_str))
> free(usercon_str);
> if (!usercon) {
>      // error
>      continue;
> }
> 
>> +                       fprintf(stderr,
>> +                               "%s: can't create a context from %s\n",
>> +                               __FUNCTION__, usercon_str);
>> +                       free(usercon_str);
>> +
>> +                       continue;
> 
> Why is it OK to continue?
> 
>> +               }
>> +               free(usercon_str);
>> +               context_range_set(usercon, fromlevel);
>> +               usercon_str = context_str(usercon);
>> +
>> +               if (security_check_context(usercon_str) == 0) {
>> +                       if (*nreachable == 0) {
>> +                               new_reachable = malloc(2 * sizeof(char *));
>> +                               if (!new_reachable) {
>> +                                       context_free(usercon);
>> +                                       rc = -1;
>> +                                       goto out;
>> +                               }
>> +                       } else {
>> +                               new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
>> +                               if (!new_reachable) {
>> +                                       context_free(usercon);
>> +                                       rc = -1;
>> +                                       goto out;
>> +                               }
>> +                       }
>> +                       new_reachable[*nreachable] = strdup(usercon_str);
> 
> oom error
> 
>> +                       new_reachable[*nreachable + 1] = 0;
>> +                       *reachable = new_reachable;
>> +                       *nreachable += 1;
>> +               }
>> +               context_free(usercon);
>>                  start = end;
>>          }
>> -
>>          rc = 0;
>>
>>         out:
>> @@ -313,21 +306,6 @@ static int get_failsafe_context(const char *user, char ** newcon)
>>          return 0;
>>   }
>>
>> -struct context_order {
>> -       char * con;
>> -       unsigned int order;
>> -};
>> -
>> -static int order_compare(const void *A, const void *B)
>> -{
>> -       const struct context_order *c1 = A, *c2 = B;
>> -       if (c1->order < c2->order)
>> -               return -1;
>> -       else if (c1->order > c2->order)
>> -               return 1;
>> -       return strcmp(c1->con, c2->con);
>> -}
>> -
>>   int get_ordered_context_list_with_level(const char *user,
>>                                          const char *level,
>>                                          char * fromcon,
>> @@ -395,11 +373,8 @@ int get_ordered_context_list(const char *user,
>>                               char *** list)
>>   {
>>          char **reachable = NULL;
>> -       unsigned int *ordering = NULL;
>> -       struct context_order *co = NULL;
>> -       char **ptr;
>>          int rc = 0;
>> -       unsigned int nreach = 0, nordered = 0, freefrom = 0, i;
>> +       unsigned nreachable = 0, freefrom = 0;
>>          FILE *fp;
>>          char *fname = NULL;
>>          size_t fname_len;
>> @@ -413,23 +388,6 @@ int get_ordered_context_list(const char *user,
>>                  freefrom = 1;
>>          }
>>
>> -       /* Determine the set of reachable contexts for the user. */
>> -       rc = security_compute_user(fromcon, user, &reachable);
>> -       if (rc < 0)
>> -               goto failsafe;
>> -       nreach = 0;
>> -       for (ptr = reachable; *ptr; ptr++)
>> -               nreach++;
>> -       if (!nreach)
>> -               goto failsafe;
>> -
>> -       /* Initialize ordering array. */
>> -       ordering = malloc(nreach * sizeof(unsigned int));
>> -       if (!ordering)
>> -               goto failsafe;
>> -       for (i = 0; i < nreach; i++)
>> -               ordering[i] = nreach;
>> -
>>          /* Determine the ordering to apply from the optional per-user config
>>             and from the global config. */
>>          fname_len = strlen(user_contexts_path) + strlen(user) + 2;
>> @@ -440,8 +398,8 @@ int get_ordered_context_list(const char *user,
>>          fp = fopen(fname, "re");
>>          if (fp) {
>>                  __fsetlocking(fp, FSETLOCKING_BYCALLER);
>> -               rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
>> -                                      &nordered);
>> +               rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
>> +
>>                  fclose(fp);
>>                  if (rc < 0 && errno != ENOENT) {
>>                          fprintf(stderr,
>> @@ -454,8 +412,7 @@ int get_ordered_context_list(const char *user,
>>          fp = fopen(selinux_default_context_path(), "re");
>>          if (fp) {
>>                  __fsetlocking(fp, FSETLOCKING_BYCALLER);
>> -               rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
>> -                                      &nordered);
>> +               rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
>>                  fclose(fp);
>>                  if (rc < 0 && errno != ENOENT) {
>>                          fprintf(stderr,
>> @@ -463,40 +420,18 @@ int get_ordered_context_list(const char *user,
>>                                  __FUNCTION__, selinux_default_context_path());
>>                          /* Fall through */
>>                  }
>> -               rc = 0;
>> +               rc = nreachable;
>>          }
>>
>> -       if (!nordered)
>> +       if (!nreachable)
>>                  goto failsafe;
>>
>> -       /* Apply the ordering. */
>> -       co = malloc(nreach * sizeof(struct context_order));
>> -       if (!co)
>> -               goto failsafe;
>> -       for (i = 0; i < nreach; i++) {
>> -               co[i].con = reachable[i];
>> -               co[i].order = ordering[i];
>> -       }
>> -       qsort(co, nreach, sizeof(struct context_order), order_compare);
>> -       for (i = 0; i < nreach; i++)
>> -               reachable[i] = co[i].con;
>> -       free(co);
>> -
>> -       /* Only report the ordered entries to the caller. */
>> -       if (nordered <= nreach) {
>> -               for (i = nordered; i < nreach; i++)
>> -                       free(reachable[i]);
>> -               reachable[nordered] = NULL;
>> -               rc = nordered;
>> -       }
>> -
>>         out:
>>          if (rc > 0)
>>                  *list = reachable;
>>          else
>>                  freeconary(reachable);
>>
>> -       free(ordering);
>>          if (freefrom)
>>                  freecon(fromcon);
>>
>> --
>> 2.21.0
>>

