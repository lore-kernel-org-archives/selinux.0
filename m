Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73EECE58D
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BEF21848
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RII7TtNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJIOxq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:53:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729865AbfJIOxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570632824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKvDOL4Fdeo/l/G0FxiLqf/g63AOIy0dhB2OWgkem+s=;
        b=RII7TtNON7AfVBGZOKVMwOjkzpAAT/yAtjB2GmzqdJGPQF7LLOogvDeNhc77lDHlKVYclb
        oB+bZn7wNRPEUeKLqRPRF72FbwRP2k+Ak3WrjY0wcKSQHoTGvElKa7Bk7uWWeyrtU1r8wy
        ec2x9EydTLiPvXBG+DHT2pLEmbnq7iU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-e42AYoQSNoeBNv8XjZNCvA-1; Wed, 09 Oct 2019 10:53:42 -0400
Received: by mail-ot1-f70.google.com with SMTP id f26so1274645otq.17
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2019 07:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yURA94sYzw1DykwVUZPyrDheBRkeC5fSCDbMDM/FlBA=;
        b=SHXEOEs2E1HtG1f9rRjQ8O30LBTY7SMAmVhrh9GUhIvm7ggkUs2u6FvaUQ/9Da3z8g
         OY1rMiHX0rKWwRiY482voagss24O1FkFgzm+NLPmQdzBV5fDBMwAecoSsfYXpGtOD6Ma
         CAdm5LcKBAgfpfOEsi62HhHt4Z9gF2Ae04aIF3XkdjIIr2vhoraTscFtIL0mx4sTdO6t
         33/PDDqYvS6LQmmfzKvrqYBtMM0GrOzLzNAipoceVX2SlwA8toaM74fzPivNgKRRiy2P
         mcnsqTyWjnCTXgqrpB3QDrRQjQ3ZwVJu9XBJPv2VGJGSH7HgS76AHfFHPvuYiQcGKrds
         DwTg==
X-Gm-Message-State: APjAAAXqYDk1vfLJi1LG2K8Kv434TQShvBXTBd23dKX0MVmlOCuFLOLb
        JpQISlO+e78u/2G4C0B8/Uhw6KeXXX4ah1jKdgfnxrTqXsOkn5IrtNEwJ0V7jU9hQ4f0tokiFLu
        pqwqr0X6cwm75oaUlDvGhpLwg67gERled3A==
X-Received: by 2002:a05:6830:1510:: with SMTP id k16mr3267464otp.197.1570632821980;
        Wed, 09 Oct 2019 07:53:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1HzE4hwmhRUiFrOuSiQkJm/IdUp+wBfAqNp38aYbwtgVa7/m2wyeJJeGzr0qVykg5LDFJ0Hf+sgMRryWL6PI=
X-Received: by 2002:a05:6830:1510:: with SMTP id k16mr3267442otp.197.1570632821615;
 Wed, 09 Oct 2019 07:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190930131600.21473-1-omosnace@redhat.com> <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
 <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com>
 <ddea594c-717b-cb40-6bd7-7bb6c8cae79d@tycho.nsa.gov> <CAHC9VhRmX0ofWA7Yqg73XfDW0Hhf2j6Yr7pi1pQ=bDBiARd5sg@mail.gmail.com>
In-Reply-To: <CAHC9VhRmX0ofWA7Yqg73XfDW0Hhf2j6Yr7pi1pQ=bDBiARd5sg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Oct 2019 16:53:30 +0200
Message-ID: <CAFqZXNvoh_ev=-RTFPgMBKGddzWME=SBqtX-EtKQ8f_YEGQOkw@mail.gmail.com>
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: e42AYoQSNoeBNv8XjZNCvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 4:01 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Oct 9, 2019 at 9:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 10/8/19 5:30 PM, Paul Moore wrote:
> > > On Mon, Sep 30, 2019 at 10:07 AM Stephen Smalley <sds@tycho.nsa.gov> =
wrote:
> > >> On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
> > >>> Add a test that verifies that SELinux permissions are not checked w=
hen
> > >>> mounting submounts. The test sets up a simple local NFS export on a
> > >>> directory which has another filesystem mounted on its subdirectory.
> > >>> Since the export is set up with the crossmnt option enabled, any cl=
ient
> > >>> mount will try to transparently mount any subdirectory that has a
> > >>> filesystem mounted on it on the server, triggering an internal moun=
t.
> > >>> The test tries to access the automounted part of this export via a
> > >>> client mount without having a permission to mount filesystems, expe=
cting
> > >>> it to succeed.
> > >>>
> > >>> The original bug this test is checking for has been fixed in kernel
> > >>> commit 892620bb3454 ("selinux: always allow mounting submounts"), w=
hich
> > >>> has been backported to 4.9+ stable kernels.
> > >>>
> > >>> The test first checks whether it is able to export and mount direct=
ories
> > >>> via NFS and skips the actual tests if e.g. NFS daemon is not runnin=
g.
> > >>> This means that the testsuite can still be run without having the N=
FS
> > >>> server installed and running.
> > >>
> > >> 1) We have to manually start nfs-server in order for the test to run=
;
> > >> else it will be skipped automatically.  Do we want to start/stop the
> > >> nfs-server as part of the test script?
> > >
> > > My two cents are that I'm not sure we want to automatically start/sto=
p
> > > the NFS server with the usual "make test", perhaps we have a dedicate=
d
> > > NFS test target that does the setup-test-shutdown?  Other ideas are
> > > welcome.
> >
> > I guess my concern is that anything that doesn't run with the default
> > make test probably won't get run at all with any regularity.
>
> FWIW, I think I'm the only one regularly running the tests on upstream
> kernels and reporting the results.  RH was running the tests at one
> point, and may still be doing so, but I have no idea what kernels they
> are testing (maybe just RHEL, stable Fedora, etc.) and what their
> process is when they find failures.

We do still run the selinux-testsuite nightly on Fedora Rawhide with
your kernel-secnext kernel builds (I suppose we fetch them from COPR).
I can't really describe what we do when they fail, because that hardly
ever happens now :) But if we came across a failure that would suggest
a bug, we would certainly investigate and report it.

The testsuite is now also being run as part of CKI
(https://github.com/cki-project), which AFAIK currently runs regularly
on linux-stable kernels (the results are posted publicly to
stable@vger.kernel.org). I don't follow these reports closely, so I'm
not sure if there were any non-false-positive failures there...

>
> I also try to enable everything that I can enable for my test runs.
> Thanks to Mellanox I can even run the IB tests.
>
> > For
> > something that requires specialized hardware (e.g. InfiniBand), this is
> > reasonable but that isn't true of NFS.  For the more analogous cases of
> > e.g. labeled IPSEC, NetLabel, SECMARK, we already load and unload
> > network configurations for the testsuite during testing.
>
> That's a good point about the other networking tests.  My gut feeling
> tells me that NFS should be "different", but I guess I can't really
> justify that statement in an objectively meaningful way.

I think the main reason why I didn't include NFS server starting was
that I don't know how to do it robustly across distros... Already on
RHEL the service name varies ("nfs-server" vs. just "nfs") and then
there is "service xyz start" vs. "systemctl start xyz"...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

