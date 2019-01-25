Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073A6C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1AB218CD
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="niBHwkUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAYOxS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:53:18 -0500
Received: from uhil19pa14.eemsg.mail.mil ([214.24.21.87]:49890 "EHLO
        UHIL19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYOxS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 09:53:18 -0500
X-EEMSG-check-017: 20068639|UHIL19PA14_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 14:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548427995; x=1579963995;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pj7PUFa55upV0SYIt7b2BkKDwLMJnW8uGCJNU8n6jMg=;
  b=niBHwkUyQCwIMzdDdhWxYzEw1SHre+2GPpwE2LUj7kh6yCp7uA6UQFBi
   EfjPfKhm5ibz5xmdjISUOkHCG5+/pB0W2cHOuoh8ZqHcxsibVxDNGMbgL
   3OEhyCMDRS5pIwK5pEJMN+gFD+DzJOyjvoZbmDrXj3EaKkA6JVPh1q6Ta
   uihBrLSf1AbsxKWwC+WK/Ng5p2LqGbQXQR+rvWAarKQ62IazgCce3gRQa
   fUWuRQI1Q1dDQdlH8UPSv6iyilhaCMJ4Wx+G+3+p7+4lwiLEOfxztv6MV
   44Q2MTL5rIMNKrhra0RN2DuEta6DRZ71Nm6nDtDXcpSFBi8J/ssc9GIUJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,521,1539648000"; 
   d="scan'208";a="23086366"
IronPort-PHdr: =?us-ascii?q?9a23=3AzrVFzB0q5+qVXoDOsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXK//xwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5YTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb9CjEJtVrS6aNo12T9s4Q252pSk6yqcJuY?=
 =?us-ascii?q?KhcCcWz5QnwhjSYOGEfYiQ+h/vSemcLDhiiH9lZb6znQi+/Ee+xuHmS8W51k?=
 =?us-ascii?q?tBoDBfndnWrH8N0gTe6s2ASvRg4EiswS2P1wXP6uFcJkA0iLbbJ4YhwrEukp?=
 =?us-ascii?q?oTtlzOHjPsl0Xsja+Wa14k9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLfL0X0/xs8fYDhkjPAOo3enqE8992Z0DVmKPGK?=
 =?us-ascii?q?CZLLnevkOP5uIqO+OMfpMauC7hK/g54P7jlWQ5lkEZfamo25sXdX+5E+94I0?=
 =?us-ascii?q?WWf3XsmM0NEWQUsQokSuzlllmCXSRUZ3aoUKI2/is7B56+DYffWoCth6SM3D?=
 =?us-ascii?q?+hEZ1LYmBLEUiMHm31d4WAQvsMbSWSIsh7kjMaT7SuV4gh1RS2vg/g17VnNv?=
 =?us-ascii?q?bU+jEftZ/70Nh15uvTlQw99DBtFcudznyCT2Bonm4TXT85wr1woUxnxVefy6?=
 =?us-ascii?q?R3n/tYFdlL7fNTTgg6LYLcz/B9C93qRw3AcM2GSFK9QtWmGjwxVMw+zMIOY0?=
 =?us-ascii?q?lnB9WulAzM3y2vA+xdq7veI5o46K/el132PMB0wHvFnP0mil49RMJEOEW8i6?=
 =?us-ascii?q?J//hSVDInMxQHRjKuudKIBzAbT+2qZi2mDpkdVVEh3S6qBFUgWe0+eiNP+/E?=
 =?us-ascii?q?6KG6enFLAPKgJczYuHLaxQZ5viilAQF9n5P9GLWH68g2e9A16zw7qIaIf7Mz?=
 =?us-ascii?q?EG0D71FFkPkwdV+22Pcwc5GHHy8CrlEDVyGAe3MAvX+u5kpSb+FxZswg=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2AZAADrIUtc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGBWilnUAEyJ4QBlBFMAQEBAQEBBoEICCV8iDiQTjAIAYRAAoMJI?=
 =?us-ascii?q?jcGDQEDAQEBAQEBAgFsHAyCOikBgmcBBSMEEUEQCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfPwGBdA0Pqw58M4VDhGgFgQuHSoNsF3iBB4ERJwyCKjWDHgQYhFCCVwKJV?=
 =?us-ascii?q?4cFOVaQTQmHLIp4BhiSJ4oThSWNaSKBVisIAhgIIQ+DJ4IkAxeDS4pxIQMwA?=
 =?us-ascii?q?YEEAQGKJwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 25 Jan 2019 14:53:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0PErCoM012051;
        Fri, 25 Jan 2019 09:53:12 -0500
Subject: Re: [PATCH v3 4/4] selinux: log invalid contexts in AVCs
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, Daniel Walsh <dwalsh@redhat.com>
References: <20190125100651.21753-1-omosnace@redhat.com>
 <20190125100651.21753-5-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bd549289-4c75-3929-efe4-1e3875ea609a@tycho.nsa.gov>
Date:   Fri, 25 Jan 2019 09:56:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125100651.21753-5-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/25/19 5:06 AM, Ondrej Mosnacek wrote:
> In case a file has an invalid context set, in an AVC record generated
> upon access to such file, the target context is always reported as
> unlabeled. This patch adds new optional fields to the AVC record
> (srawcon and trawcon) that report the actual context string if it
> differs from the one reported in scontext/tcontext. This is useful for
> diagnosing SELinux denials involving invalid contexts.
> 
> To trigger an AVC that illustrates this situation:
> 
>      # setenforce 0
>      # touch /tmp/testfile
>      # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
>      # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
> 
> AVC before:
> 
> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1
> 
> AVC after:
> 
> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1 trawcon=system_u:object_r:banana_t:s0
> 
> Note that it is also possible to encounter this situation with the
> 'scontext' field - e.g. when a new policy is loaded while a process is
> running, whose context is not valid in the new policy.
> 
> Cc: Daniel Walsh <dwalsh@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/avc.c              | 15 ++++++++++++
>   security/selinux/include/security.h |  3 +++
>   security/selinux/ss/services.c      | 37 +++++++++++++++++++++++++----
>   3 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 478fa4213c25..047de65589bd 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -734,6 +734,21 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>   
>   	if (sad->denied)
>   		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
> +
> +	/* in case of invalid context report also the actual context string */
> +	rc = security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
> +					   &scontext_len);
> +	if (!rc && scontext) {
> +		audit_log_format(ab, " srawcon=%s", scontext);
> +		kfree(scontext);
> +	}
> +
> +	rc = security_sid_to_context_inval(sad->state, sad->tsid, &scontext,
> +					   &scontext_len);
> +	if (!rc && scontext) {
> +		audit_log_format(ab, " trawcon=%s", scontext);
> +		kfree(scontext);
> +	}
>   }
>   
>   /* This is the slow part of avc audit with big stack footprint */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ba8eedf42b90..f68fb25b5702 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -255,6 +255,9 @@ int security_sid_to_context(struct selinux_state *state, u32 sid,
>   int security_sid_to_context_force(struct selinux_state *state,
>   				  u32 sid, char **scontext, u32 *scontext_len);
>   
> +int security_sid_to_context_inval(struct selinux_state *state,
> +				  u32 sid, char **scontext, u32 *scontext_len);
> +
>   int security_context_to_sid(struct selinux_state *state,
>   			    const char *scontext, u32 scontext_len,
>   			    u32 *out_sid, gfp_t gfp);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index dd44126c8d14..9be05c3e99dc 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1281,7 +1281,8 @@ const char *security_get_initial_sid_context(u32 sid)
>   
>   static int security_sid_to_context_core(struct selinux_state *state,
>   					u32 sid, char **scontext,
> -					u32 *scontext_len, int force)
> +					u32 *scontext_len, int force,
> +					int only_invalid)
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> @@ -1326,8 +1327,14 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	rc = context_struct_to_string(policydb, context, scontext,
> -				      scontext_len);
> +	if (only_invalid && !context->len) {
> +		scontext = NULL;
> +		scontext_len = 0;
> +		rc = 0;
> +	} else {
> +		rc = context_struct_to_string(policydb, context, scontext,
> +					      scontext_len);
> +	}
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
>   out:
> @@ -1349,14 +1356,34 @@ int security_sid_to_context(struct selinux_state *state,
>   			    u32 sid, char **scontext, u32 *scontext_len)
>   {
>   	return security_sid_to_context_core(state, sid, scontext,
> -					    scontext_len, 0);
> +					    scontext_len, 0, 0);
>   }
>   
>   int security_sid_to_context_force(struct selinux_state *state, u32 sid,
>   				  char **scontext, u32 *scontext_len)
>   {
>   	return security_sid_to_context_core(state, sid, scontext,
> -					    scontext_len, 1);
> +					    scontext_len, 1, 0);
> +}
> +
> +/**
> + * security_sid_to_context_inval - Obtain a context for a given SID if it
> + *                                 is invalid.
> + * @sid: security identifier, SID
> + * @scontext: security context
> + * @scontext_len: length in bytes
> + *
> + * Write the string representation of the context associated with @sid
> + * into a dynamically allocated string of the correct size, but only if the
> + * context is invalid in the current policy.  Set @scontext to point to
> + * this string (or NULL if the context is valid) and set @scontext_len to
> + * the length of the string (or 0 if the context is valid).
> + */
> +int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
> +				  char **scontext, u32 *scontext_len)
> +{
> +	return security_sid_to_context_core(state, sid, scontext,
> +					    scontext_len, 1, 1);
>   }
>   
>   /*
> 

