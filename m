Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19554C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21E62064B
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n+myRMg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRRzq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:55:46 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:1240 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRzq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 12:55:46 -0500
X-EEMSG-check-017: 39549613|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="39549613"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 17:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576691742; x=1608227742;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wOJkr88jMDY5hEqGcbEim41mh6w5q3F+RM2P/+iugsE=;
  b=n+myRMg3MqNvkqFCyFxFrRE8Jz5U9lYkWf/nxZ/weM1Rp6rN7tsEyTQ2
   e5R79LSrgSkDZ4k/GgGMlJMLubXWC3r+cofWm8i5Q/cv3ynERe2dce/hh
   gbM7gScMHAf+59aujH1Ns20lfwi2TPSVEi77S/EIx/L65S0nep88keb6e
   BcK6pV4pTdvDL/SwxazMLX7h29R89E7mz4lU6KMt1TbRsx4OOEDVmX3Oi
   f3xmIsbutRv4FH4bGYSyMzke5Pk1fWRKbGJsQvu9hLZryFbR0hIwcvJX6
   J5XUp/WKt+XG1Oftn4A4f2uYQWHvSefJJv+yLfPdDbXw6dS1sNUYZbmu/
   w==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31245647"
IronPort-PHdr: =?us-ascii?q?9a23=3ANFgxAhExbQ9LoxatptFrLJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8u+bnLW6fgltlLVR4KTs6sC17ON9fq4CCdZuc/JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusUKhYZuJbs9xg?=
 =?us-ascii?q?fUrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAehCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jJ?=
 =?us-ascii?q?sTsULNHi/xg0X5krOZel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB74dOv3zQVH+tdzDAx8iLwO0w/zoCMhz1oMaR22PGL?=
 =?us-ascii?q?aVP7/IvlOS+u0vJOyMbpcPuDnhM/gl++LujXghlFABZ6apxoUYaXCiEvR9P0?=
 =?us-ascii?q?qZYWDjgsoPEWcOoAU+VvfniFyEUT5PeXmyW7gw6S08CIKjFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfmJGClWLEXfybYWEWuwMZTmUIsB7lzwLS7mhR5Um1RG0uw/w06BnIf?=
 =?us-ascii?q?bM+i0EqZLj08B45+nSlRE06Dx1AN2R03qTQG5og2MIXT423Lx/oEBkz1eD1r?=
 =?us-ascii?q?V3g+FcFdNN/P5JTAg6OoDGz+BgCND9RBjBftGXR1aiWNmmBisxTt0pyd8Uf0?=
 =?us-ascii?q?l9A8mijgzE3yeyGL8aibiLBJ0y8qLB0Hn8PNh9y3nY26k7lVUmQdVANXeghq?=
 =?us-ascii?q?Fh8wjfHYnJk1+Wl6yyb6QTwDbN9HufzWqJpExYUxB/XrveXX8DYUvWqtf561?=
 =?us-ascii?q?jeQL+uE7QnNQ5Byc+fKqtPcNHpik9GRPj7MtTEf22xg3uwBQqPxr6UborqfG?=
 =?us-ascii?q?Ud3CPHBEgGlAAT/WyJNQ4lBii/pWLTFyBhGkjpY0Pr9+l+qW+0QVUwzw2Qc0?=
 =?us-ascii?q?Jh0L+18AYPhfOAU/MTwq4EuCA5pjVsAlm92d3WC8eBpwpnZalcYs0y4E1B1W?=
 =?us-ascii?q?3HswxwJZ2gI7lmhl4ZbQR4oVni1w5tBYVDjMgqtmklwBB0Ka2Gyl9BdSuY14?=
 =?us-ascii?q?jqOrLLMmny4Ayva6nO11HGytmW56MP5e8gq1r5oQGpElMu83Bg09lSyXuT+I?=
 =?us-ascii?q?/GAxYVUZL0AQ4L8E1RrqrXc2EG7IPdyHNoPLP85jTLwN84LPAuyh+9cdNSKu?=
 =?us-ascii?q?aPHUn5FMhMQ4ClIfcnih6yZRINIe5W+bQcPsW6ev/A06mueK5imTW8l2VcyI?=
 =?us-ascii?q?Z010+NsS1mRaqA25cD3uHdxQaMSi39kEbkt8f7hIRJTS8dE3D5yiX+AoNVIK?=
 =?us-ascii?q?pocsJDEmqqIsuq1v1giJP3HX1V7liuAxUBwsD6VwCVagnGwQBI1UkR6UeikC?=
 =?us-ascii?q?+8wi08xyoltYKDzSfOxKLkbxNBNWlVEjoxxWzwKJS52ohJFHOjaBIkwV78vh?=
 =?us-ascii?q?f3?=
