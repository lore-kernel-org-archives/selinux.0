Return-Path: <SRS0=OEgM=P3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93367C61CE4
	for <selinux@archiver.kernel.org>; Sat, 19 Jan 2019 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2A42084C
	for <selinux@archiver.kernel.org>; Sat, 19 Jan 2019 13:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfASNXN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:23:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfASNXN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 19 Jan 2019 08:23:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B90CC05D3E7;
        Sat, 19 Jan 2019 13:23:13 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0231560BF1;
        Sat, 19 Jan 2019 13:23:04 +0000 (UTC)
Date:   Sat, 19 Jan 2019 08:23:01 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-audit@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH] selinux: log invalid contexts in AVCs
Message-ID: <20190119132301.bwlokbs6vth7erkw@madcap2.tricolour.ca>
References: <20190118100429.11703-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118100429.11703-1-omosnace@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 19 Jan 2019 13:23:13 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019-01-18 11:04, Ondrej Mosnacek wrote:
> In case a file has an invalid context set, in an AVC record generated
> upon access to such file, the target context is always reported as
> unlabeled. This patch adds new optional fields to the AVC record (slcon
> and tlcon) that report the actual context string if it differs from the
> one reported in scontext/tcontext. This is useful for diagnosing SELinux
> denials.
> 
> To trigger an AVC that illustrates this situation:
> 
>     # setenforce 0
>     # touch /tmp/testfile
>     # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
>     # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
> 
> AVC before:
> 
> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1
> 
> AVC after:
> 
> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tlcon=system_u:object_r:banana_t:s0 tclass=file permissive=1
> 
> Cc: Daniel Walsh <dwalsh@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> I'm not entirely sure about the record format here, so I'm Cc'ing
> linux-audit and Steve for feedback. I went for optional fields to
> minimize the size of the record, but maybe a different format is
> preferred. If so, let me know and I'll do a respin.

My understanding is that optional fields can be a problem (but not if
it is a non-searchable field?).  There is an existing "invalid_context"
field whose position may help indicate which one it refers to, but this
sounds pretty weak.

Alternatively the best I could suggest would be a new auxiliary record.

> Also, I accept suggestions for better field names than "slcon"/"tlcon"
> ("lcon" is meant as an acronym for "literal context", but I'm not sure
> if that's a good name...).
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9b63d8ee1687..4a181ed56e37 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>  	audit_log_format(ab, " }");
>  }
>  
> +static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
> +			 u32 sid, char type)
> +{
> +	int rc;
> +	char *context, *lcontext;
> +	u32 context_len, lcontext_len;
> +
> +	rc = security_sid_to_context(state, sid, &context, &context_len);
> +	if (rc) {
> +		audit_log_format(ab, "%csid=%d ", type, sid);
> +		return;
> +	}
> +
> +	audit_log_format(ab, "%ccontext=%s ", type, context);
> +
> +	/* in case of invalid context report also the actual context string */
> +	rc = security_sid_to_context_force(state, sid, &lcontext,
> +					   &lcontext_len);
> +	if (!rc) {
> +		if (strcmp(context, lcontext))
> +			audit_log_format(ab, "%clcon=%s ", type, lcontext);
> +		kfree(lcontext);
> +	}
> +	kfree(context);
> +}
> +
>  /**
>   * avc_dump_query - Display a SID pair and a class in human-readable form.
>   * @ssid: source security identifier
> @@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>  static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
>  			   u32 ssid, u32 tsid, u16 tclass)
>  {
> -	int rc;
> -	char *scontext;
> -	u32 scontext_len;
> -
> -	rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
> -	if (rc)
> -		audit_log_format(ab, "ssid=%d", ssid);
> -	else {
> -		audit_log_format(ab, "scontext=%s", scontext);
> -		kfree(scontext);
> -	}
> -
> -	rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> -	if (rc)
> -		audit_log_format(ab, " tsid=%d", tsid);
> -	else {
> -		audit_log_format(ab, " tcontext=%s", scontext);
> -		kfree(scontext);
> -	}
> +	avc_dump_sid(ab, state, ssid, 's');
> +	avc_dump_sid(ab, state, tsid, 't');
>  
>  	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> -	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> +	audit_log_format(ab, "tclass=%s", secclass_map[tclass-1].name);
>  }
>  
>  /**
> -- 
> 2.20.1
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
