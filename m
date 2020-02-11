Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F206EC352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 15:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65482086A
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 15:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CISzppnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgBKPGi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:06:38 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:42720 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgBKPGh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 10:06:37 -0500
X-EEMSG-check-017: 54814829|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="54814829"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 15:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581433595; x=1612969595;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5KB1NW1ulyGW9iAsEzDOoJ45zJnoxp7b0I85KNFZeyI=;
  b=CISzppnuuI9LjJ/AfDhBpIJFLxRMetR4dfXAhQwZv37/qeiAdHKcFvAW
   1ThF+DAaKQZViFLJmGCTQog61Xvljfz925q2EY8pkKS5SmB5LXjqabPUL
   RG0/KcAW5JEXhIcVLUnJN2ORsy7IEffbrqKUtwIM+iDSPq5WQ7Vp3ecxc
   YXL5ICMsutW33zwM/Z7Nof0KCnY3SEygxJr3oVONVk12aYsPSjDmwNig0
   tX+B+x/PPVYK8w8UUBykPX2mq3cNB1KWRWUnwnNP3rRfApbTtqu83xp4A
   zxXnSK9UNnsNlYyTXA5Q/1vXl2mAQFaf/3yd5nnQmL/ZaSx0k+ypG6956
   w==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="32919761"
IronPort-PHdr: =?us-ascii?q?9a23=3AP2BPOhGeXbbFOqqzNex0yJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yp8uwAkXT6L1XgUPTWs2DsrQY0raQ7furBjRIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Qu8QYjodvKLo9wQ?=
 =?us-ascii?q?bVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQLJbETorLX?=
 =?us-ascii?q?k76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRD?=
 =?us-ascii?q?Si86JmQwLmhSsbKzI09nzch9duh6xHvh2uux1/w5bVYI6LMvp+Yrjdds4eSW?=
 =?us-ascii?q?ZYQ8pdSzBNDoa6YoQBFeoBOftToZf7qVUAsBCyARCgCe3rxzNNgHL9wK803P?=
 =?us-ascii?q?k7EQzewQIuH8wAsHrXotv7OqgdXuK6w7XHwzjYc/Nb2i3w5JTUfh0vo/yBW6?=
 =?us-ascii?q?97f8rLyUkoEgPIlleQqIL5MDyPzOQNr3aX5PdnWOKthW8otxt+oiKzxssykY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHLlxEdw6dgIjzJ1HCPuv1Deu/gluwkDdrwOrKPrv6AprXNHTDn7Dhfa?=
 =?us-ascii?q?hl505G1AUz1cxf545TCrwZJ/LzX0jxtMfeDhAjLwO73f3qCM9j2YwDWWKAGL?=
 =?us-ascii?q?OZPLnOvl+P4+IlO/OMa5MNuDbhN/gl4ObjjWQnll8ZfKmp24YXaX+jE/R4LE?=
 =?us-ascii?q?WWf2Dsjs0CEWgUpAo+SvLliFmYXT5UfXayUPF02jZuL4SqF4rBDqWqm7qI1y?=
 =?us-ascii?q?q4VslRY2ddDFmHHF/yeomEUutKYyWXdIspiTEAVL68W6c/2hy08gz30bxqKq?=
 =?us-ascii?q?zT4CJLm4jk0Y13+Obajw1ovWh2EM+UyX3XZ31llWMPATkt1eZwplIrmQTL6r?=
 =?us-ascii?q?Rxn/ENTY8b3PhOSApvcMeHnuE=3D?=
X-IPAS-Result: =?us-ascii?q?A2CCCgC+vEJe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBWJA4gCJZlUgWcJAQEBAQEBAQEBNwEBghOCLQKCazgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYMCAQUjBAsBBQ9CCQIJBQoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/gnyPNJt5fzODNYVHgT6BDiqBXIZThU5AgREnDAOCXT6ELQSDKoJeBIE/A?=
 =?us-ascii?q?YwYCoh9gSl8hzaPOAaCPpZGBhubD4sCg2KdNiKBWCsKQYFogU5QGA2OKAEXF?=
 =?us-ascii?q?Y4sIwMwjmgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Feb 2020 15:06:33 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BF5dwa181460;
        Tue, 11 Feb 2020 10:05:39 -0500
Subject: Re: [Non-DoD Source] [PATCH userspace] libsepol/cil: remove
 unnecessary hash tables
From:   jwcart2 <jwcart2@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200207145816.43814-1-omosnace@redhat.com>
 <bc64aa15-fc26-2f09-bd2b-871f3a9055ea@tycho.nsa.gov>