X-IPAS-Result: =?us-ascii?q?A2BKAAAuZ/pd/wHyM5BbChoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfIF2gW0gEiqEBIkDhlkGgRIlgQGIaZFFCQEBAQEBAQEBATcBA?=
 =?us-ascii?q?YRAAoI9OBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEaCQQRQQULC?=
 =?us-ascii?q?xgCAiYCAlcGAQwGAgEBgl8/glMFIK0YdX8zhU+DOYFBgQ4oinqBOHmBB4ERJ?=
 =?us-ascii?q?wwDgig1PoQegzuCXgSWLWFGlzWCP4JDk0oGG5pOLY4hnF8igVgrCAIYCCEPO?=
 =?us-ascii?q?4JsUBgNjR0BF45BIwMwjy0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 17:55:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIHtHAi066153;
        Wed, 18 Dec 2019 12:55:20 -0500
Subject: Re: [PATCH v12 21/25] Audit: Add subj_LSM fields when necessary
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-22-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1baec144-690c-5603-d108-7fe10bb486c9@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 12:55:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-22-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Add record entries to identify subject data for all of the
> security modules when there is more than one.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.com
> cc: linux-audit@redhat.com

Disclaimer: should be reviewed by netdev & audit maintainers at least. 
Also, I have not verified that the use of LSMBLOB_DISPLAY is always the 
right thing to do for the netfilter cases or whether some ought to use 
LSMBLOB_FIRST instead.  Otherwise,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   drivers/android/binder.c                |  2 +-
>   include/linux/audit.h                   |  1 +
>   include/linux/security.h                |  9 ++++-
>   include/net/scm.h                       |  3 +-
>   kernel/audit.c                          | 40 ++++++++++++++++++-
>   kernel/audit_fsnotify.c                 |  1 +
>   kernel/auditfilter.c                    |  1 +
>   kernel/auditsc.c                        | 10 +++--
>   net/ipv4/ip_sockglue.c                  |  2 +-
>   net/netfilter/nf_conntrack_netlink.c    |  4 +-
>   net/netfilter/nf_conntrack_standalone.c |  2 +-
>   net/netfilter/nfnetlink_queue.c         |  2 +-
>   net/netlabel/netlabel_unlabeled.c       | 11 ++++--
>   net/netlabel/netlabel_user.c            |  2 +-
>   net/xfrm/xfrm_policy.c                  |  2 +
>   net/xfrm/xfrm_state.c                   |  2 +
>   security/integrity/ima/ima_api.c        |  1 +
>   security/integrity/integrity_audit.c    |  1 +
>   security/security.c                     | 51 +++++++++++++++++++++++--
>   19 files changed, 124 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 3c5eee35aae6..c9324c094888 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3107,7 +3107,7 @@ static void binder_transaction(struct binder_proc *proc,
>   		size_t added_size;
>   
>   		security_task_getsecid(proc->tsk, &blob);
> -		ret = security_secid_to_secctx(&blob, &lsmctx);
> +		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
>   		if (ret) {
>   			return_error = BR_FAILED_REPLY;
>   			return_error_param = ret;
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index f9ceae57ca8d..2ce0e8da3922 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -161,6 +161,7 @@ extern void		    audit_log_path_denied(int type,
>   extern void		    audit_log_lost(const char *message);
>   
>   extern int audit_log_task_context(struct audit_buffer *ab);
> +extern void audit_log_task_lsms(struct audit_buffer *ab);
>   extern void audit_log_task_info(struct audit_buffer *ab);
>   
>   extern int		    audit_update_lsm_rules(void);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0fab9f5dddf..536db4dbfcbb 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -180,6 +180,8 @@ struct lsmblob {
>   #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
>   #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>   #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +#define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
> +#define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
>   
>   /**
>    * lsmblob_init - initialize an lsmblob structure.
> @@ -221,6 +223,8 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
>   	return !memcmp(bloba, blobb, sizeof(*bloba));
>   }
>   
> +const char *security_lsm_slot_name(int slot);
> +
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>   		       int cap, unsigned int opts);
> @@ -530,7 +534,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   			 size_t size);
>   int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>   int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
> +			     int display);
>   int security_secctx_to_secid(const char *secdata, u32 seclen,
>   			     struct lsmblob *blob);
>   void security_release_secctx(struct lsmcontext *cp);
> @@ -1334,7 +1339,7 @@ static inline int security_ismaclabel(const char *name)
>   }
>   
>   static inline int security_secid_to_secctx(struct lsmblob *blob,
> -					   struct lsmcontext *cp)
> +					   struct lsmcontext *cp, int display)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 4a6ad8caf423..8b5a4737e1b8 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -96,7 +96,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>   	int err;
>   
>   	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(&scm->lsmblob, &context);
> +		err = security_secid_to_secctx(&scm->lsmblob, &context,
> +					       LSMBLOB_DISPLAY);
>   
>   		if (!err) {
>   			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 224c7b4a1bc0..d40f64a47c4b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -392,6 +392,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>   	if (rc)
>   		allow_changes = 0; /* Something weird, deny request */
>   	audit_log_format(ab, " res=%d", allow_changes);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   	return rc;
>   }
> @@ -1097,6 +1098,7 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>   	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
>   			 audit_feature_names[which], !!old_feature, !!new_feature,
>   			 !!old_lock, !!new_lock, res);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> @@ -1347,6 +1349,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   					size--;
>   				audit_log_n_untrustedstring(ab, data, size);
>   			}
> +			audit_log_task_lsms(ab);
>   			audit_log_end(ab);
>   		}
>   		break;
> @@ -1361,6 +1364,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   					 msg_type == AUDIT_ADD_RULE ?
>   						"add_rule" : "remove_rule",
>   					 audit_enabled);
> +			audit_log_task_lsms(ab);
>   			audit_log_end(ab);
>   			return -EPERM;
>   		}
> @@ -1374,6 +1378,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   		audit_log_common_recv_msg(audit_context(), &ab,
>   					  AUDIT_CONFIG_CHANGE);
>   		audit_log_format(ab, " op=trim res=1");
> +		audit_log_task_lsms(ab);
>   		audit_log_end(ab);
>   		break;
>   	case AUDIT_MAKE_EQUIV: {
> @@ -1409,6 +1414,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   		audit_log_format(ab, " new=");
>   		audit_log_untrustedstring(ab, new);
>   		audit_log_format(ab, " res=%d", !err);
> +		audit_log_task_lsms(ab);
>   		audit_log_end(ab);
>   		kfree(old);
>   		kfree(new);
> @@ -1418,7 +1424,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   		len = 0;
>   		if (lsmblob_is_set(&audit_sig_lsm)) {
>   			err = security_secid_to_secctx(&audit_sig_lsm,
> -						       &context);
> +						       &context, LSMBLOB_FIRST);
>   			if (err)
>   				return err;
>   		}
> @@ -1477,6 +1483,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   				 " old-log_passwd=%d new-log_passwd=%d res=%d",
>   				 old.enabled, s.enabled, old.log_passwd,
>   				 s.log_passwd, !err);
> +		audit_log_task_lsms(ab);
>   		audit_log_end(ab);
>   		break;
>   	}
> @@ -2055,6 +2062,33 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>   		audit_log_format(ab, "(null)");
>   }
>   
> +void audit_log_task_lsms(struct audit_buffer *ab)
> +{
> +	int i;
> +	const char *lsm;
> +	struct lsmblob blob;
> +	struct lsmcontext context;
> +
> +	/*
> +	 * Don't do anything unless there is more than one LSM
> +	 * with a security context to report.
> +	 */
> +	if (security_lsm_slot_name(1) == NULL)
> +		return;
> +
> +	security_task_getsecid(current, &blob);
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +		lsm = security_lsm_slot_name(i);
> +		if (lsm == NULL)
> +			break;
> +		if (security_secid_to_secctx(&blob, &context, i))
> +			continue;
> +		audit_log_format(ab, " subj_%s=%s", lsm, context.context);
> +		security_release_secctx(&context);
> +	}
> +}
> +
>   int audit_log_task_context(struct audit_buffer *ab)
>   {
>   	int error;
> @@ -2065,7 +2099,7 @@ int audit_log_task_context(struct audit_buffer *ab)
>   	if (!lsmblob_is_set(&blob))
>   		return 0;
>   
> -	error = security_secid_to_secctx(&blob, &context);
> +	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
>   	if (error) {
>   		if (error != -EINVAL)
>   			goto error_path;
> @@ -2173,6 +2207,7 @@ void audit_log_path_denied(int type, const char *operation)
>   	audit_log_format(ab, "op=%s", operation);
>   	audit_log_task_info(ab);
>   	audit_log_format(ab, " res=0");
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> @@ -2223,6 +2258,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
>   			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
>   			 oldsessionid, sessionid, !rc);
>   	audit_put_tty(tty);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index f0d243318452..7f8c4b1a2884 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -126,6 +126,7 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
>   	audit_log_untrustedstring(ab, audit_mark->path);
>   	audit_log_key(ab, rule->filterkey);
>   	audit_log_format(ab, " list=%d res=1", rule->listnr);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 19cfbe716f9d..bf28bb599b6d 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1103,6 +1103,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
>   	audit_log_format(ab, " op=%s", action);
>   	audit_log_key(ab, rule->filterkey);
>   	audit_log_format(ab, " list=%d res=%d", rule->listnr, res);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6d273183dd87..e0dd643e9b13 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -973,7 +973,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   			 from_kuid(&init_user_ns, auid),
>   			 from_kuid(&init_user_ns, uid), sessionid);
>   	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &lsmctx)) {
> +		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
>   			audit_log_format(ab, " obj=(none)");
>   			rc = 1;
>   		} else {
> @@ -1218,7 +1218,8 @@ static void show_special(struct audit_context *context, int *call_panic)
>   			struct lsmblob blob;
>   
>   			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt)) {
> +			if (security_secid_to_secctx(&blob, &lsmcxt,
> +						     LSMBLOB_FIRST)) {
>   				audit_log_format(ab, " osid=%u", osid);
>   				*call_panic = 1;
>   			} else {
> @@ -1370,7 +1371,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>   		struct lsmcontext lsmctx;
>   
>   		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx)) {
> +		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
>   			audit_log_format(ab, " osid=%u", n->osid);
>   			if (call_panic)
>   				*call_panic = 2;
> @@ -1479,6 +1480,7 @@ static void audit_log_exit(void)
>   
>   	audit_log_task_info(ab);
>   	audit_log_key(ab, context->filterkey);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   
>   	for (aux = context->aux; aux; aux = aux->next) {
> @@ -2602,6 +2604,7 @@ void audit_core_dumps(long signr)
>   		return;
>   	audit_log_task(ab);
>   	audit_log_format(ab, " sig=%ld res=1", signr);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> @@ -2628,6 +2631,7 @@ void audit_seccomp(unsigned long syscall, long signr, int code)
>   	audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
>   			 signr, syscall_get_arch(current), syscall,
>   			 in_compat_syscall(), KSTK_EIP(current), code);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
>   
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 27af7a6b8780..10b418029cdd 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -138,7 +138,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>   	if (err)
>   		return;
>   
> -	err = security_secid_to_secctx(&lb, &context);
> +	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
>   	if (err)
>   		return;
>   
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 255bcb886a2f..b2f522b39a1a 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -334,7 +334,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>   	struct lsmcontext context;
>   
>   	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>   	if (ret)
>   		return 0;
>   
> @@ -649,7 +649,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>   	struct lsmcontext context;
>   
>   	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>   	if (ret)
>   		return 0;
>   
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 8969754d7fe9..0ff2b8300c28 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -177,7 +177,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>   	struct lsmcontext context;
>   
>   	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>   	if (ret)
>   		return;
>   
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index a1296453d8f2..b6f71be884e8 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -314,7 +314,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
>   	if (skb->secmark) {
>   		/* Any LSM might be looking for the secmark */
>   		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, context);
> +		security_secid_to_secctx(&blob, context, LSMBLOB_DISPLAY);
>   	}
>   
>   	read_unlock_bh(&skb->sk->sk_callback_lock);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 3b0f07b59436..60a7665de0e3 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -436,7 +436,8 @@ int netlbl_unlhsh_add(struct net *net,
>   unlhsh_add_return:
>   	rcu_read_unlock();
>   	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(lsmblob, &context) == 0) {
> +		if (security_secid_to_secctx(lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s",
>   					 context.context);
>   			security_release_secctx(&context);
> @@ -491,7 +492,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   		if (dev != NULL)
>   			dev_put(dev);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s",
>   					 context.context);
>   			security_release_secctx(&context);
> @@ -551,7 +553,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   		if (dev != NULL)
>   			dev_put(dev);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s",
>   					 context.context);
>   			security_release_secctx(&context);
> @@ -1122,7 +1125,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   		lsmb = (struct lsmblob *)&addr6->lsmblob;
>   	}
>   
> -	ret_val = security_secid_to_secctx(lsmb, &context);
> +	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
>   	if (ret_val != 0)
>   		goto list_cb_failure;
>   	ret_val = nla_put(cb_arg->skb,
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 951ba0639d20..1941877fd16f 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>   
>   	lsmblob_init(&blob, audit_info->secid);
>   	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(&blob, &context) == 0) {
> +	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
>   		audit_log_format(audit_buf, " subj=%s", context.context);
>   		security_release_secctx(&context);
>   	}
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index f2d1e573ea55..bd2b36a83e66 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4206,6 +4206,7 @@ void xfrm_audit_policy_add(struct xfrm_policy *xp, int result, bool task_valid)
>   	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
>   	audit_log_format(audit_buf, " res=%u", result);
>   	xfrm_audit_common_policyinfo(xp, audit_buf);
> +	audit_log_task_lsms(audit_buf);
>   	audit_log_end(audit_buf);
>   }
>   EXPORT_SYMBOL_GPL(xfrm_audit_policy_add);
> @@ -4221,6 +4222,7 @@ void xfrm_audit_policy_delete(struct xfrm_policy *xp, int result,
>   	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
>   	audit_log_format(audit_buf, " res=%u", result);
>   	xfrm_audit_common_policyinfo(xp, audit_buf);
> +	audit_log_task_lsms(audit_buf);
>   	audit_log_end(audit_buf);
>   }
>   EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index f3423562d933..bfb8402cb28d 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2642,6 +2642,7 @@ void xfrm_audit_state_add(struct xfrm_state *x, int result, bool task_valid)
>   	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
>   	xfrm_audit_helper_sainfo(x, audit_buf);
>   	audit_log_format(audit_buf, " res=%u", result);
> +	audit_log_task_lsms(audit_buf);
>   	audit_log_end(audit_buf);
>   }
>   EXPORT_SYMBOL_GPL(xfrm_audit_state_add);
> @@ -2656,6 +2657,7 @@ void xfrm_audit_state_delete(struct xfrm_state *x, int result, bool task_valid)
>   	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
>   	xfrm_audit_helper_sainfo(x, audit_buf);
>   	audit_log_format(audit_buf, " res=%u", result);
> +	audit_log_task_lsms(audit_buf);
>   	audit_log_end(audit_buf);
>   }
>   EXPORT_SYMBOL_GPL(xfrm_audit_state_delete);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 1ab769fa7df6..252dc00700e8 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -363,6 +363,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>   	audit_log_format(ab, " hash=\"%s:%s\"", algo_name, hash);
>   
>   	audit_log_task_info(ab);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   
>   	iint->flags |= IMA_AUDITED;
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..bca89ae72e3d 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -54,5 +54,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>   		audit_log_format(ab, " ino=%lu", inode->i_ino);
>   	}
>   	audit_log_format(ab, " res=%d", !result);
> +	audit_log_task_lsms(ab);
>   	audit_log_end(ab);
>   }
> diff --git a/security/security.c b/security/security.c
> index bca092dd4f00..d0b57a7c3b31 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -449,7 +449,31 @@ static int lsm_append(const char *new, char **result)
>    * Pointers to the LSM id structures for local use.
>    */
>   static int lsm_slot __lsm_ro_after_init;
> -static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
> +
> +/**
> + * security_lsm_slot_name - Get the name of the security module in a slot
> + * @slot: index into the "display" slot list.
> + *
> + * Provide the name of the security module associated with
> + * a display slot.
> + *
> + * If @slot is LSMBLOB_INVALID return the value
> + * for slot 0 if it has been set, otherwise NULL.
> + *
> + * Returns a pointer to the name string or NULL.
> + */
> +const char *security_lsm_slot_name(int slot)
> +{
> +	if (slot == LSMBLOB_INVALID)
> +		slot = 0;
> +	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
> +		return NULL;
> +
> +	if (lsm_slotlist[slot] == NULL)
> +		return NULL;
> +	return lsm_slotlist[slot]->lsm;
> +}
>   
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -2159,13 +2183,32 @@ int security_ismaclabel(const char *name)
>   }
>   EXPORT_SYMBOL(security_ismaclabel);
>   
> -int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
> +			     int display)
>   {
>   	struct security_hook_list *hp;
> -	int display = lsm_task_display(current);
>   
>   	memset(cp, 0, sizeof(*cp));
>   
> +	/*
> +	 * display either is the slot number use for formatting
> +	 * or an instruction on which relative slot to use.
> +	 */
> +	if (display == LSMBLOB_DISPLAY)
> +		display = lsm_task_display(current);
> +	else if (display == LSMBLOB_FIRST)
> +		display = LSMBLOB_INVALID;
> +	else if (display < 0) {
> +		WARN_ONCE(true,
> +			"LSM: security_secid_to_secctx unknown display\n");
> +		display = LSMBLOB_INVALID;
> +	} else if (display >= lsm_slot) {
> +		WARN_ONCE(true,
> +			"LSM: security_secid_to_secctx invalid display\n");
> +		display = LSMBLOB_INVALID;
> +	}
> +
> +
>   	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> @@ -2176,7 +2219,7 @@ int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
>   					&cp->context, &cp->len);
>   		}
>   	}
> -	return 0;
> +	return -EOPNOTSUPP;
>   }
>   EXPORT_SYMBOL(security_secid_to_secctx);
>   
> 

