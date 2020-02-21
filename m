Return-Path: <SRS0=FZ6t=4J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF00C35647
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 10:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9852073A
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 10:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="SBfl4oeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgBUKzl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:55:41 -0500
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:30848 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgBUKzl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Feb 2020 05:55:41 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20200221105536.LMOE28510.sa-prd-fep-049.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 21 Feb 2020 10:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582282536; 
        bh=b8DKG9mFqGccryGfAStEwj9y8xG3laK9pfqqz5qy59I=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=SBfl4oebEFkJmeO1SNam8fCT+K6kvFN20I5qGesdrRdZO4NVoCeEBUGalq+Nnqt/ik9bRurNoK0DyYB9Md/81UAtl19mmgkpVY0tocQetCCT3pK16S27yKknCo5TxIjMyO619C8z9yjDFDE9NFTTNGxeJWfLz++l5ZHQM3CTaLR41k+gxpBfRY/z965KSvFgqYOHGgy+WNVXs9BUhvjRSo3U/aVBHXapFxa0OwUH2rgY1OIBb5cLnTvP1JhSFZgwS/r9wiKyTHd0i21QBA6XvfLI2j5sG0GPpfonnQKn9g7yPO3eNMtLzghWAavDoFTLj6n5zfbx15Wph3IFCGO85g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.5.24]
X-OWM-Source-IP: 86.134.5.24 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrkeeggddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdehrddvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdehrddvgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.5.24) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A27DB028D220F; Fri, 21 Feb 2020 10:55:36 +0000
Message-ID: <ef2649112806a061b8dbb41cef979bf01eabb05d.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] selinux: Add support for new key permissions
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, dhowells@redhat.com
Cc:     selinux@vger.kernel.org, paul@paul-moore.com
Date:   Fri, 21 Feb 2020 10:55:34 +0000
In-Reply-To: <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
References: <20200220181031.156674-1-richard_c_haines@btinternet.com>
         <20200220181031.156674-2-richard_c_haines@btinternet.com>
         <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-02-20 at 14:28 -0500, Stephen Smalley wrote:
> On 2/20/20 1:10 PM, Richard Haines wrote:
> > Add a new 'key_perms' policy capability and support for the
> > additional
> > key permissions: inval, revoke, join, clear
> > 
> > Also fixes JOIN -> LINK permission translation when policy
> > capability 'keys_perms' = 0;
> > 
> > The current "setattr" perm name remains and is used for
> > KEY_NEED_SETSEC.
> > This gives the following permissions for the 'key' class:
> > 
> > create	Create a key or keyring.
> > view	View attributes.
> > read	Read contents.
> > write	Update or modify.
> > search	Search (keyring) or find (key).
> > link	Link a key into the keyring.
> > setattr	kernel < current version: Change permissions on a
> > keyring.
> > 	kernel >= current version: Set owner, group, ACL.
> > inval	Invalidate key.
> > revoke	Revoke key.
> > join	Join keyring as session.
> > clear	Clear a keyring.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> 
> What is this relative to?  Didn't apply for me on any of keys-acl or 
> keys-next or selinux-next.

I build this version of the patch on linux-next-next-20200214.tar.gz

> 
> Regardless, we need to revert the original patch and create a new
> one 
> that addresses the KEY_NEED_PARENT_JOIN issue I mentioned and that
> adds 
> the key_perms capability in the right place in the first place, not 
> apply a fix on top.

Yes I know. I was just making the point to David that as far as I can
see keys only ever passes one perm at a time.