Message-ID: <7a9fc835-0840-6c94-e4e8-1e75b9b869d0@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 10:07:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bc64aa15-fc26-2f09-bd2b-871f3a9055ea@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/20 2:39 PM, jwcart2 wrote:
> On 2/7/20 9:58 AM, Ondrej Mosnacek wrote:
>> The filename_- and range_trans_table ancillary hash tables in
>> cil_binary.c just duplicate the final policydb content and can be simply
>> removed.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
> 

This has been merged.

Thanks,
Jim

>> ---
>>
>> Maybe I'm missing something, but it seems to me that these two hash
>> tables serve no purpose and can be removed.
>>
>>   libsepol/cil/src/cil_binary.c | 123 +++++-----------------------------
>>   libsepol/cil/src/cil_binary.h |   6 +-
>>   2 files changed, 20 insertions(+), 109 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index 376491f7..03d53e1f 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -59,8 +59,6 @@
>>   /* There are 44000 filename_trans in current fedora policy. 1.33 times this 
>> is the recommended
>>    * size of a hashtable. The next power of 2 of this is 2 ** 16.
>>    */
>> -#define FILENAME_TRANS_TABLE_SIZE (1 << 16)
>> -#define RANGE_TRANS_TABLE_SIZE (1 << 13)
>>   #define ROLE_TRANS_TABLE_SIZE (1 << 10)
>>   #define AVRULEX_TABLE_SIZE (1 <<  10)
>>   #define PERMS_PER_CLASS 32
>> @@ -70,8 +68,6 @@ struct cil_args_binary {
>>       policydb_t *pdb;
>>       struct cil_list *neverallows;
>>       int pass;
>> -    hashtab_t filename_trans_table;
>> -    hashtab_t range_trans_table;
>>       hashtab_t role_trans_table;
>>       hashtab_t avrulex_ioctl_table;
>>       void **type_value_to_cil;
>> @@ -82,7 +78,6 @@ struct cil_args_booleanif {
>>       policydb_t *pdb;
>>       cond_node_t *cond_node;
>>       enum cil_flavor cond_flavor;
>> -    hashtab_t filename_trans_table;
>>   };
>>   static int __cil_get_sepol_user_datum(policydb_t *pdb, struct 
>> cil_symtab_datum *datum, user_datum_t **sepol_user)
>> @@ -1129,7 +1124,7 @@ int cil_type_rule_to_policydb(policydb_t *pdb, const 
>> struct cil_db *db, struct c
>>       return  __cil_type_rule_to_avtab(pdb, db, cil_rule, NULL, CIL_FALSE);
>>   }
>> -int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum 
>> cil_flavor cond_flavor, hashtab_t filename_trans_table)
>> +int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum 
>> cil_flavor cond_flavor)
>>   {
>>       int rc = SEPOL_ERR;
>>       type_datum_t *sepol_src = NULL;
>> @@ -1179,7 +1174,6 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const 
>> struct cil_db *db, stru
>>               if (rc != SEPOL_OK) goto exit;
>>               cil_list_for_each(c, class_list) {
>> -                int add = CIL_TRUE;
>>                   rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), 
>> &sepol_obj);
>>                   if (rc != SEPOL_OK) goto exit;
>> @@ -1191,11 +1185,13 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, 
>> const struct cil_db *db, stru
>>                   newkey->name = cil_strdup(name);
>>                   newdatum->otype = sepol_result->s.value;
>> -                rc = hashtab_insert(filename_trans_table, 
>> (hashtab_key_t)newkey, newdatum);
>> +                rc = hashtab_insert(pdb->filename_trans,
>> +                            (hashtab_key_t)newkey,
>> +                            newdatum);
>>                   if (rc != SEPOL_OK) {
>>                       if (rc == SEPOL_EEXIST) {
>> -                        add = CIL_FALSE;
>> -                        otype = hashtab_search(filename_trans_table, 
>> (hashtab_key_t)newkey);
>> +                        otype = hashtab_search(pdb->filename_trans,
>> +                                (hashtab_key_t)newkey);
>>                           if (newdatum->otype != otype->otype) {
>>                               cil_log(CIL_ERR, "Conflicting name type 
>> transition rules\n");
>>                           } else {
>> @@ -1204,17 +1200,6 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, 
>> const struct cil_db *db, stru
>>                       } else {
>>                           cil_log(CIL_ERR, "Out of memory\n");
>>                       }
>> -                }
>> -
>> -                if (add == CIL_TRUE) {
>> -                    rc = hashtab_insert(pdb->filename_trans,
>> -                                (hashtab_key_t)newkey,
>> -                                newdatum);
>> -                    if (rc != SEPOL_OK) {
>> -                        cil_log(CIL_ERR, "Out of memory\n");
>> -                        goto exit;
>> -                    }
>> -                } else {
>>                       free(newkey->name);
>>                       free(newkey);
>>                       free(newdatum);
>> @@ -1235,9 +1220,9 @@ exit:
>>       return rc;
>>   }
>> -int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_nametypetransition *typetrans, hashtab_t filename_trans_table)
>> +int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_nametypetransition *typetrans)
>>   {
>> -    return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, 
>> CIL_FALSE, filename_trans_table);
>> +    return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, CIL_FALSE);
>>   }
>>   int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t 
>> *datum)
>> @@ -1925,7 +1910,6 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node 
>> *node, __attribute__((unu
>>       struct cil_type_rule *cil_type_rule;
>>       struct cil_avrule *cil_avrule;
>>       struct cil_nametypetransition *cil_typetrans;
>> -    hashtab_t filename_trans_table = args->filename_trans_table;
>>       flavor = node->flavor;
>>       switch (flavor) {
>> @@ -1936,7 +1920,7 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node 
>> *node, __attribute__((unu
>>               cil_tree_log(node, CIL_ERR,"Invalid typetransition statement");
>>               goto exit;
>>           }
>> -        rc = __cil_typetransition_to_avtab(pdb, db, cil_typetrans, cond_node, 
>> cond_flavor, filename_trans_table);
>> +        rc = __cil_typetransition_to_avtab(pdb, db, cil_typetrans, cond_node, 
>> cond_flavor);
>>           if (rc != SEPOL_OK) {
>>               cil_tree_log(node, CIL_ERR, "Failed to insert type transition 
>> into avtab");
>>               goto exit;
>> @@ -2205,7 +2189,7 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t 
>> *pdb, struct cil_list *cil_e
>>       return SEPOL_OK;
>>   }
>> -int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_tree_node *node, hashtab_t filename_trans_table)
>> +int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_tree_node *node)
>>   {
>>       int rc = SEPOL_ERR;
>>       struct cil_args_booleanif bool_args;
>> @@ -2280,7 +2264,6 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const 
>> struct cil_db *db, struct c
>>       bool_args.db = db;
>>       bool_args.pdb = pdb;
>>       bool_args.cond_node = cond_node;
>> -    bool_args.filename_trans_table = filename_trans_table;
>>       if (true_node != NULL) {
>>           bool_args.cond_flavor = CIL_CONDTRUE;
>> @@ -3089,7 +3072,7 @@ exit:
>>       return rc;
>>   }
>> -int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_rangetransition *rangetrans, hashtab_t range_trans_table)
>> +int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_rangetransition *rangetrans)
>>   {
>>       int rc = SEPOL_ERR;
>>       type_datum_t *sepol_src = NULL;
>> @@ -3121,7 +3104,6 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, 
>> const struct cil_db *db, st
>>               if (rc != SEPOL_OK) goto exit;
>>               cil_list_for_each(c, class_list) {
>> -                int add = CIL_TRUE;
>>                   rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), 
>> &sepol_class);
>>                   if (rc != SEPOL_OK) goto exit;
>> @@ -3137,11 +3119,10 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, 
>> const struct cil_db *db, st
>>                       goto exit;
>>                   }
>> -                rc = hashtab_insert(range_trans_table, (hashtab_key_t)newkey, 
>> newdatum);
>> +                rc = hashtab_insert(pdb->range_tr, (hashtab_key_t)newkey, 
>> newdatum);
>>                   if (rc != SEPOL_OK) {
>>                       if (rc == SEPOL_EEXIST) {
>> -                        add = CIL_FALSE;
>> -                        o_range = hashtab_search(range_trans_table, 
>> (hashtab_key_t)newkey);
>> +                        o_range = hashtab_search(pdb->range_tr, 
>> (hashtab_key_t)newkey);
>>                           if (!mls_range_eq(newdatum, o_range)) {
>>                               cil_log(CIL_ERR, "Conflicting Range transition 
>> rules\n");
>>                           } else {
>> @@ -3150,27 +3131,13 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, 
>> const struct cil_db *db, st
>>                       } else {
>>                           cil_log(CIL_ERR, "Out of memory\n");
>>                       }
>> -                }
>> -
>> -                if (add == CIL_TRUE) {
>> -                    rc = hashtab_insert(pdb->range_tr,
>> -                                (hashtab_key_t)newkey,
>> -                                newdatum);
>> -                    if (rc != SEPOL_OK) {
>> -                        mls_range_destroy(newdatum);
>> -                        free(newdatum);
>> -                        free(newkey);
>> -                        cil_log(CIL_ERR, "Out of memory\n");
>> -                        goto exit;
>> -                    }
>> -                } else {
>>                       mls_range_destroy(newdatum);
>>                       free(newdatum);
>>                       free(newkey);
>>                       if (rc != SEPOL_OK) {
>>                           goto exit;
>>                       }
>> -                }
>> +                }
>>               }
>>           }
>>       }
>> @@ -3639,16 +3606,12 @@ int __cil_node_to_policydb(struct cil_tree_node *node, 
>> void *extra_args)
>>       struct cil_args_binary *args = extra_args;
>>       const struct cil_db *db;
>>       policydb_t *pdb;
>> -    hashtab_t filename_trans_table;
>> -    hashtab_t range_trans_table;
>>       hashtab_t role_trans_table;
>>       void **type_value_to_cil;
>>       db = args->db;
>>       pdb = args->pdb;
>>       pass = args->pass;
>> -    filename_trans_table = args->filename_trans_table;
>> -    range_trans_table = args->range_trans_table;
>>       role_trans_table = args->role_trans_table;
>>       type_value_to_cil = args->type_value_to_cil;
>> @@ -3747,7 +3710,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, 
>> void *extra_args)
>>             /*rc = cil_roleattributeset_to_policydb(pdb, node->data);*/
>>               break;
>>           case CIL_NAMETYPETRANSITION:
>> -            rc = cil_typetransition_to_policydb(pdb, db, node->data, 
>> filename_trans_table);
>> +            rc = cil_typetransition_to_policydb(pdb, db, node->data);
>>               break;
>>           case CIL_CONSTRAIN:
>>               rc = cil_constrain_to_policydb(pdb, db, node->data);
>> @@ -3767,7 +3730,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, 
>> void *extra_args)
>>               break;
>>           case CIL_RANGETRANSITION:
>>               if (pdb->mls == CIL_TRUE) {
>> -                rc = cil_rangetransition_to_policydb(pdb, db, node->data, 
>> range_trans_table);
>> +                rc = cil_rangetransition_to_policydb(pdb, db, node->data);
>>               }
>>               break;
>>           case CIL_DEFAULTUSER:
>> @@ -3785,7 +3748,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, 
>> void *extra_args)
>>       case 3:
>>           switch (node->flavor) {
>>           case CIL_BOOLEANIF:
>> -            rc = cil_booleanif_to_policydb(pdb, db, node, filename_trans_table);
>> +            rc = cil_booleanif_to_policydb(pdb, db, node);
>>               break;
>>           case CIL_AVRULE: {
>>                   struct cil_avrule *rule = node->data;
>> @@ -4193,40 +4156,6 @@ exit:
>>       return rc;
>>   }
>> -static unsigned int filename_trans_hash(hashtab_t h, const_hashtab_key_t key)
>> -{
>> -    const filename_trans_t *k = (const filename_trans_t *)key;
>> -    return ((k->tclass + (k->ttype << 2) +
>> -                (k->stype << 9)) & (h->size - 1));
>> -}
>> -
>> -static int filename_trans_compare(hashtab_t h
>> -             __attribute__ ((unused)), const_hashtab_key_t key1,
>> -                          const_hashtab_key_t key2)
>> -{
>> -    const filename_trans_t *a = (const filename_trans_t *)key1;
>> -    const filename_trans_t *b = (const filename_trans_t *)key2;
>> -
>> -    return a->stype != b->stype || a->ttype != b->ttype || a->tclass != 
>> b->tclass || strcmp(a->name, b->name);
>> -}
>> -
>> -static unsigned int range_trans_hash(hashtab_t h, const_hashtab_key_t key)
>> -{
>> -    const range_trans_t *k = (const range_trans_t *)key;
>> -    return ((k->target_class + (k->target_type << 2) +
>> -                (k->source_type << 5)) & (h->size - 1));
>> -}
>> -
>> -static int range_trans_compare(hashtab_t h
>> -             __attribute__ ((unused)), const_hashtab_key_t key1,
>> -                          const_hashtab_key_t key2)
>> -{
>> -    const range_trans_t *a = (const range_trans_t *)key1;
>> -    const range_trans_t *b = (const range_trans_t *)key2;
>> -
>> -    return a->source_type != b->source_type || a->target_type != 
>> b->target_type || a->target_class != b->target_class;
>> -}
>> -
>>   static unsigned int role_trans_hash(hashtab_t h, const_hashtab_key_t key)
>>   {
>>       const role_trans_t *k = (const role_trans_t *)key;
>> @@ -4872,8 +4801,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db 
>> *db, sepol_policydb_t *p
>>       struct cil_args_binary extra_args;
>>       policydb_t *pdb = &policydb->p;
>>       struct cil_list *neverallows = NULL;
>> -    hashtab_t filename_trans_table = NULL;
>> -    hashtab_t range_trans_table = NULL;
>>       hashtab_t role_trans_table = NULL;
>>       hashtab_t avrulex_ioctl_table = NULL;
>>       void **type_value_to_cil = NULL;
>> @@ -4911,18 +4838,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db 
>> *db, sepol_policydb_t *p
>>           goto exit;
>>       }
>> -    filename_trans_table = hashtab_create(filename_trans_hash, 
>> filename_trans_compare, FILENAME_TRANS_TABLE_SIZE);
>> -    if (!filename_trans_table) {
>> -        cil_log(CIL_INFO, "Failure to create hashtab for filename_trans\n");
>> -        goto exit;
>> -    }
>> -
>> -    range_trans_table = hashtab_create(range_trans_hash, range_trans_compare, 
>> RANGE_TRANS_TABLE_SIZE);
>> -    if (!range_trans_table) {
>> -        cil_log(CIL_INFO, "Failure to create hashtab for range_trans\n");
>> -        goto exit;
>> -    }
>> -
>>       role_trans_table = hashtab_create(role_trans_hash, role_trans_compare, 
>> ROLE_TRANS_TABLE_SIZE);
>>       if (!role_trans_table) {
>>           cil_log(CIL_INFO, "Failure to create hashtab for role_trans\n");
>> @@ -4940,8 +4855,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db 
>> *db, sepol_policydb_t *p
>>       extra_args.db = db;
>>       extra_args.pdb = pdb;
>>       extra_args.neverallows = neverallows;
>> -    extra_args.filename_trans_table = filename_trans_table;
>> -    extra_args.range_trans_table = range_trans_table;
>>       extra_args.role_trans_table = role_trans_table;
>>       extra_args.avrulex_ioctl_table = avrulex_ioctl_table;
>>       extra_args.type_value_to_cil = type_value_to_cil;
>> @@ -5039,8 +4952,6 @@ int cil_binary_create_allocated_pdb(const struct cil_db 
>> *db, sepol_policydb_t *p
>>       rc = SEPOL_OK;
>>   exit:
>> -    hashtab_destroy(filename_trans_table);
>> -    hashtab_destroy(range_trans_table);
>>       hashtab_destroy(role_trans_table);
>>       hashtab_destroy(avrulex_ioctl_table);
>>       free(type_value_to_cil);
>> diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
>> index 1004df45..0b6e3b79 100644
>> --- a/libsepol/cil/src/cil_binary.h
>> +++ b/libsepol/cil/src/cil_binary.h
>> @@ -263,7 +263,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct 
>> cil_db *db, struct cil_
>>    *
>>    * @return SEPOL_OK upon success or an error otherwise.
>>    */
>> -int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_tree_node *node, hashtab_t filename_trans_table);
>> +int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_tree_node *node);
>>   /**
>>    * Insert cil role transition structure into sepol policydb.
>> @@ -293,7 +293,7 @@ int cil_roleallow_to_policydb(policydb_t *pdb, const 
>> struct cil_db *db, struct c
>>    *
>>    * @return SEPOL_OK upon success or SEPOL_ERR upon error.
>>    */
>> -int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_nametypetransition *typetrans, hashtab_t filename_trans_table);
>> +int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_nametypetransition *typetrans);
>>   /**
>>    * Insert cil constrain/mlsconstrain structure(s) into sepol policydb.
>> @@ -327,7 +327,7 @@ int cil_sepol_level_define(policydb_t *pdb, struct 
>> cil_sens *cil_sens);
>>    *
>>    * @return SEPOL_OK upon success or an error otherwise.
>>    */
>> -int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_rangetransition *rangetrans, hashtab_t range_trans_table);
>> +int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, 
>> struct cil_rangetransition *rangetrans);
>>   /**
>>    * Insert cil ibpkeycon structure into sepol policydb.
>>
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
