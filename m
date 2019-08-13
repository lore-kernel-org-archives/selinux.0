Return-Path: <SRS0=Q1y4=WJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F3C433FF
	for <selinux@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D57E205F4
	for <selinux@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qeeFQBFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfHMPCG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:02:06 -0400
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:32986 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbfHMPCG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Aug 2019 11:02:06 -0400
X-EEMSG-check-017: 269535|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,381,1559520000"; 
   d="scan'208";a="269535"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Aug 2019 15:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565708469; x=1597244469;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4Kq+OhLj2oJ++cAUj2DrTWydVR0qLAHhSrD3a3qV8T4=;
  b=qeeFQBFk98ky5bSq35RbxLmLDTBkqkJ8UtvAyuqaYmL6U3FxcY3hts/9
   d1FobgFId3cHRK52EefYtOWsuj9C55Vc2v5Go8PNm8CbNMrU1DdXpL4sY
   A8sdG792lkQhymGAoM8SQL2uUSYTF+Cyd8qjInX82IeQop1XsSJAvotj6
   RXjgq1Mf5/BJpOcVH1jIb8jD1Q0lDsxpyPRS3XDQyAUBzY4KxQGPnOisQ
   DBfPG4A6uD/yluRaL0AtPgIxLzo/U8kshmTEvEbzr025qH0SZsdIHDjuU
   Cbj7HDokxo1JyYL08XpEpNxjqho1WcPYVhSQtkrdlgbD8uEING89h7H/L
   A==;
X-IronPort-AV: E=Sophos;i="5.64,381,1559520000"; 
   d="scan'208";a="26735244"
IronPort-PHdr: =?us-ascii?q?9a23=3ApiUc6xDJknoz9BGhMrL/UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/ocywAkXT6L1XgUPTWs2DsrQY0rCQ6vq+EjNcqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5sIBmssAndqMgbjYRgJ6s+1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VUiGBnfjlWXr4zuIjKb1uMMs2eG8eVgUf+khmk9pA5trTivwcYshZ?=
 =?us-ascii?q?TXiY8O1lDF9Tl2wIYyJdGiTk57esSrHIFftyGdKYt7W8UvSHxrtiYi0rAKpJ?=
 =?us-ascii?q?G2cScQxJkn2hLTceKLfoeW7h75SeqcJypzimh/d7KlnRmy9FCtyuj7Vsapzl?=
 =?us-ascii?q?lHtjFFktzQtnAV0BzT99SHRuN9/ki/3TaP0Bje6v1eLkAulKrbNoUhzqQslp?=
 =?us-ascii?q?sTrUvDHij2lF/wjKCKbUUr5vKk6+HmYrXivpOcNol0hR/iMqk2h8CyDus1Ph?=
 =?us-ascii?q?IOUmSG4+iwyrLu8VPjTLlXlvE2l7PWsJHeJcQVvK65BApV35455BmjADem19?=
 =?us-ascii?q?UYkmQZI19eZBKGj5TmO1HJIPziC/e/mE6jnC1kx/DBIL3tGo/NIWTbkLf9Yb?=
 =?us-ascii?q?Z97FZRyBIpwtBC45JZEakBL+juWk/1rdDYCxg5Mwuuw+n5EtlyyoQeWWeXCK?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUf48apjL9K/kj5/7zgn40gkEdfaa30psNcny4HeppI1?=
 =?us-ascii?q?+fYXXyhtcNC2AKvhAxTObykl2NTSZTZ2quX6I7/jw7DIOmDYHeRoGimbCBxz?=
 =?us-ascii?q?m0EYFLZmBcC1CMDXfpe5yBW/cLdS2SP8thnSIfWLi/RI8uywuuuBX5y7V5NO?=
 =?us-ascii?q?rU/DMXtZb52Nhy/e3Tmgk49SZoAMSFz2GNU2Z0k3sMRz8rwKB/pldwxU2G0a?=
 =?us-ascii?q?din/NXD8RT5/JVUgggMZ7Q1ep6BM7uWgjZZNeGVE6mQsm6ATE2Vt8xwdoOY0?=
 =?us-ascii?q?FnG9W4jxDDxDGnA7kPmLyOGpM087jQ33/rJ8Zy03zGzrUuj0E6QstTMm2rnq?=
 =?us-ascii?q?1/+BbNCI7Sj0qZkKGqdacH0SHR9GeD122OvERZUA5tVKXJR3cfZlHZrd7h/E?=
 =?us-ascii?q?PNU6euCag7MgtG0cOCMbVFasfmjVpYX/rjOM7RY2a1m2awAxaE3K+DbI3ve2?=
 =?us-ascii?q?8FxiXSFFAEkxwP/XaBLQU+BCCho2LYDDB0F1LvZEPs/vN4qHOgUEA0yRqHYF?=
 =?us-ascii?q?F72Lqz/R4Vg/2cRO8J0bIAoisutzJ0HFOl1dLMF9WAvxZhfLlbYd4l/FhIz3?=
 =?us-ascii?q?nZuBJ9P5G7NKBtml4efB5qv0Pg0xV4FJ9AndE2o3ww1gZ9NaWY0FZZfTOCwZ?=
 =?us-ascii?q?/wIqHXKnX1/B23bq7W3Uve0MqR+qcJ7fQ1sEnsvAGzFkol9nVn0sRV036G6p?=
 =?us-ascii?q?XNFgoSXor7Ulwr+Bhiu7Hafi496pvO1X1jKqa5qSXC1Mw0C+sl0BmgY81TP7?=
 =?us-ascii?q?+DFA/3C8caHdShKPQ2m1i1aRIJJORS9K8yP8O7ePqKwbSkPPt9kzKnkWRK+5?=
 =?us-ascii?q?p93VyR+Cp8UOHIw4wJzO2f3guCBH/AiwKZu93z0aVDYisfVj6nwDXgLJZYe6?=
 =?us-ascii?q?k3eIEME2roKMqykIZQnZnoDldR7lmlT3wB2cOkfVLGZlfy2gxc2GwLsHennm?=
 =?us-ascii?q?2+1DUynDY3+PnMlBfSyvjvIUJUclVAQ3Nv2BK1fNm5?=
