Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA0C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184542146E
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfBTUZV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:25:21 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:50428 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTUZV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Feb 2019 15:25:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id 7E2662E0566;
        Wed, 20 Feb 2019 21:25:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hU3ktNEeh-9h; Wed, 20 Feb 2019 21:25:17 +0100 (CET)
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 67BB72E0165;
        Wed, 20 Feb 2019 21:25:17 +0100 (CET)
Date:   Wed, 20 Feb 2019 21:25:16 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: modernize mdp
Message-ID: <20190220202516.GC28292@brutus.lan>
References: <20190220123354.1589-1-dominick.grift@defensec.nl>
 <20190220153408.1857-1-dominick.grift@defensec.nl>
 <CAB9W1A1DVgp7buZZQ1=Gpjo7=AnbEa6DPh1q145bzRcr=co8Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9W1A1DVgp7buZZQ1=Gpjo7=AnbEa6DPh1q145bzRcr=co8Dw@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 02:34:16PM -0500, Stephen Smalley wrote:
> On Wed, Feb 20, 2019 at 10:34 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > The MDP example no longer works on modern systems.
> >
> > Add support for devtmpfs. This is required by login programs to relabel terminals.
> > Compile the policy with deny_unknown allow status to anticipate user space object managers in core components such as systemd.
> > Add default seusers mapping and failsafe context for the SELinux PAM module.
> >
> > V2:
> > Fix existing file test for setfiles.
> > Add a file test for checkpolicy similar to the test for setfiles for consistency.
> > Execute setfiles with -F to ensure that customizables are relabeled as well in scenarios where filesystems are labeled but where SELinux is disabled.
> >
> > V3: Fixes file test that was introduced in V2.
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > ---
> >  scripts/selinux/install_policy.sh | 21 ++++++++++++++++-----
> >  scripts/selinux/mdp/mdp.c         |  1 +
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
> > index 0b86c47baf7d..e32f333f14cc 100755
> > --- a/scripts/selinux/install_policy.sh
> > +++ b/scripts/selinux/install_policy.sh
> > @@ -6,7 +6,7 @@ if [ `id -u` -ne 0 ]; then
> >  fi
> >  SF=`which setfiles`
> >  if [ $? -eq 1 ]; then
> > -       if [ -f /sbin/setfiles ]; then
> > +       if [ -f /usr/setfiles ]; then
> >                 SF="/usr/setfiles"
> 
> I don't believe we've ever installed setfiles anywhere other than
> /sbin/setfile or /usr/sbin/setfiles so no other locations should be
> used.  Maybe just drop the inner if statement entirely.
> 
> >         else
> >                 echo "no selinux tools installed: setfiles"
> > @@ -17,14 +17,25 @@ fi
> >  cd mdp
> >
> >  CP=`which checkpolicy`
> > +if [ $? -eq 1 ]; then
> > +       if [ -f /usr/checkpolicy ]; then
> > +               CP="/usr/checkpolicy"
> 
> Similarly for /usr/bin/checkpolicy or /bin/checkpolicy.
> 
> > +       else
> > +               echo "no selinux tools installed: checkpolicy"
> > +               exit 1
> > +       fi
> > +fi
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
> > @@ -55,15 +66,15 @@ else
> >  fi
> >
> >  cd /etc/selinux/dummy/contexts/files
> > -$SF file_contexts /
> > +$SF -F file_contexts /
> >
> >  mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
> > -$SF file_contexts $mounts
> > +$SF -F file_contexts $mounts
> >
> >
> >  dodev=`cat /proc/$$/mounts | grep "/dev "`
> >  if [ "eq$dodev" != "eq" ]; then
> >         mount --move /dev /mnt
> 
> I recall seeing errors from mount when running this script about
> invalid usage of mount --move?

Yes but we may want this for (backwards) compatibility? I suspect that this might work in some scenario's (just not ours)

> 
> > -       $SF file_contexts /dev
> > +       $SF -F file_contexts /dev
> >         mount --move /mnt /dev
> >  fi
> > diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> > index 073fe7537f6c..cf06d5694cbc 100644
> > --- a/scripts/selinux/mdp/mdp.c
> > +++ b/scripts/selinux/mdp/mdp.c
> > @@ -131,6 +131,7 @@ int main(int argc, char *argv[])
> >
> >         fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
> >         fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> > +       fprintf(fout, "fs_use_trans devtmpfs user_u:base_r:base_t;\n");
> 
> This will conflict with my patch but probably your patch should be
> applied first since it fixes current usage of mdp, and then mine can
> be re-based and introduce the MLS support (which hopefully can now be
> tested on Fedora). Ideally we'd add fs_use* and genfscon statements
> for all filesystems supported by the kernel but that can come later.

Probably yes, but you can also just take my changes and add them to your patch.

BTW: we also might want to use object_r instead of base_r for object contexts for consistency?

> 
> >         fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
> >         fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
> >         fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> > --
> > 2.21.0.rc1
> >

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
