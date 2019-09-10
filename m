Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CAAC49ED9
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B5217D7
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svi8xXmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392885AbfIJPWh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:22:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33677 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730875AbfIJPWh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 11:22:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id o9so17544062edq.0
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2019 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1ea7Eq1MTREwiC4e3Rk08fe7D9TwJO2Cho4TRcmWjM=;
        b=Svi8xXmBdePtTmGUhNp3ti0NrH+9jFjFcx1/yAw3KUkyWjzHgW70im5tyX4Ou37K6k
         kZxZ3pTfmFY2LjPE9F9ZKHisObBq51QDke0pj/tyH/8wNc+oLnWIi0mAxI6qhsH5Yc0m
         q0ABOoC4cwhg+wOD822xdq5NoMR0P2xMZiBISo1FR4T4SA19m/QVpdFYrnA20znnCkFF
         fBIh+XVLR8YXbDNT60/GUM5F6ysUHmjOgNjBemnjRhDIcN3zJcm/3P23cys6juxY2/uc
         eXzgCb1C25s4rIRr6AH/1MDE+dPvG5JkmxofnC3q127+rAJcjvTlaXT1/eKlSv7KCqfV
         yfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=j1ea7Eq1MTREwiC4e3Rk08fe7D9TwJO2Cho4TRcmWjM=;
        b=M7zFkCeeDzi8UbbG8lP4uVck+tJFT+ZfO+PdM1lQVyrs/hd/+qYioMIqbPeRyQ15ea
         2ZIVXukz/oJ/Qxgm5d6WWsAp7x/103HHdColA6YVvHj0Xg+7xu6id4glB45OVT26pycZ
         gbDWhBu8n46+rriQ+eIIDMgTbB4iFK2ADxlV3by9WVk7fcsTBeBiy0r1ZlKsWl9UO3G6
         qPE4E2ub9L8eJ33IqlxdHfC5ultNRZoBvZJrP6zNRmsRtfxIlmkoxNutkfmHlG4hmIw3
         k3F9xGsOy3rD2Wcdiirz+RICH+OC9nSqbybjttNSRNQHdqxTV1K/f+748SmNGp0BhZMj
         1GWA==
X-Gm-Message-State: APjAAAXsufjpBqhbZIzmekDBCYr7o3ZtFn/0SY58Pr0EJR+roP9XY65P
        lkwpjPDHJ8XZq4TFiTrRAq8=
X-Google-Smtp-Source: APXvYqx2+N890LoWKPTG6NfSiX2R8JAS3fBltzJcPYvwolldxRqq14yaLxq6hmFJgrrWIq4BVDk03Q==
X-Received: by 2002:a05:6402:350:: with SMTP id r16mr3635559edw.296.1568128954015;
        Tue, 10 Sep 2019 08:22:34 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id ot4sm2157526ejb.43.2019.09.10.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:22:33 -0700 (PDT)
Date:   Tue, 10 Sep 2019 17:22:31 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org
Subject: Re: [Non-DoD Source] Re: [PATCH] selinux-testsuite: add tests for
 fsnotify
Message-ID: <20190910152231.GA963906@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org
References: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
 <20190910055926.GA963995@brutus.lan>
 <3e584347-f97f-eb00-3291-2ce666e50918@tycho.nsa.gov>
 <20190910141517.GA1058184@brutus.lan>
 <d6636549-d91c-d4d2-4478-9aa3c8e023df@tycho.nsa.gov>
 <76c7a2f2-ccc3-46bf-bf1c-ef11a039536e@tycho.nsa.gov>
 <b9cdbda9-af04-ddc5-6e17-040c74da7518@tycho.nsa.gov>
 <44cb5cbc-1811-3cf1-f910-ec04e65bdbce@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <44cb5cbc-1811-3cf1-f910-ec04e65bdbce@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 11:02:16AM -0400, Stephen Smalley wrote:
