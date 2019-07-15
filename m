Return-Path: <SRS0=0eMI=VM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B3BC76191
	for <selinux@archiver.kernel.org>; Mon, 15 Jul 2019 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AB3206B8
	for <selinux@archiver.kernel.org>; Mon, 15 Jul 2019 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfGOSmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbfGOSmV (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 15 Jul 2019 14:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5353630872F1;
        Mon, 15 Jul 2019 18:42:20 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CFCA4F676;
        Mon, 15 Jul 2019 18:42:12 +0000 (UTC)
Date:   Mon, 15 Jul 2019 14:42:09 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        luto@amacapital.net, linux-security-module@vger.kernel.org,
        "linux-audit@redhat.com" <linux-audit@redhat.com>, serge@hallyn.com
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
Message-ID: <20190715184209.j75kpav4tmmunejh@madcap2.tricolour.ca>
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <alpine.LRH.2.21.1907130347010.1509@namei.org>
 <3605eb1a-fb1c-8933-b1e1-a60e54fb1e1c@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3605eb1a-fb1c-8933-b1e1-a60e54fb1e1c@tycho.nsa.gov>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 15 Jul 2019 18:42:20 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019-07-12 14:02, Stephen Smalley wrote:
> On 7/12/19 1:50 PM, James Morris wrote:
> > On Fri, 12 Jul 2019, Nicholas Franck wrote:
> > 

This aggressive trimming dropped a bit of helpful context:

+++ b/security/lsm_audit.c
@@ -229,9 +229,26 @@ static void dump_common_audit_data(struct
audit_buffer *ab,
        case LSM_AUDIT_DATA_IPC:
                audit_log_format(ab, " key=%d ", a->u.ipc_id);
                break;
-       case LSM_AUDIT_DATA_CAP:
-               audit_log_format(ab, " capability=%d ", a->u.cap);

> > > +	case LSM_AUDIT_DATA_CAP: {
> > > +		const struct inode *inode;
> > > +
> > > +		if (a->u.cap_struct.cad) {
> > > +			switch (a->u.cap_struct.cad->type) {
> > > +			case CAP_AUX_DATA_INODE: {
> > > +				inode = a->u.cap_struct.cad->u.inode;
> > > +
> > > +				audit_log_format(ab, " dev=");
> > > +				audit_log_untrustedstring(ab,
> > > +					inode->i_sb->s_id);
> > > +				audit_log_format(ab, " ino=%lu",
> > > +					inode->i_ino);
> > > +				break;
> > > +			}
> > > +			}
> > > +		}
> > > +		audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
> > >   		break;

+       }
        case LSM_AUDIT_DATA_PATH: {
                struct inode *inode;

> > 
> > Will this break any existing userspace log parsers?
> 
> I'm hoping not given that we are only adding auxiliary fields and those are
> already defined for other AVC audit messages.  ausearch appeared to work
> fine.  Added the linux-audit mailing list to the cc line to get their view.

Generally, additional or optional fields should only be added after
existing ones.  Also, generally, fields should not be optional, but this
is tricky since it gobbles network and cpu bandwidth and disk space and
there are lots of precedents to contradict this.


- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
