Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC142C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 14:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E1D2146E
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 14:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfBTOrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:47:47 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:50110 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBTOrr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Feb 2019 09:47:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id F2A0E2E0566
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 15:47:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id q5jAeh3UxKWq for <selinux@vger.kernel.org>;
        Wed, 20 Feb 2019 15:47:43 +0100 (CET)
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id D46102E0165
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 15:47:43 +0100 (CET)
Date:   Wed, 20 Feb 2019 15:47:42 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH] scripts/selinux: modernize mdp
Message-ID: <20190220144742.GB10412@brutus.lan>
References: <20190220123354.1589-1-dominick.grift@defensec.nl>
 <20190220140922.GA10412@brutus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220140922.GA10412@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 03:09:22PM +0100, Dominick Grift wrote:
> On Wed, Feb 20, 2019 at 01:33:54PM +0100, Dominick Grift wrote:
> > The MDP example no longer works on modern systems.
> > 
> > Add support for devtmpfs. This is required by login programs to relabel terminals.
> > Compile the policy with deny_unknown allow status to anticipate user space object managers in core components such as systemd.
> > Add default seusers mapping and failsafe context for the SELinux PAM module.
> 
> There are a couple more possible improvements that i have identified:
> 
> Fail gracefully if checkpolicy does not exist
> Run setfiles with -F. There *might* be one scenario where this might be a good idea. Where the filesystem is labeled with invalid contexts but where SELinux is disabled.
> In that case setfiles will reset, but only types (I suppose)

This also does not make sense to me:

	if [ -f /sbin/setfiles ]; then
	   SF="/usr/setfiles"

I think "-f /usr/setfiles" was meant here? I suppose `which setfiles` only searches "PATH", and so it wouldnt find /usr/setfiles.
But then, who uses /usr/setfiles?

> 
> > 
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > ---
> >  scripts/selinux/install_policy.sh | 6 +++++-
> >  scripts/selinux/mdp/mdp.c         | 1 +
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
> > index 0b86c47baf7d..334fcf8903d5 100755
> > --- a/scripts/selinux/install_policy.sh
> > +++ b/scripts/selinux/install_policy.sh
> > @@ -20,14 +20,18 @@ CP=`which checkpolicy`
> >  VERS=`$CP -V | awk '{print $1}'`
> >  
> >  ./mdp policy.conf file_contexts
> > -$CP -o policy.$VERS policy.conf
> > +$CP -U allow -o policy.$VERS policy.conf
> >  
> >  mkdir -p /etc/selinux/dummy/policy
> >  mkdir -p /etc/selinux/dummy/contexts/files
> >  
> > +echo "__default__:user_u" > /etc/selinux/dummy/seusers
> > +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
> > +
> >  cp file_contexts /etc/selinux/dummy/contexts/files
> >  cp dbus_contexts /etc/selinux/dummy/contexts
> >  cp policy.$VERS /etc/selinux/dummy/policy
> > +
> >  FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
> >  
> >  if [ ! -d /etc/selinux ]; then
> > diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> > index 073fe7537f6c..cf06d5694cbc 100644
> > --- a/scripts/selinux/mdp/mdp.c
> > +++ b/scripts/selinux/mdp/mdp.c
> > @@ -131,6 +131,7 @@ int main(int argc, char *argv[])
> >  
> >  	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
> >  	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> > +	fprintf(fout, "fs_use_trans devtmpfs user_u:base_r:base_t;\n");
> >  	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
> >  	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
> >  	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> > -- 
> > 2.21.0.rc1
> > 
> 
> -- 
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
