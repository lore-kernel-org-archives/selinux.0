Return-Path: <SRS0=e+Ck=VN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FDDC7618F
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B2820693
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 14:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGPONu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:13:50 -0400
Received: from mail.hallyn.com ([178.63.66.53]:44916 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733223AbfGPONu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 16 Jul 2019 10:13:50 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 10:13:48 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 2DE8D90B; Tue, 16 Jul 2019 09:03:50 -0500 (CDT)
Date:   Tue, 16 Jul 2019 09:03:50 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, keescook@chromium.org,
        serge@hallyn.com, john.johansen@canonical.com, mortonm@chromium.org
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
Message-ID: <20190716140349.GA4991@mail.hallyn.com>
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 12, 2019 at 12:54:02PM -0700, Casey Schaufler wrote:
> On 7/12/2019 11:25 AM, Stephen Smalley wrote:
> > On 7/12/19 1:58 PM, Casey Schaufler wrote:
> >> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
> >>> At present security_capable does not pass any object information
> >>> and therefore can neither audit the particular object nor take it
> >>> into account. Augment the security_capable interface to support
> >>> passing supplementary data. Use this facility initially to convey
> >>> the inode for capability checks relevant to inodes. This only
> >>> addresses capable_wrt_inode_uidgid calls; other capability checks
> >>> relevant to inodes will be addressed in subsequent changes. In the
> >>> future, this will be further extended to pass object information for
> >>> other capability checks such as the target task for CAP_KILL.
> >>
> >> This seems wrong to me. The capability system has nothing to do
> >> with objects. Passing object information through security_capable()
> >> may be convenient, but isn't relevant to the purpose of the interface.
> >> It appears that there are very few places where the object information
> >> is actually useful.
> >
> > A fair number of capabilities are checked upon some attempted object access (often right after comparing UIDs or other per-object state), and the particular object can be very helpful in both audit and in access control.  More below.
> 
> I'm not disagreeing with that. What I'm saying is that the capability
> check interface is not the right place to pass that information. The
> capability check has no use for the object information. I would much

I've had to argue this before while doing the namespaced file
capabilities implementation.  Perhaps this would be worth writing something
more formal about.  My main argument is, even if we want to claim that the
capabilities model is and should be object agnostic, the implementation
of user namespaces (currently) is such that the whole view of the user's
privilege must include information which is stored with the object.

There are various user namespaces.

The Linux capabilities ( :-) ) model is user namespaced.  It must be, in
order to be useful.  If we're going to use file capabilities in distros,
and distros are going to run in containers, then the capabilities must
be namespaced.  Otherwise, capabilities will not be used, and heck, should
just be dropped.

The only way to find out which user namespace has privilege over an inode
is to look at the inode.

Therefore, object information is needed.

Until now we've sneaked around that by doing things like capable_wrt_inode_uidgid()
and rootid_from_xattr().

Again, this crucial: IMO, you have to be able to use a distro the same way in a
container and not.  Either we support using capabilities in a user namespaced
container, or we drop capabilities support will not be used, and we may as
well drop the module.

Now, yes, if someone tries to extend this stuff to do pathname parsing, then we
might have to put our footsies down.  But we've been dancing around this for a
long time anyway, so passing the inode in so we can do better logging gets a +1
from me.

-serge