X-IPAS-Result: =?us-ascii?q?A2DADgDZz1Jd/wHyM5BmHQEBBQEHBQGBZ4FuKoE/MiqEH?=
 =?us-ascii?q?o8lTQEBAQEBAQaBCS2JaooDhTeBZwkBAQEBAQEBAQE0AQIBAYQ/AoJ7IzgTA?=
 =?us-ascii?q?QQBAQEEAQEDAQkBAWyFM4I6KQGCZgEBAQEDIwQRQRALFQMCAhEOBwICVwYNB?=
 =?us-ascii?q?gIBAYJfP4F3FK0PfzOFSYMmgUmBDCiLaRd4gQeBOIFWYDU+g38lAQFdgkyCW?=
 =?us-ascii?q?ASVHJVBbQmCH4tfiE0GG4Iwhy+OXi2nOiGBWCsIAhgIIQ87gmyCThcVjikjA?=
 =?us-ascii?q?zCBBgEBjBmCQwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Aug 2019 15:01:07 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7DF11qV005698;
        Tue, 13 Aug 2019 11:01:01 -0400
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] security, capability: pass
 object information to security_capable
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, keescook@chromium.org,
        Serge Hallyn <serge@hallyn.com>, john.johansen@canonical.com,
        casey@schaufler-ca.com, mortonm@chromium.org, rgb@redhat.com,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, linux-audit@redhat.com
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
 <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov>