> On 9/10/19 10:59 AM, Stephen Smalley wrote:
> > On 9/10/19 10:54 AM, Stephen Smalley wrote:
> > > On 9/10/19 10:40 AM, Stephen Smalley wrote:
> > > > On 9/10/19 10:15 AM, Dominick Grift wrote:
> > > > > On Tue, Sep 10, 2019 at 08:26:57AM -0400, Stephen Smalley wrote:
> > > > > > On 9/10/19 1:59 AM, Dominick Grift wrote:
> > > > > > > On Wed, Jul 10, 2019 at 09:39:17AM -0400, Aaron Goidel wrote:
> > > > > > > > Added a suite to test permissions for setting
> > > > > > > > inotify and fanotify watches
> > > > > > > > on filesystem objects. Tests watch,
> > > > > > > > watch_with_perm, and watch_reads permissions.
> > > > > > >=20
> > > > > > > Ive also "tested" the fsnotify patch. And my tests
> > > > > > > indicate that this might cause issues:
> > > > > > >=20
> > > > > > > I added the access vectors to my policy, but on
> > > > > > > older systems (debian 10) cron fails to start
> > > > > > > cron needs the "entrypoint" permission on
> > > > > > > /etc/crontab but it looks like appending the "watch"
> > > > > > > access vectors to common-file disrupted the ordering
> > > > > > > The result is that now i have to allow cron to
> > > > > > > "watch_read" /etc/crontab even though the neither
> > > > > > > kernel nor selinux user space are aware of the
> > > > > > > fsnotify access vectors
> > > > > > > It seems the cron selinux code got confused and now
> > > > > > > thinks watch_read is entrypoint (its using selinux
> > > > > > > code to determine whether it can manually transition
> > > > > > > to cronjob domains on crontabs)
> > > > > > >=20
> > > > > > > I am hoping this issue with resolve itself on
> > > > > > > systems with kernels and user spaces that suppose
> > > > > > > fsnotify.
> > > > > > > However unless i am overlooking something this is
> > > > > > > still likely to disrupt compatibility
> > > > > >=20
> > > > > > So, IIUC, the issue is that:
> > > > > > a) older cron was directly using the fixed
> > > > > > FILE__ENTRYPOINT definition from
> > > > > > libselinux in a security_compute_av() call rather than
> > > > > > dynamically looking
> > > > > > up entrypoint permission,
> > > > > > b) the value of the file entrypoint permission in policy
> > > > > > has changed because
> > > > > > you updated your policy and chose to place the watch*
> > > > > > permissions in the
> > > > > > common file definition to match the kernel.
> > > > > >=20
> > > > > > Note that you could have instead sprinkled copies of the
> > > > > > watch* permissions
> > > > > > across all of the individual file/dir/*_file classes and
> > > > > > placed them at the
> > > > > > end of the classes if you wanted to avoid this
> > > > > > compatibility issue. The
> > > > > > policy and kernel definitions no longer need to be
> > > > > > identical; the kernel
> > > > > > will dynamically map between them for its own permission checks.
> > > > > >=20
> > > > > > Also, this should have already been broken for you when
> > > > > > map permission was
> > > > > > added, which would have shown up as execute_no_trans
> > > > > > being checked instead
> > > > > > of entrypoint.=A0 This was already filed as a bug on cron
> > > > > > in debian here:
> > > > > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D924716
> > > > > >=20
> > > > > > So, wrt compatibility, IIUC:
> > > > > > - the kernel change does not break compatibility for old policy=
 + old
> > > > > > userspace,
> > > > > > - new policy can choose to add the new permissions in a
> > > > > > backward-compatible
> > > > > > manner if desired, although refpolicy has already chosen
> > > > > > not to do this for
> > > > > > map permission,
> > > > > > - the offending code in cron produces build warnings
> > > > > > that were introduced in
> > > > > > 2014 in libselinux to update their code to use the dynamic clas=
s/perm
> > > > > > mapping support, which would resolve the issue.
> > > > >=20
> > > > > this does not work (cron[8934]: ((null)) ENTRYPOINT FAILED): http=
s://defensec.nl/gitweb/dssp2.git/commitdiff/914b1d5366922f92435cba780519c5d=
2bb9f4f7d
> > > > >=20
> > > > >=20
> > > > > [kcinimod@brutus dssp2 (master=3D)]$ seinfo policy.31 -x
> > > > > --common common_file
> > > > >=20
> > > > > Commons: 1
> > > > > =A0=A0=A0 common common_file
> > > > > {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 append
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 lock
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 mounton
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 unlink
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 read
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 create
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 quotaon
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 execute
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 setattr
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 map
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 relabelto
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 rename
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 link
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 ioctl
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 getattr
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 relabelfrom
> > > > > }
> > > > > [kcinimod@brutus dssp2 (master=3D)]$ seinfo policy.31 -xcfile
> > > > >=20
> > > > > Classes: 1
> > > > > =A0=A0=A0 class file
> > > > > inherits common_file
> > > > > {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 execmod
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 watch
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 write
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 watch_reads
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 execute_no_trans
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 watch_mount
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 watch_with_perm
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 open
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 watch_sb
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 audit_access
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 entrypoint
> > > > > }
> > > >=20
> > > > If you want to preserve compatibility with userspace using fixed
> > > > definitions of FILE__ENTRYPOINT, then you have to insert any new
> > > > file permissions after the current entrypoint permission in the
> > > > class file. So watch and friends have to go after it, not before
> > > > it.
> > > >=20
> > > > Also, since the kernel always uses FILE__WATCH* in the check
> > > > code rather than distinguishing by class, the watch* permissions
> > > > need to be at the same offset in all of the file classes.=A0 The
> > > > same is true of the other file permissions.=A0 It looks like you
> > > > may have other permissions out of sync across the file classes
> > > > e.g. execmod, open, audit_access, that need to be aligned or the
> > > > kernel could check the wrong permission.
> > >=20
> > > Sorry, the last para isn't correct - it should get mapped correctly
> > > per class.=A0 But you do need to add the permissions after entrypoint
> > > in the file class to avoid displacing its value.
> >=20
> > Also, it looks like your file class permission order differs in other
> > incompatible ways. If you want it to be compatible with the deprecated
> > libselinux headers, the requisite order would be:
> > class file
> > inherits common_file
> > {
> >  =A0=A0=A0=A0execute_no_trans
> >  =A0=A0=A0=A0entrypoint
> >  =A0=A0=A0=A0execmod
> >  =A0=A0=A0=A0open
> >  =A0=A0=A0=A0audit_access
> >  =A0=A0=A0=A0map
>=20
> Sorry, insert watch* permissions here.

I applied brute force:

the map permission can be part of common_file just fine.
the audit_access av (which was clearly introduced after entrypoint can prec=
ede entrypoint just fine.

The problem is the prescence of the fsnotify access vector in general. Movi=
ng them out of common_file and after entrypoint does not make a difference.
As soon as I remove the fsnotify av's things start to work.

In other words. besides the precensce of the fsnotify access vectors everyt=
hing (seemingly) is in order
Now for me the question remains: will this issue automatically resolve itse=
lf as soon as userspace and kernel support the fsnotify av

>=20
> > }
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> > > > > > > > ---
> > > > > > > > =A0=A0 policy/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 4 ++
> > > > > > > > =A0=A0 policy/test_notify.te=A0=A0=A0=A0=A0=A0=A0 |=A0 74 +=
+++++++++++++++++++++++
> > > > > > > > =A0=A0 tests/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 4 ++
> > > > > > > > =A0=A0 tests/notify/Makefile=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 5=
 ++
> > > > > > > > =A0=A0 tests/notify/test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
 101
> > > > > > > > +++++++++++++++++++++++++++++++++
> > > > > > > > =A0=A0 tests/notify/test_fanotify.c | 105
> > > > > > > > +++++++++++++++++++++++++++++++++++
> > > > > > > > =A0=A0 tests/notify/test_inotify.c=A0 |=A0 43 ++++++++++++++
> > > > > > > > =A0=A0 7 files changed, 336 insertions(+)
> > > > > > > > =A0=A0 create mode 100644 policy/test_notify.te
> > > > > > > > =A0=A0 create mode 100644 tests/notify/Makefile
> > > > > > > > =A0=A0 create mode 100755 tests/notify/test
> > > > > > > > =A0=A0 create mode 100644 tests/notify/test_fanotify.c
> > > > > > > > =A0=A0 create mode 100644 tests/notify/test_inotify.c
> > > > > > > >=20
> > > > > > > > diff --git a/policy/Makefile b/policy/Makefile
> > > > > > > > index 305b572..65f88c5 100644
> > > > > > > > --- a/policy/Makefile
> > > > > > > > +++ b/policy/Makefile
> > > > > > > > @@ -71,6 +71,10 @@ ifeq ($(shell grep -q
> > > > > > > > corenet_sctp_bind_all_nodes
> > > > > > > > $(POLDEV)/include/kernel/coren
> > > > > > > > =A0=A0 TARGETS +=3D test_sctp.te
> > > > > > > > =A0=A0 endif
> > > > > > > > +ifeq ($(shell grep -q all_file_perms.*watch
> > > > > > > > $(POLDEV)/include/support/all_perms.spt && echo
> > > > > > > > true),true)
> > > > > > > > +TARGETS+=3Dtest_notify.te
> > > > > > > > +endif
> > > > > > > > +
> > > > > > > > =A0=A0 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 x=
RHEL6))
> > > > > > > > =A0=A0 TARGETS:=3D$(filter-out test_overlayfs.te
> > > > > > > > test_mqueue.te, $(TARGETS))
> > > > > > > > =A0=A0 endif
> > > > > > > > diff --git a/policy/test_notify.te b/policy/test_notify.te
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000..8ba6f1a
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/policy/test_notify.te
> > > > > > > > @@ -0,0 +1,74 @@
> > > > > > > > +####################################################
> > > > > > > > +# Policy for testing inoftify and fanotify watches #
> > > > > > > > +####################################################
> > > > > > > > +
> > > > > > > > +attribute test_notify_domain;
> > > > > > > > +
> > > > > > > > +# Type for the file on which we want to set a watch
> > > > > > > > +type test_notify_file_t;
> > > > > > > > +files_type(test_notify_file_t);
> > > > > > > > +
> > > > > > > > +# Domain for the process which CAN set a non-permission wa=
tch
> > > > > > > > +type test_watch_t;
> > > > > > > > +domain_type(test_watch_t);
> > > > > > > > +unconfined_runs_test(test_watch_t);
> > > > > > > > +
> > > > > > > > +typeattribute test_watch_t test_notify_domain;
> > > > > > > > +typeattribute test_watch_t testdomain;
> > > > > > > > +
> > > > > > > > +allow test_notify_domain self:capability sys_admin;
> > > > > > > > +
> > > > > > > > +allow test_watch_t test_notify_file_t:file {
> > > > > > > > read write open watch };
> > > > > > > > +
> > > > > > > > +# Domain for the process which CAN set a NON-access watch =
on a file
> > > > > > > > +type test_perm_watch_t;
> > > > > > > > +domain_type(test_perm_watch_t);
> > > > > > > > +unconfined_runs_test(test_perm_watch_t);
> > > > > > > > +
> > > > > > > > +typeattribute test_perm_watch_t test_notify_domain;
> > > > > > > > +typeattribute test_perm_watch_t testdomain;
> > > > > > > > +
> > > > > > > > +allow test_perm_watch_t test_notify_file_t:file
> > > > > > > > { read write open watch watch_with_perm };
> > > > > > > > +
> > > > > > > > +# Domain which CAN set a NON-perm watch which MAY read acc=
esses
> > > > > > > > +type test_read_watch_t;
> > > > > > > > +domain_type(test_read_watch_t);
> > > > > > > > +unconfined_runs_test(test_read_watch_t);
> > > > > > > > +
> > > > > > > > +typeattribute test_read_watch_t test_notify_domain;
> > > > > > > > +typeattribute test_read_watch_t testdomain;
> > > > > > > > +
> > > > > > > > +allow test_read_watch_t test_notify_file_t:file
> > > > > > > > { read write open watch watch_reads };
> > > > > > > > +
> > > > > > > > +# Domain which CAN set any watch which CAN read accesses
> > > > > > > > +type test_perm_read_watch_t;
> > > > > > > > +domain_type(test_perm_read_watch_t);
> > > > > > > > +unconfined_runs_test(test_perm_read_watch_t);
> > > > > > > > +
> > > > > > > > +typeattribute test_perm_read_watch_t test_notify_domain;
> > > > > > > > +typeattribute test_perm_read_watch_t testdomain;
> > > > > > > > +
> > > > > > > > +allow test_perm_read_watch_t
> > > > > > > > test_notify_file_t:file { read write open watch
> > > > > > > > watch_with_perm watch_reads };
> > > > > > > > +
> > > > > > > > +# Domain which CANNOT set any watches
> > > > > > > > +type test_no_watch_t;
> > > > > > > > +domain_type(test_no_watch_t);
> > > > > > > > +unconfined_runs_test(test_no_watch_t);
> > > > > > > > +
> > > > > > > > +typeattribute test_no_watch_t test_notify_domain;
> > > > > > > > +typeattribute test_no_watch_t testdomain;
> > > > > > > > +
> > > > > > > > +allow test_no_watch_t test_notify_file_t:file { read write=
 open };
> > > > > > > > +
> > > > > > > > +# Domain which has no write access but can watch
> > > > > > > > +type test_rdonly_t;
> > > > > > > > +domain_type(test_rdonly_t);
> > > > > > > > +unconfined_runs_test(test_rdonly_t);
> > > > > > > > +
> > > > > > > > +typeattribute test_rdonly_t test_notify_domain;
> > > > > > > > +typeattribute test_rdonly_t testdomain;
> > > > > > > > +
> > > > > > > > +allow test_rdonly_t test_notify_file_t:file { read open wa=
tch };
> > > > > > > > +
> > > > > > > > +miscfiles_domain_entry_test_files(test_notify_domain);
> > > > > > > > +userdom_sysadm_entry_spec_domtrans_to(test_notify_domain);
> > > > > > > > diff --git a/tests/Makefile b/tests/Makefile
> > > > > > > > index 63aa325..b99c96e 100644
> > > > > > > > --- a/tests/Makefile
> > > > > > > > +++ b/tests/Makefile
> > > > > > > > @@ -50,6 +50,10 @@ ifeq ($(shell grep
> > > > > > > > "^SELINUX_INFINIBAND_PKEY_TEST=3D"
> > > > > > > > infiniband_pkey/ibpkey_test.
> > > > > > > > =A0=A0 SUBDIRS +=3D infiniband_pkey
> > > > > > > > =A0=A0 endif
> > > > > > > > +ifeq ($(shell grep -q all_file_perms.*watch
> > > > > > > > $(POLDEV)/include/support/all_perms.spt && echo
> > > > > > > > true),true)
> > > > > > > > +SUBDIRS+=3Dnotify
> > > > > > > > +endif
> > > > > > > > +
> > > > > > > > =A0=A0 ifeq ($(DISTRO),RHEL4)
> > > > > > > > =A0=A0=A0=A0=A0=A0 SUBDIRS:=3D$(filter-out bounds dyntrace
> > > > > > > > dyntrans inet_socket mmap nnp_nosuid overlay
> > > > > > > > unix_socket, $(SUBDIRS))
> > > > > > > > =A0=A0 endif
> > > > > > > > diff --git a/tests/notify/Makefile b/tests/notify/Makefile
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000..78c4b3b
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/tests/notify/Makefile
> > > > > > > > @@ -0,0 +1,5 @@
> > > > > > > > +TARGETS=3Dtest_inotify test_fanotify
> > > > > > > > +
> > > > > > > > +all: $(TARGETS)
> > > > > > > > +clean:
> > > > > > > > +=A0=A0=A0 rm -f $(TARGETS)
> > > > > > > > diff --git a/tests/notify/test b/tests/notify/test
> > > > > > > > new file mode 100755
> > > > > > > > index 0000000..21f03de
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/tests/notify/test
> > > > > > > > @@ -0,0 +1,101 @@
> > > > > > > > +#!/usr/bin/perl
> > > > > > > > +
> > > > > > > > +use Test;
> > > > > > > > +BEGIN { plan tests =3D> 14 }=A0=A0=A0 # number of tests to=
 run
> > > > > > > > +
> > > > > > > > +# help the test script locate itself
> > > > > > > > +$basedir =3D $0;
> > > > > > > > +$basedir =3D~ s|(.*)/[^/]*|$1|;
> > > > > > > > +
> > > > > > > > +# Get rid of a testfile from last run if it's there (just =
in case)
> > > > > > > > +system("rm -f $basedir/watch_me");
> > > > > > > > +
> > > > > > > > +# Create a new test file
> > > > > > > > +system("touch $basedir/watch_me");
> > > > > > > > +system("chcon -t test_notify_file_t $basedir/watch_me");
> > > > > > > > +
> > > > > > > > +## TESTS
> > > > > > > > +
> > > > > > > > +## TEST BASIC WATCH PERMISSION
> > > > > > > > +# Should be able to set inotify watch
> > > > > > > > +$exit_val =3D
> > > > > > > > +=A0 system("runcon -t test_watch_t
> > > > > > > > $basedir/test_inotify $basedir/watch_me 2>&1");
> > > > > > > > +ok( $exit_val, 0 );
> > > > > > > > +
> > > > > > > > +# Should be able to set non-permissions based fanotify wat=
ch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_watch_t
> > > > > > > > $basedir/test_fanotify $basedir/watch_me 2>&1");
> > > > > > > > +ok( $exit_val, 0 );
> > > > > > > > +
> > > > > > > > +# Should NOT be able to set permission based fanotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_watch_t
> > > > > > > > $basedir/test_fanotify -p $basedir/watch_me
> > > > > > > > 2>&1");
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +# Should NOT be able to set read based fanotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_watch_t
> > > > > > > > $basedir/test_fanotify -r $basedir/watch_me
> > > > > > > > 2>&1");
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +# Should NOT be able to set read based inotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_watch_t
> > > > > > > > $basedir/test_inotify -r $basedir/watch_me
> > > > > > > > 2>&1");
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +## TEST PERM WATCH
> > > > > > > > +# Should be able to set permission based fanotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +"runcon -t test_perm_watch_t
> > > > > > > > $basedir/test_fanotify -p $basedir/watch_me
> > > > > > > > 2>&1"
> > > > > > > > +);
> > > > > > > > +ok( $exit_val, 0 );
> > > > > > > > +
> > > > > > > > +# Should NOT be able to set watch of accesses
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +"runcon -t test_perm_watch_t
> > > > > > > > $basedir/test_fanotify -r $basedir/watch_me
> > > > > > > > 2>&1"
> > > > > > > > +);
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +## TEST READ NO PERM WATCH PERMSISSIONS
> > > > > > > > +# Should NOT be able to set read and perm watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +"runcon -t test_read_watch_t
> > > > > > > > $basedir/test_fanotify -p -r $basedir/watch_me
> > > > > > > > 2>&1"
> > > > > > > > +);
> > > > > > > > +ok($exit_val);=A0=A0=A0 # should fail
> > > > > > > > +
> > > > > > > > +# Should be able to set read inotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +"runcon -t test_read_watch_t
> > > > > > > > $basedir/test_inotify -r $basedir/watch_me 2>&1"
> > > > > > > > +);
> > > > > > > > +ok( $exit_val, 0 );
> > > > > > > > +
> > > > > > > > +## TEST READ WITH PERM WATCH PERMSISSIONS
> > > > > > > > +# Should be able to set read and perm watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +"runcon -t test_perm_read_watch_t
> > > > > > > > $basedir/test_fanotify -p -r $basedir/watch_me
> > > > > > > > 2>&1"
> > > > > > > > +);
> > > > > > > > +ok( $exit_val, 0 );
> > > > > > > > +
> > > > > > > > +## TEST NO WATCH PERMSISSIONS
> > > > > > > > +# Should NOT be able to set inotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_no_watch_t
> > > > > > > > $basedir/test_inotify $basedir/watch_me 2>&1");
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +# Should NOT be able to set any fanotify watch
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_no_watch_t
> > > > > > > > $basedir/test_fanotify $basedir/watch_me 2>&1");
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +## TEST READ ONLY
> > > > > > > > +# Should NOT be able to get read-write descriptor
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_rdonly_t
> > > > > > > > $basedir/test_fanotify -l $basedir/watch_me
> > > > > > > > 2>&1");
> > > > > > > > +ok($exit_val);=A0=A0=A0 # this should fail
> > > > > > > > +
> > > > > > > > +# Should be able to get read-write descriptor
> > > > > > > > +$exit_val =3D system(
> > > > > > > > +=A0=A0=A0 "runcon -t test_watch_t
> > > > > > > > $basedir/test_fanotify -l $basedir/watch_me
> > > > > > > > 2>&1");
> > > > > > > > +ok( $exit_val, 0 );
> > > > > > > > +
> > > > > > > > +# Clean up test file
> > > > > > > > +system("rm -f $basedir/watch_me");
> > > > > > > > diff --git a/tests/notify/test_fanotify.c
> > > > > > > > b/tests/notify/test_fanotify.c
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000..fff773f
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/tests/notify/test_fanotify.c
> > > > > > > > @@ -0,0 +1,105 @@
> > > > > > > > +#define _GNU_SOURCE 1
> > > > > > > > +
> > > > > > > > +#include <stdio.h>
> > > > > > > > +#include <stdlib.h>
> > > > > > > > +
> > > > > > > > +#include <getopt.h>
> > > > > > > > +
> > > > > > > > +#include <fcntl.h>
> > > > > > > > +#include <poll.h>
> > > > > > > > +#include <sys/fanotify.h>
> > > > > > > > +#include <unistd.h>
> > > > > > > > +
> > > > > > > > +void printUsage()
> > > > > > > > +{
> > > > > > > > +=A0=A0=A0 fprintf(stderr, "Usage: test_fanotify [-p]
> > > > > > > > [-r] [-l] file_name\n");
> > > > > > > > +=A0=A0=A0 exit(1);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +int main(int argc, char *argv[])
> > > > > > > > +{
> > > > > > > > +=A0=A0=A0 if (argc < 2) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 printUsage();
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 int fd, ret, arg;
> > > > > > > > +=A0=A0=A0 int mask =3D FAN_OPEN;=A0 // default mask
> > > > > > > > +=A0=A0=A0 int listening =3D 0;
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 // the -p flag will test for watch_with_perm
> > > > > > > > +=A0=A0=A0 // the mask used at mark will contain FAN_OPEN_P=
ERM
> > > > > > > > +=A0=A0=A0 //
> > > > > > > > +=A0=A0=A0 // the -r flag will test for watching
> > > > > > > > accesses to files for reads
> > > > > > > > +=A0=A0=A0 // the mask will contain FAN_ACCESS
> > > > > > > > +=A0=A0=A0 while ((arg =3D getopt(argc, argv, "prl")) !=3D =
-1) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 switch (arg) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 case 'p':
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask |=3D FAN_OPEN_PERM;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 case 'r':
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask |=3D FAN_ACCESS;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 case 'l':
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 listening =3D 1;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 default:
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printUsage();
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 // get file descriptor for new fanotify event qu=
eue
> > > > > > > > +=A0=A0=A0 fd =3D fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
> > > > > > > > +=A0=A0=A0 if (fd < 0) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 perror("fanotify_init:bad file descr=
iptor");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 // mark a filesystem object and add mark to even=
t queue
> > > > > > > > +=A0=A0=A0 // get notifications on file opens, accesses, an=
d closes
> > > > > > > > +=A0=A0=A0 // use current working directory as base dir
> > > > > > > > +=A0=A0=A0 ret =3D fanotify_mark(fd, FAN_MARK_ADD, mask,
> > > > > > > > AT_FDCWD, argv[optind]);
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 if (ret < 0) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 perror("test_fanotify:watch denied");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 // logic to actually listen for an event if
> > > > > > > > the -l flag is passed
> > > > > > > > +=A0=A0=A0 // this is used to test if an app with
> > > > > > > > read-only access can get a read/write
> > > > > > > > +=A0=A0=A0 // handle to the watched file
> > > > > > > > +=A0=A0=A0 if (listening) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (fork() =3D=3D 0) {=A0 // fork a =
child
> > > > > > > > process to cause an event on the file
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FILE *f;
> > > > > > > > +
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f =3D fopen(argv[optind]=
, "r");=A0 // open file for reading
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fgetc(f);=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // read char from file
> > > > > > > > +
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fclose(f);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 } else {=A0 // logic to watch for ev=
ents
> > > > > > > > and try to access file read/write
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct pollfd fds;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fds.fd =3D fd;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fds.events =3D POLLIN;
> > > > > > > > +
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (listening) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int polled =
=3D poll(&fds, 1, 1);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (polled >=
 0) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
if (fds.revents & POLLIN) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 struct fanotify_event_metadata buff[200];
> > > > > > > > +
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 size_t len =3D read(fd,
> > > > > > > > (void *)&buff, sizeof(buff));
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 if (len =3D=3D -1) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > > > perror("test_fanotify:can't open file");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 } else {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 listening =3D 0;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (p=
olled =3D=3D -1) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
listening =3D 0;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0 exit(0);
> > > > > > > > +}
> > > > > > > > diff --git a/tests/notify/test_inotify.c
> > > > > > > > b/tests/notify/test_inotify.c
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000..17c3565
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/tests/notify/test_inotify.c
> > > > > > > > @@ -0,0 +1,43 @@
> > > > > > > > +#include <stdio.h>
> > > > > > > > +#include <stdlib.h>
> > > > > > > > +#include <sys/inotify.h>
> > > > > > > > +#include <getopt.h>
> > > > > > > > +
> > > > > > > > +int main(int argc, char *argv[])
> > > > > > > > +{
> > > > > > > > +=A0=A0=A0 if (argc < 2) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "Usage: test_inotify=
 [-r] file_name\n");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 int fd, wd, arg;
> > > > > > > > +=A0=A0=A0 int mask =3D IN_MODIFY;
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 while ((arg =3D getopt(argc, argv, "pr")) !=3D -=
1) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 switch (arg) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 case 'r':
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask |=3D IN_ACCESS;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 default:
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "Usage:
> > > > > > > > test_inotify [-r] file_name\n");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 // get new file descriptor for inotify access
> > > > > > > > +=A0=A0=A0 fd =3D inotify_init();
> > > > > > > > +=A0=A0=A0 if (fd < 0) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 perror("inotify_init:bad file descri=
ptor");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 // set watch on file and get watch
> > > > > > > > descriptor for accessing events on it
> > > > > > > > +=A0=A0=A0 wd =3D inotify_add_watch(fd, argv[optind], mask);
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 if (wd < 0) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 perror("test_inotify:watch denied");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 exit(0);
> > > > > > > > +}
> > > > > > > > --=20
> > > > > > > > 2.21.0
> > > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl13v7IACgkQJXSOVTf5
R2kciAwAj51mPGu675U+xIdqNeEszcSgXsjwenIt7XvdnzAFakH4qIO+RnU55RKL
TlygtfnOtvtZxG4aATOAzHtctW7vvKJWj6Ip6KweDZW6UdkvsBKfPOdzlb7PIBDq
XdjByioykvjGPaopR8A8btlKrB5EAR/LgTSY/7vggPHcNpWucvNxAU9Wze9r9cZq
1xM1tiO2hAVsWYndF0KUrRDbMvPNxxTs5Lr6bSCowI1L7A+iPr5jdWbcCRnTqngI
XHzSZGOA2ykbkayUHr5e7sDOX4bz55uXZKCwJU/XwYijd11pSetMDpaafAOktdM0
qxmWC0GPGg+aw03zO+hhuejisUfhsWsOrwH5iK4v9U/6gzuL8lH9f+Hn8T3Stxhq
Nq9+X2UbmiOtOLu/0fBT3SVqyoXvwpUy8joFGnqP3/j+8HQYoDR0oNkp9O3zJjNS
7EVKZ2bb6Sb6d0bxPdSGT7jJKlfQmxbvA9gq3PwfFyPebDfR8n5y9k/LnZQ9qfzP
UhUVUxrA
=QlMi
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
