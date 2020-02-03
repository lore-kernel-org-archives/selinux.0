Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B4C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 15:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5AC20CC7
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="KA7hhgwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBCPmR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:42:17 -0500
Received: from mailomta31-sa.btinternet.com ([213.120.69.37]:16040 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727308AbgBCPmR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 10:42:17 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20200203154214.RKWM26034.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Mon, 3 Feb 2020 15:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580744534; 
        bh=yZTRVlELHdfbMnNe1e5RDx1fLGdHVWJxXizzyjzjoe0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=KA7hhgwHHW9PecWk0QTArv66gZPOa1lC0do4QSXoO3pB8RfhpaX1RfY1QurHTDtzmlKO0IdAFa19U/WOF951HFrfEdnkHYX1d91wRek4C3crKta+n3Www5c+GboBfPCN/28PsmC7b10ngxTbzg3K5uPVmMI7PUS3xHrxkSv+unohpMSg/8bDI1Ehz1mLMBZNNN87M8NK6heoi/6ILGHfTsHDzLwtSEqh2h1lf8GVsvx6H5Ty9Ddh+YyWKLRr4KAvlOFHEpOFuxRAqHJvNo9cPKHQp1IGWQG7w56h7nS8NS158WqcQ/Bz1221T748XvYP3sp5IpL/ZtAiDP5VUMOAxw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.51.79.157]
X-OWM-Source-IP: 31.51.79.157 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrhedurdejledrudehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrjeelrdduheejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.79.157) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD17A8AE31; Mon, 3 Feb 2020 15:42:14 +0000
Message-ID: <5da8163ffe9b96660740f4ec64abf4a7c47553de.camel@btinternet.com>
Subject: Re: security/selinux: Add support for new key permissions
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        dhowells@redhat.com
Cc:     paul@paul-moore.com
Date:   Mon, 03 Feb 2020 15:42:13 +0000
In-Reply-To: <c6fcea12-53c5-35b3-5ccd-58c5c15e48c1@tycho.nsa.gov>
References: <20200203141343.29133-1-richard_c_haines@btinternet.com>
         <c6fcea12-53c5-35b3-5ccd-58c5c15e48c1@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-02-03 at 10:29 -0500, Stephen Smalley wrote:
> On 2/3/20 9:13 AM, Richard Haines wrote:
> > Add a new 'key_perms' policy capability and support for the
> > additional
> > key permissions: inval, revoke, join, clear
> 
> For future reference, subject line should have [PATCH] prefix; git 
> send-email will do this for you automatically.  Also, the subsystem 
> prefix would conventionally be "keys,selinux:" to indicates that it 
> touches the keys and selinux subsystems, no need for "security/".
> 
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
> > setattr	kernel < 5.X Change permissions on a keyring.
> > 	kernel >= 5.X Set owner, group, ACL.
> > inval	Invalidate key.
> > revoke	Revoke key.
> > join	Join keyring as session.
> > clear	Clear a keyring.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> >   include/linux/key.h                 |  3 +-
> >   security/keys/keyctl.c              |  3 +-
> >   security/selinux/hooks.c            | 73
> > ++++++++++++++++++++++++++++++-------
> >   security/selinux/include/classmap.h |  2 +-
> >   security/selinux/include/security.h |  8 ++++
> >   security/selinux/ss/services.c      |  3 +-
> >   6 files changed, 74 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/linux/key.h b/include/linux/key.h
> > index 24c69457783f..ddfc0709569b 100644
> > --- a/include/linux/key.h
> > +++ b/include/linux/key.h
> > @@ -435,7 +435,8 @@ extern void key_free_user_ns(struct
> > user_namespace *);
> >   #define	KEY_NEED_REVOKE	0x080	/* Require permission to
> > revoke key */
> >   #define	KEY_NEED_JOIN	0x100	/* Require permission to
> > join keyring as session */
> >   #define	KEY_NEED_CLEAR	0x200	/* Require permission to
> > clear a keyring */
> > -#define KEY_NEED_ALL	0x3ff
> > +#define KEY_NEED_PARENT_JOIN 0x400 /* Require permission to impose
> > keyring on parent */
> > +#define KEY_NEED_ALL	0x7ff
> >   
> >   #define OLD_KEY_NEED_SETATTR 0x20 /* Used to be Require
> > permission to change attributes */
> >   
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index a0c97d4d8251..65e1c0c3feb1 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -1592,7 +1592,8 @@ long keyctl_session_to_parent(void)
> >   	struct cred *cred;
> >   	int ret;
> >   
> > -	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0,
> > KEY_NEED_JOIN);
> > +	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0,
> > +				    KEY_NEED_PARENT_JOIN);
> 
> I'm unclear on how this works with the regular key permission
> checking 
> (not SELinux).  There is no KEY_ACE_PARENT_JOIN permission AFAICT
> and 
> the check would fail if the regular permissions were only
> KEY_ACE_JOIN. 
> What we need is an additional flag that will get ignored by 
> key_permission() for its permission checking but signify to SELinux
> that 
> different handling is required here.