Date:   Tue, 13 Aug 2019 11:01:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/19 12:30 PM, Paul Moore wrote:
> On Thu, Aug 1, 2019 at 10:43 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>> From: Nicholas Franck <nhfran2@tycho.nsa.gov>
>>
>> At present security_capable does not pass any object information
>> and therefore can neither audit the particular object nor take it
>> into account. Augment the security_capable interface to support
>> passing supplementary data. Use this facility initially to convey
>> the inode for capability checks relevant to inodes. This only
>> addresses capable_wrt_inode_uidgid calls; other capability checks
>> relevant to inodes will be addressed in subsequent changes. In the
>> future, this will be further extended to pass object information for
>> other capability checks such as the target task for CAP_KILL.
>>
>> In SELinux this new information is leveraged here to include the inode
>> in the audit message. In the future, it could also be used to perform
>> a per inode capability checks.
>>
>> It would be possible to fold the existing opts argument into this new
>> supplementary data structure. This was omitted from this change to
>> minimize changes.
>>
>> Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>> ---
>> v2:
>> - Changed order of audit prints so optional information comes second
>> ---
>>   include/linux/capability.h             |  7 ++++++
>>   include/linux/lsm_audit.h              |  5 +++-
>>   include/linux/lsm_hooks.h              |  3 ++-
>>   include/linux/security.h               | 23 +++++++++++++-----
>>   kernel/capability.c                    | 33 ++++++++++++++++++--------
>>   kernel/seccomp.c                       |  2 +-
>>   security/apparmor/capability.c         |  8 ++++---
>>   security/apparmor/include/capability.h |  4 +++-
>>   security/apparmor/ipc.c                |  2 +-
>>   security/apparmor/lsm.c                |  5 ++--
>>   security/apparmor/resource.c           |  2 +-
>>   security/commoncap.c                   | 11 +++++----
>>   security/lsm_audit.c                   | 21 ++++++++++++++--
>>   security/safesetid/lsm.c               |  3 ++-
>>   security/security.c                    |  5 ++--
>>   security/selinux/hooks.c               | 20 +++++++++-------
>>   security/smack/smack_access.c          |  2 +-
>>   17 files changed, 110 insertions(+), 46 deletions(-)
> 
> You should CC the linux-audit list, I've added them on this mail.
> 
> I had hoped to see some thought put into the idea of dynamically
> emitting the proper audit records as I mentioned in the previous patch
> set, but regardless there are some comments on this code as written
> ...
> 
>> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
>> index 33028c098ef3..18cc7c956b69 100644
>> --- a/security/lsm_audit.c
>> +++ b/security/lsm_audit.c
>> @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>>          case LSM_AUDIT_DATA_IPC:
>>                  audit_log_format(ab, " key=%d ", a->u.ipc_id);
>>                  break;
>> -       case LSM_AUDIT_DATA_CAP:
>> -               audit_log_format(ab, " capability=%d ", a->u.cap);
>> +       case LSM_AUDIT_DATA_CAP: {
>> +               const struct inode *inode;
>> +
>> +               audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
>> +               if (a->u.cap_struct.cad) {
>> +                       switch (a->u.cap_struct.cad->type) {
>> +                       case CAP_AUX_DATA_INODE: {
>> +                               inode = a->u.cap_struct.cad->u.inode;
>> +
>> +                               audit_log_format(ab, " dev=");
>> +                               audit_log_untrustedstring(ab,
>> +                                       inode->i_sb->s_id);
>> +                               audit_log_format(ab, " ino=%lu",
>> +                                       inode->i_ino);
>> +                               break;
>> +                       }
> 
> Since you are declaring "inode" further up, there doesn't appear to be
> any need for the CAP_AUX_DATA_INODE braces, please remove them.
> 
> The general recommended practice when it comes to "sometimes" fields
> in an audit record, is to always record them in the record, but use a
> value of "?" when there is nothing relevant to record.  For example,
> when *not* recording inode information you would do something like the
> following:
> 
>    audit_log_format(ab, " dev=? ino=?");
> 
The issue this brings up is what happens when this is expanded to more 
cases? Assuming there will be a case here for logging audit data for 
task based capabilities (CAP_AUX_DATA_TASK), what do we want to have 
happen if we are recording *neither* inode information nor task 
information (say a PID)? If we log something in the inode case, we 
presumably don't want to call audit_log_format(ab, " dev=?, pid=?") as 
well. (And vice versa for when we log a pid and no inode).
>> +                       }
>> +               }
>>                  break;
>> +       }
>>          case LSM_AUDIT_DATA_PATH: {
>>                  struct inode *inode;
>>
> 

-- 
Aaron
