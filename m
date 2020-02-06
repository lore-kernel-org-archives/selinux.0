Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED312C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8EF20838
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="mtwug7cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFSHK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:07:10 -0500
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:18722 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727703AbgBFSHK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 13:07:10 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200206180706.FRYD28550.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 6 Feb 2020 18:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1581012426; 
        bh=pQ3JnOxlAdJ6zreblsxj5iBCvHa+em9++c2158MFUcs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=mtwug7cuWd07WU1FTOr2KNUEeN7BG5ZxAgFfDIsQonpZfyZEAtnwg7/FQhBipSWsfWGmN2KY6h/81o2+RNALbROBCxwA1o71qqpMcKlbLIl5HtFTJvjODvLAwjuVZq+XjRrtaS80FZyN7FnjLcROKFvl1bGsoUbjbP8ohGZ2ojFkGDDZ5dOIFHC7vR8zV8LkVFJbBdNhDGcEqP65XsiVDPS1iDi51P6naBm39Vubt63GCRRMJKMvzJDzSFLOiRpn0YdTBkUN61LtkVL8Kte+y969TAJOAAtoT5CbFxQMFjSuf9R9ANFIqgA1Ut0t8JlCn1h0IRoOCduX7UV8DQsmFQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.5.31]
X-OWM-Source-IP: 86.134.5.31 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrheefgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeekiedrudefgedrhedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrhedrfedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.5.31) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A254B004954E0; Thu, 6 Feb 2020 18:07:06 +0000
Message-ID: <2bb9ba3132c0cbb805d775ded43ac03145e085bb.camel@btinternet.com>
Subject: Re: security/selinux: Add support for new key permissions
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        dhowells@redhat.com
Cc:     paul@paul-moore.com
Date:   Thu, 06 Feb 2020 18:07:06 +0000
In-Reply-To: <9663ec06-1b8a-3051-a942-131bd5eead3c@tycho.nsa.gov>
References: <20200203141343.29133-1-richard_c_haines@btinternet.com>
         <c6fcea12-53c5-35b3-5ccd-58c5c15e48c1@tycho.nsa.gov>
         <5da8163ffe9b96660740f4ec64abf4a7c47553de.camel@btinternet.com>
         <9663ec06-1b8a-3051-a942-131bd5eead3c@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-02-06 at 11:03 -0500, Stephen Smalley wrote:
> On 2/3/20 10:42 AM, Richard Haines wrote:
> > On Mon, 2020-02-03 at 10:29 -0500, Stephen Smalley wrote:
> > > On 2/3/20 9:13 AM, Richard Haines wrote:
> > > > Add a new 'key_perms' policy capability and support for the
> > > > additional
> > > > key permissions: inval, revoke, join, clear
> > > 
> > > For future reference, subject line should have [PATCH] prefix;
> > > git
> > > send-email will do this for you automatically.  Also, the
> > > subsystem
> > > prefix would conventionally be "keys,selinux:" to indicates that
> > > it
> > > touches the keys and selinux subsystems, no need for "security/".
> > > 
> > > > Also fixes JOIN -> LINK permission translation when policy
> > > > capability 'keys_perms' = 0;
> > > > 
> > > > The current "setattr" perm name remains and is used for
> > > > KEY_NEED_SETSEC.
> > > > This gives the following permissions for the 'key' class:
> > > > 
> > > > create	Create a key or keyring.
> > > > view	View attributes.
> > > > read	Read contents.
> > > > write	Update or modify.
> > > > search	Search (keyring) or find (key).
> > > > link	Link a key into the keyring.
> > > > setattr	kernel < 5.X Change permissions on a keyring.
> > > > 	kernel >= 5.X Set owner, group, ACL.
> > > > inval	Invalidate key.
> > > > revoke	Revoke key.
> > > > join	Join keyring as session.
> > > > clear	Clear a keyring.
> > > > 
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > > ---
> > > > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > > > index a0c97d4d8251..65e1c0c3feb1 100644
> > > > --- a/security/keys/keyctl.c
> > > > +++ b/security/keys/keyctl.c
> > > > @@ -1592,7 +1592,8 @@ long keyctl_session_to_parent(void)
> > > >    	struct cred *cred;
> > > >    	int ret;
> > > >    
> > > > -	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING,
> > > > 0,
> > > > KEY_NEED_JOIN);
> > > > +	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING,
> > > > 0,
> > > > +				    KEY_NEED_PARENT_JOIN);
> > > 
> > > I'm unclear on how this works with the regular key permission
> > > checking
> > > (not SELinux).  There is no KEY_ACE_PARENT_JOIN permission AFAICT
> > > and
> > > the check would fail if the regular permissions were only
> > > KEY_ACE_JOIN.
> > > What we need is an additional flag that will get ignored by
> > > key_permission() for its permission checking but signify to
> > > SELinux
> > > that
> > > different handling is required here.
> > 
> > David will need to answer this.
> 
> Until this gets resolved, this patch must not go into mainline. 
> Otherwise we're looking at a potential userspace ABI issue when/if
> it 
> gets resolved.
> 
> > > > diff --git a/security/selinux/include/security.h
> > > > b/security/selinux/include/security.h
> > > > index ae840634e3c7..6b264b6d9d31 100644
> > > > --- a/security/selinux/include/security.h
> > > > +++ b/security/selinux/include/security.h
> > > > @@ -79,6 +79,7 @@ enum {
> > > >    	POLICYDB_CAPABILITY_ALWAYSNETWORK,
> > > >    	POLICYDB_CAPABILITY_CGROUPSECLABEL,
> > > >    	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> > > > +	POLICYDB_CAPABILITY_KEYPERMS,
> > > >    	__POLICYDB_CAPABILITY_MAX
> > > >    };
> > > >    #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX -
> > > > 1)
> > > > @@ -178,6 +179,13 @@ static inline bool
> > > > selinux_policycap_nnp_nosuid_transition(void)
> > > 
> > > This will collide with
> > > https://lore.kernel.org/selinux/20200128191656.111902-1-cgzones@googlemail.com/
> > > so we'll have to sort out which one goes first.
> 
> Already noted this elsewhere but for the sake of ensuring it is noted
> in 
> this thread too: the key_perms capability will need to be added
> after 
> the genfs_seclabel_symlinks capability since the latter is already 
> queued on selinux/next and the corresponding libsepol patch has been 
> merged upstream.

I'm still waiting for David to get back regarding the permission loop.

Anyway I'll update the patch as soon as I see
POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS in Paul's 
https://github.com/SELinuxProject/selinux-kernel/tree/next


