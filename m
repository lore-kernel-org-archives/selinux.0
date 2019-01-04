Return-Path: <SRS0=zFQt=PM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F76C43387
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 15:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496DB2087F
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 15:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kBhviom1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfADPJb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:09:31 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:18464 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfADPJb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Jan 2019 10:09:31 -0500
X-EEMSG-check-017: 630616703|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,439,1539648000"; 
   d="scan'208";a="630616703"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Jan 2019 15:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1546614569; x=1578150569;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=r/X2Pk84Rl0wJfwydMZPKrxD+4G2oPKorWAgEw+S16g=;
  b=kBhviom1VJYhz0Do9relQKIQgQ7xm1ZYYBoo0f+LcLL0cj3aIgdzwjoT
   WH9HtwtS7odFujifY0cW47MwtNsvwaN/U5beMu2bvIDZk4MF4JoTjIBI2
   8YLikQMTHipK7QtdBGbzTPehLsQjsRVYtk1bs+AXDDWm+8ktEkRCBitkt
   yScFv9mJZYcbhgJ9j867fs00GN9sJEvBGjt9T4Qk+HwWNqEP6nJdf0zVc
   W7fCPBWRpgcNytxgQwvOZKxU6vNUJaiGzI4uJs0ymfJRCdC8n9Ax/vFwg
   woxJdTB8J3gAO/3WMtNk1EjHmXARqCL/aeAECM55F8kGyHO/0RM2Ap+2t
   w==;
X-IronPort-AV: E=Sophos;i="5.56,439,1539648000"; 
   d="scan'208";a="19217157"
IronPort-PHdr: =?us-ascii?q?9a23=3ACjp0bRCwhmz4oqTZ0bBRUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX7rsbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEvYNMeNeooLgpVUBsAG+CBGvCu3yyjFGmHH40q800+?=
 =?us-ascii?q?s9Hw7J0wMuEskSsHnXttj5KLseXPq3waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW25ouCcmyr0GpJ?=
 =?us-ascii?q?60ZzIGx4ggxx7abfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI0rOL+3jDfqkn1StkCtkx/DBPrH7BJXNNWLMnK3ufb?=
 =?us-ascii?q?Z69U5Q0BAzwsxH55JIFrEBJ+r+WlTvu9zcDx85NRG0wun8BdVj2YMRR3iPDr?=
 =?us-ascii?q?WaMKzMq1+I4PwgI+2WaI8Sojb9JOAv5+Tygn8hhV8dYa6p0IMMZ3C5EfRmJE?=
 =?us-ascii?q?OZbGHxjdgfCmgKvxAxTOrwhF2FSz5TaCX6Y6VpwjgmEo+gEc/pR4+qhqKA2C?=
 =?us-ascii?q?O2VslcZ29BDHiAHH3pfoPCXO0DPmbaOcJlkzoZRZC/RII7kxKjrgn3z/xgNO?=
 =?us-ascii?q?WH1DcfsMfYyNVt5+DV3So3/DhwAtXVh3qBVEloj2gIQHkwx6k5rktjnATQmZ?=
 =?us-ascii?q?NkiuBVQIQAr8hCVR03YNuFlrR3?=
X-IPAS-Result: =?us-ascii?q?A2AhAADUdi9c/wHyM5BjGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFaKWZPMyeDf5QBTAEBAQEBAQaBNXyILI4/gXswCAGDekYCggAiNgcNA?=
 =?us-ascii?q?QMBAQEBAQECAWwcDII6KQGCZgEBAQEDIwQLAVYLDgcDAgImAgJXBgESgmNAg?=
 =?us-ascii?q?XQND6ZYfDOELQGBFIRgBYELizQXeIEHgRGCXQcugVSBSgKEaYJXApBmkHEJh?=
 =?us-ascii?q?xOKWRiRaolghQONHwcqgVYrCAIYCCEPO4JshgiKcSEDMIEFAQGJYgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Jan 2019 15:09:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x04F99Qd001442;
        Fri, 4 Jan 2019 10:09:09 -0500
Message-ID: <91136ae0462be76415705cb8a014d2a49e59aa85.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Always set errno to 0 before calling
 getpwent()
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Laurent Bigonville <bigon@debian.org>, selinux@vger.kernel.org
Date:   Fri, 04 Jan 2019 10:11:22 -0500
In-Reply-To: <e2da0c12-9e7d-089f-d45a-fba523e6e04f@debian.org>
References: <20190102134639.30515-1-bigon@debian.org>
         <e2da0c12-9e7d-089f-d45a-fba523e6e04f@debian.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-01-02 at 15:30 +0100, Laurent Bigonville wrote:
> Le 2/01/19 à 14:46, Laurent Bigonville a écrit :
> > From: Laurent Bigonville <bigon@bigon.be>
> > 
> > The manpage explicitly states that:
> > 
> >    The  getpwent()  function  returns a pointer to a passwd
> > structure, or
> >    NULL if there are no more entries or an error occurred.  If an
> > error
> >    occurs, errno is set appropriately.  If one wants to check errno
> > after
> >    the call, it should be set to zero before the call.
> > 
> > Without this, genhomedircon can wrongly return the following:
> >    libsemanage.get_home_dirs: Error while fetching
> > users.  Returning list so far.
> > 
> > https://github.com/SELinuxProject/selinux/issues/121
> > 
> > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> > ---
> >   libsemanage/src/genhomedircon.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/libsemanage/src/genhomedircon.c
> > b/libsemanage/src/genhomedircon.c
> > index 3e61b510..591941fb 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -361,7 +361,11 @@ static semanage_list_t
> > *get_home_dirs(genhomedircon_settings_t * s)
> >   
> >   	errno = 0;
> >   	setpwent();
> > -	while ((pwbuf = getpwent()) != NULL) {
> > +	while (1) {
> > +		errno = 0;
> > +		pwbuf = getpwent();
> > +		if (pwbuf == NULL)
> > +			break;
> >   		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
> >   			continue;
> >   		if (!semanage_list_find(shells, pwbuf->pw_shell))
> > @@ -403,7 +407,6 @@ static semanage_list_t
> > *get_home_dirs(genhomedircon_settings_t * s)
> >   		}
> >   		free(path);
> >   		path = NULL;
> > -		errno = 0;
> 
> Actually I'm wondering if this shouldn't stay there

Why?

> 
> >   	}
> >   
> >   	if (errno) {
> > @@ -1101,7 +1104,11 @@ static int
> > get_group_users(genhomedircon_settings_t * s,
> >   	}
> >   
> >   	setpwent();
> > -	while ((pw = getpwent()) != NULL) {
> > +	while (1) {
> > +		errno = 0;
> > +		pw = getpwent();
> > +		if (pw == NULL)
> > +			break;
> >   		// skip users who also have this group as their
> >   		// primary group
> >   		if (lfind(pw->pw_name, group->gr_mem, &nmembers,