David will need to answer this.
> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index c8db5235b01f..a499bd7d9777 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6565,18 +6566,62 @@ static int selinux_key_permission(key_ref_t
> > key_ref,
> >   	if (perm == 0)
> >   		return 0;
> >   
> > -	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
> > KEY_NEED_WRITE |
> > -				KEY_NEED_SEARCH | KEY_NEED_LINK);
> > -	if (perm & KEY_NEED_SETSEC)
> > -		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
> > -	if (perm & KEY_NEED_INVAL)
> > -		oldstyle_perm |= KEY_NEED_SEARCH;
> > -	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
> > -		oldstyle_perm |= KEY_NEED_WRITE;
> > -	if (perm & KEY_NEED_JOIN)
> > -		oldstyle_perm |= KEY_NEED_SEARCH;
> > -	if (perm & KEY_NEED_CLEAR)
> > -		oldstyle_perm |= KEY_NEED_WRITE;
> > +	if (selinux_policycap_key_perms()) {
> > +		while (count) {
> > +			switch_perm = bit & perm;
> > +			switch (switch_perm) {
> > +			case KEY_NEED_VIEW:
> > +				key_perm |= KEY__VIEW;
> > +				break;
> > +			case KEY_NEED_READ:
> > +				key_perm |= KEY__READ;
> > +				break;
> > +			case KEY_NEED_WRITE:
> > +				key_perm |= KEY__WRITE;
> > +				break;
> > +			case KEY_NEED_SEARCH:
> > +				key_perm |= KEY__SEARCH;
> > +				break;
> > +			case KEY_NEED_LINK:
> > +				key_perm |= KEY__LINK;
> > +				break;
> > +			case KEY_NEED_SETSEC:
> > +				key_perm |= KEY__SETATTR;
> > +				break;
> > +			case KEY_NEED_INVAL:
> > +				key_perm |= KEY__INVAL;
> > +				break;
> > +			case KEY_NEED_REVOKE:
> > +				key_perm |= KEY__REVOKE;
> > +				break;
> > +			case KEY_NEED_JOIN:
> > +			case KEY_NEED_PARENT_JOIN:
> > +				key_perm |= KEY__JOIN;
> > +				break;
> > +			case KEY_NEED_CLEAR:
> > +				key_perm |= KEY__CLEAR;
> > +				break;
> > +			}
> > +			bit <<= 1;
> > +			count >>= 1;
> > +		}
> 
> So I assume then that it is unreasonable to have key_permission()
> limit 
> its inputs to single-permission-at-a-time checks and therefore we
> have 
> to permit multiple permissions?  David? If not, is there any concern 
> about the performance overhead of this loop and if so should we
> optimize 
> for the common case of a single permission?

I have a single perm patch as well if that is required

> 
> > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h
> > index ae840634e3c7..6b264b6d9d31 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -79,6 +79,7 @@ enum {
> >   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
> >   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
> >   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> > +	POLICYDB_CAPABILITY_KEYPERMS,
> >   	__POLICYDB_CAPABILITY_MAX
> >   };
> >   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > @@ -178,6 +179,13 @@ static inline bool
> > selinux_policycap_nnp_nosuid_transition(void)
> 
> This will collide with 
> https://lore.kernel.org/selinux/20200128191656.111902-1-cgzones@googlemail.com/ 
> so we'll have to sort out which one goes first.