> 
> > ---
> >   security/selinux/hooks.c            | 123 ++++++++++++++++-------
> > -----
> >   security/selinux/include/security.h |  10 +--
> >   security/selinux/ss/services.c      |   4 +-
> >   3 files changed, 76 insertions(+), 61 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 46a8f3e7d..af179442c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6538,8 +6538,7 @@ static int selinux_key_permission(key_ref_t
> > key_ref,
> >   {
> >   	struct key *key;
> >   	struct key_security_struct *ksec;
> > -	unsigned int key_perm = 0, switch_perm = 0;
> > -	int bit = 1, count = KEY_NEED_ALL;
> > +	unsigned int key_perm = 0;
> >   	u32 sid;
> >   
> >   	/* if no specific permissions are requested, we skip the
> > @@ -6549,60 +6548,73 @@ static int selinux_key_permission(key_ref_t
> > key_ref,
> >   		return 0;
> >   
> >   	if (selinux_policycap_key_perms()) {
> > -		while (count) {
> > -			switch_perm = bit & perm;
> > -			switch (switch_perm) {
> > -			case KEY_NEED_VIEW:
> > -				key_perm |= KEY__VIEW;
> > -				break;
> > -			case KEY_NEED_READ:
> > -				key_perm |= KEY__READ;
> > -				break;
> > -			case KEY_NEED_WRITE:
> > -				key_perm |= KEY__WRITE;
> > -				break;
> > -			case KEY_NEED_SEARCH:
> > -				key_perm |= KEY__SEARCH;
> > -				break;
> > -			case KEY_NEED_LINK:
> > -				key_perm |= KEY__LINK;
> > -				break;
> > -			case KEY_NEED_SETSEC:
> > -				key_perm |= KEY__SETATTR;
> > -				break;
> > -			case KEY_NEED_INVAL:
> > -				key_perm |= KEY__INVAL;
> > -				break;
> > -			case KEY_NEED_REVOKE:
> > -				key_perm |= KEY__REVOKE;
> > -				break;
> > -			case KEY_NEED_JOIN:
> > -			case KEY_NEED_PARENT_JOIN:
> > -				key_perm |= KEY__JOIN;
> > -				break;
> > -			case KEY_NEED_CLEAR:
> > -				key_perm |= KEY__CLEAR;
> > -				break;
> > -			}
> > -			bit <<= 1;
> > -			count >>= 1;
> > +		switch (perm) {
> > +		case KEY_NEED_VIEW:
> > +			key_perm = KEY__VIEW;
> > +			break;
> > +		case KEY_NEED_READ:
> > +			key_perm = KEY__READ;
> > +			break;
> > +		case KEY_NEED_WRITE:
> > +			key_perm = KEY__WRITE;
> > +			break;
> > +		case KEY_NEED_SEARCH:
> > +			key_perm = KEY__SEARCH;
> > +			break;
> > +		case KEY_NEED_LINK:
> > +			key_perm = KEY__LINK;
> > +			break;
> > +		case KEY_NEED_SETSEC:
> > +			key_perm = KEY__SETATTR;
> > +			break;
> > +		case KEY_NEED_INVAL:
> > +			key_perm = KEY__INVAL;
> > +			break;
> > +		case KEY_NEED_REVOKE:
> > +			key_perm = KEY__REVOKE;
> > +			break;
> > +		case KEY_NEED_JOIN:
> > +		case KEY_NEED_PARENT_JOIN:
> > +			key_perm = KEY__JOIN;
> > +			break;
> > +		case KEY_NEED_CLEAR:
> > +			key_perm = KEY__CLEAR;
> > +			break;
> > +		default:
> > +			pr_err("BUG pcap = 1 entry_perm: 0x%04x\n",
> > perm);
> > +			BUG();
> > +			break;
> >   		}
> >   	} else {
> > -		key_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
> > -				   KEY_NEED_WRITE | KEY_NEED_SEARCH |
> > -				   KEY_NEED_LINK);
> > -		if (perm & KEY_NEED_PARENT_JOIN)
> > -			key_perm |= KEY_NEED_LINK;
> > -		if (perm & KEY_NEED_SETSEC)
> > -			key_perm |= OLD_KEY_NEED_SETATTR;
> > -		if (perm & KEY_NEED_INVAL)
> > -			key_perm |= KEY_NEED_SEARCH;
> > -		if (perm & KEY_NEED_REVOKE && !(perm &
> > OLD_KEY_NEED_SETATTR))
> > -			key_perm |= KEY_NEED_WRITE;
> > -		if (perm & KEY_NEED_JOIN)
> > -			key_perm |= KEY_NEED_SEARCH;
> > -		if (perm & KEY_NEED_CLEAR)
> > -			key_perm |= KEY_NEED_WRITE;
> > +		switch (perm) {
> > +		case KEY_NEED_VIEW:
> > +			key_perm = KEY_NEED_VIEW;
> > +			break;
> > +		case KEY_NEED_READ:
> > +			key_perm = KEY_NEED_READ;
> > +			break;
> > +		case KEY_NEED_WRITE:
> > +		case KEY_NEED_REVOKE:
> > +		case KEY_NEED_CLEAR:
> > +			key_perm = KEY_NEED_WRITE;
> > +			break;
> > +		case KEY_NEED_SEARCH:
> > +		case KEY_NEED_INVAL:
> > +		case KEY_NEED_JOIN:
> > +			key_perm = KEY_NEED_SEARCH;
> > +			break;
> > +		case KEY_NEED_LINK:
> > +		case KEY_NEED_PARENT_JOIN:
> > +			key_perm = KEY_NEED_LINK;
> > +			break;
> > +		case KEY_NEED_SETSEC:
> > +			key_perm = OLD_KEY_NEED_SETATTR;
> > +			break;
> > +		default:
> > +			pr_err("BUG pcap = 0 entry_perm: 0x%04x\n",
> > perm);
> > +			BUG();
> > +			break;
> > +		}
> >   	}
> >   
> >   	sid = cred_sid(cred);
> > @@ -6610,6 +6622,9 @@ static int selinux_key_permission(key_ref_t
> > key_ref,
> >   	key = key_ref_to_ptr(key_ref);
> >   	ksec = key->security;
> >   
> > +	pr_info("entry_perm: 0x%04x exit_perm: 0x%04x\n",
> > +	       perm, key_perm);
> > +
> >   	return avc_has_perm(&selinux_state,
> >   			    sid, ksec->sid, SECCLASS_KEY, key_perm,
> > NULL);
> >   }
> > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h
> > index cba9610b8..c0998e79d 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -79,8 +79,8 @@ enum {
> >   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
> >   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
> >   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> > -	POLICYDB_CAPABILITY_KEYPERMS,
> >   	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> > +	POLICYDB_CAPABILITY_KEYPERMS,
> >   	__POLICYDB_CAPABILITY_MAX
> >   };
> >   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > @@ -215,18 +215,18 @@ static inline bool
> > selinux_policycap_nnp_nosuid_transition(void)
> >   	return state-
> > >policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
> >   }
> >   
> > -static inline bool selinux_policycap_key_perms(void)
> > +static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
> >   {
> >   	struct selinux_state *state = &selinux_state;
> >   
> > -	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
> > +	return state-
> > >policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
> >   }
> >   
> > -static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
> > +static inline bool selinux_policycap_key_perms(void)
> >   {
> >   	struct selinux_state *state = &selinux_state;
> >   
> > -	return state-
> > >policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
> > +	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
> >   }
> >   
> >   int security_mls_enabled(struct selinux_state *state);
> > diff --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c
> > index d4a05f34d..6efc86c47 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -73,8 +73,8 @@ const char
> > *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
> >   	"always_check_network",
> >   	"cgroup_seclabel",
> >   	"nnp_nosuid_transition",
> > -	"key_perms",
> > -	"genfs_seclabel_symlinks"
> > +	"genfs_seclabel_symlinks",
> > +	"key_perms"
> >   };
> >   
> >   static struct selinux_ss selinux_ss;
> > 

