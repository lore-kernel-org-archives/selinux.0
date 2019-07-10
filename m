Return-Path: <SRS0=qgEa=VH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B32C74A35
	for <selinux@archiver.kernel.org>; Wed, 10 Jul 2019 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D492087F
	for <selinux@archiver.kernel.org>; Wed, 10 Jul 2019 17:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfGJR07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:26:59 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:57878 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727197AbfGJR07 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jul 2019 13:26:59 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 13:26:58 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id CD51818014B82;
        Wed, 10 Jul 2019 17:19:23 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 39B65181D3419;
        Wed, 10 Jul 2019 17:19:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need92_16e176f97c651
X-Filterd-Recvd-Size: 2181
Received: from XPS-9350 (unknown [172.56.44.31])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 17:19:16 +0000 (UTC)
Message-ID: <6ce2ce60b2435940bc8dfa07fa2553c4524d2db5.camel@perches.com>
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jul 2019 10:18:46 -0700
In-Reply-To: <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
         <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
         <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-07-10 at 09:49 -0700, Randy Dunlap wrote:
> On 7/10/19 9:38 AM, Casey Schaufler wrote:
> > On 7/10/2019 6:34 AM, Aaron Goidel wrote:
> > > @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
> > >  	return -EACCES;
> > >  }
> > >  
> > > +static int selinux_inode_notify(struct inode *inode, u64 mask)
> > > +{
> > > +	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
> > 
> > We don't use // comments in the Linux kernel.
> > 
> 
> I thought that we had recently moved into the 21st century on that issue,
> but I don't see it mentioned in coding-style.rst.  Maybe we need a Doc update.
> 
> checkpatch allows C99 comments by default.
> Joe, do you recall about this?

My recollection is it was something I thought was
just simple and useful so I added it to checkpatch
without going through the negative of the nominal
approvals required by modifying CodingStyle.



