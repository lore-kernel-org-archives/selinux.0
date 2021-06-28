Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6840DC49EA3
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5412E61883
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 16:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhF1Qa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jun 2021 12:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233189AbhF1Qaz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jun 2021 12:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624897709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/l67GBIRQesyIDhYC0lVpbw73bssgYfuq+ath3cG+8=;
        b=jPv93NJo55OQQbgYvOwyeV40nRIen23KJffDvNygeX/EL9Lva6YR+8eFADYtqYQvs83Yfn
        m0Iyn7OD414a8AE9B5jhNpbPa08wW7HygrHXQENeRzvgnLOhBYRdvzGtZHg7vsFQkLn47g
        haA86RX1OlEIVvewAFaVDk3e8PxjU7Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-UFSMge8aMqGXeWBYM3slyQ-1; Mon, 28 Jun 2021 12:28:27 -0400
X-MC-Unique: UFSMge8aMqGXeWBYM3slyQ-1
Received: by mail-wr1-f71.google.com with SMTP id b3-20020a05600018a3b029011a84f85e1cso4826190wri.10
        for <selinux@vger.kernel.org>; Mon, 28 Jun 2021 09:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L/l67GBIRQesyIDhYC0lVpbw73bssgYfuq+ath3cG+8=;
        b=NoyNZvlglvTcUjXkE4K6tg2/T3QkHTlON+XXzpmEtA/OPIU9NzxTc5ZQVy2IO/FKlm
         4YjNZ1bwfe/s4bBT+auKjh37queX219skdHyIyI+cfH0FTL6bjzXADa5TjmlmRhSkvj5
         /7Eq7V5sEBxbLygiUWkMfKhrnNWmkNOxaNWmmbKIRqqn0WUbZvEke3hbxZKBtEQjcw8/
         NU40v3ws2tqMC3TWoCBnou0se4cbLKPmnzeABWtbuhEA2ozC5K8L7p3vT9mOriR40EEI
         TXCgkh7vfb7XinuRpZASe2yoMUuUH5DEbSSBx4JIzDVSqWTfcf8TCL/4/6YCC725yx7+
         +nBw==
X-Gm-Message-State: AOAM5329TEth2FnnF9/KnDv0gicu9Qnr9JziUZl+mTsfdMfFSGVaQHtM
        rgr7ZVDIboY8xIXETR9hGLSjnYsEM4SyL7N88zVspKoam4zDxutUK8u8hZFRueV6I4V037WI3hU
        8t8Cb2iPYLoTCKR4E6A==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr11027084wrv.310.1624897706348;
        Mon, 28 Jun 2021 09:28:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTyV4+asBYZLWCZ/4Ugw0wAlbxogR+DyMPyNVe5cAtcYsr4/au1LmQUX070a+JSdjuO2cTIA==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr11027067wrv.310.1624897706217;
        Mon, 28 Jun 2021 09:28:26 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id 9sm493553wmf.3.2021.06.28.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 09:28:25 -0700 (PDT)
Date:   Mon, 28 Jun 2021 17:28:23 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dwalsh@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNn4p+Zn444Sc4V+@work-vm>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Casey Schaufler (casey@schaufler-ca.com) wrote:
> On 6/28/2021 6:36 AM, Daniel Walsh wrote:
> > On 6/28/21 09:17, Vivek Goyal wrote:
> >> On Fri, Jun 25, 2021 at 09:49:51PM +0000, Schaufler, Casey wrote:
> >>>> -----Original Message-----
> >>>> From: Vivek Goyal <vgoyal@redhat.com>
> >>>> Sent: Friday, June 25, 2021 12:12 PM
> >>>> To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>> viro@zeniv.linux.org.uk
> >>>> Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com;
> >>>> berrange@redhat.com; vgoyal@redhat.com
> >>> Please include Linux Security Module list <linux-security-module@vger.kernel.org>
> >>> and selinux@vger.kernel.org on this topic.
> >>>
> >>>> Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special files if
> >>>> caller has CAP_SYS_RESOURCE
> >>>>
> >>>> Hi,
> >>>>
> >>>> In virtiofs, actual file server is virtiosd daemon running on host.
> >>>> There we have a mode where xattrs can be remapped to something else.
> >>>> For example security.selinux can be remapped to
> >>>> user.virtiofsd.securit.selinux on the host.
> >>> This would seem to provide mechanism whereby a user can violate
> >>> SELinux policy quite easily.
> >> Hi Casey,
> >>
> >> As david already replied, we are not bypassing host's SELinux policy (if
> >> there is one). We are just trying to provide a mode where host and
> >> guest's SELinux policies could co-exist without interefering
> >> with each other.
> >>
> >> By remappming guests SELinux xattrs (and not host's SELinux xattrs),
> >> a file probably will have two xattrs
> >>
> >> "security.selinux" and "user.virtiofsd.security.selinux". Host will
> >> enforce SELinux policy based on security.selinux xattr and guest
> >> will see the SELinux info stored in "user.virtiofsd.security.selinux"
> >> and guest SELinux policy will enforce rules based on that.
> >> (user.virtiofsd.security.selinux will be remapped to "security.selinux"
> >> when guest does getxattr()).
> >>
> >> IOW, this mode is allowing both host and guest SELinux policies to
> >> co-exist and not interefere with each other. (Remapping guests's
> >> SELinux xattr is not changing hosts's SELinux label and is not
> >> bypassing host's SELinux policy).
> >>
> >> virtiofsd also provides for the mode where if guest process sets
> >> SELinux xattr it shows up as security.selinux on host. But now we
> >> have multiple issues. There are two SELinux policies (host and guest)
> >> which are operating on same lable. And there is a very good chance
> >> that two have not been written in such a way that they work with
> >> each other. In fact there does not seem to exist a notion where
> >> two different SELinux policies are operating on same label.
> >>
> >> At high level, this is in a way similar to files created on
> >> virtio-blk devices. Say this device is backed by a foo.img file
> >> on host. Now host selinux policy will set its own label on
> >> foo.img and provide access control while labels created by guest
> >> are not seen or controlled by host's SELinux policy. Only guest
> >> SELinux policy works with those labels.
> >>
> >> So this is similar kind of attempt. Provide isolation between
> >> host and guests's SELinux labels so that two policies can
> >> co-exist and not interfere with each other.
> >>
> >>>> This remapping is useful when SELinux is enabled in guest and virtiofs
> >>>> as being used as rootfs. Guest and host SELinux policy might not match
> >>>> and host policy might deny security.selinux xattr setting by guest
> >>>> onto host. Or host might have SELinux disabled and in that case to
> >>>> be able to set security.selinux xattr, virtiofsd will need to have
> >>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> >>>> guest security.selinux (or other xattrs) on host to something else
> >>>> is also better from security point of view.
> >>> Can you please provide some rationale for this assertion?
> >>> I have been working with security xattrs longer than anyone
> >>> and have trouble accepting the statement.
> >> If guest is not able to interfere or change host's SELinux labels
> >> directly, it sounded better.
> >>
> >> Irrespective of this, my primary concern is that to allow guest
> >> VM to be able to use SELinux seamlessly in diverse host OS
> >> environments (typical of cloud deployments). And being able to
> >> provide a mode where host and guest's security labels can
> >> co-exist and policies can work independently, should be able
> >> to achieve that goal.
> >>
> >>>> But when we try this, we noticed that SELinux relabeling in guest
> >>>> is failing on some symlinks. When I debugged a little more, I
> >>>> came to know that "user.*" xattrs are not allowed on symlinks
> >>>> or special files.
> >>>>
> >>>> "man xattr" seems to suggest that primary reason to disallow is
> >>>> that arbitrary users can set unlimited amount of "user.*" xattrs
> >>>> on these files and bypass quota check.
> >>>>
> >>>> If that's the primary reason, I am wondering is it possible to relax
> >>>> the restrictions if caller has CAP_SYS_RESOURCE. This capability
> >>>> allows caller to bypass quota checks. So it should not be
> >>>> a problem atleast from quota perpective.
> >>>>
> >>>> That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
> >>>> and remap xattrs arbitrarily.
> >>> On a Smack system you should require CAP_MAC_ADMIN to remap
> >>> security. xattrs. I sounds like you're in serious danger of running afoul
> >>> of LSM attribute policy on a reasonable general level.
> >> I think I did not explain xattr remapping properly and that's why this
> >> confusion is there. Only guests's xattrs will be remapped and not
> >> hosts's xattr. So one can not bypass any access control implemented
> >> by any of the LSM on host.
> >>
> >> Thanks
> >> Vivek
> >>
> > I want to point out that this solves a  couple of other problems also. 
> 
> I am not (usually) adverse to solving problems. My concern is with
> regard to creating new ones.
> 
> > Currently virtiofsd attempts to write security attributes on the host, which is denied by default on systems without SELinux and no CAP_SYS_ADMIN.
> 
> Right. Which is as it should be.
> Also, s/SELinux/a LSM that uses security xattrs/
> 
> >   This means if you want to run a container or VM
> 
> A container uses the kernel from the host. A VM uses the kernel
> from the guest. Unless you're calling a VM a container for
> marketing purposes. If this scheme works for non-VM based containers
> there's a problem.

And 'kata' is it's own kernel, but more like a container runtime - would
you like to call this a VM or a container?
There's whole bunch of variations people are playing around with; I don't
think there's a single answer, or a single way people are trying to use
it.

> > on a host without SELinux support but the VM has SELinux enabled, then virtiofsd needs CAP_SYS_ADMIN.  It would be much more secure if it only needed CAP_SYS_RESOURCE.
> 
> I don't know, so I'm asking. Does virtiofsd really get run with limited capabilities,
> or does it get run as root like most system daemons? If it runs as root the argument
> has no legs.

It's typically run without CAP_SYS_ADMIN; (although we have other
problems, like wanting to use file handles that make caps tricky).
Some people are trying to run it in user namespaces.
Given that it's pretty complex and playing with lots of file syscalls
under partial control of the guest, giving it as few capabilities
as possible is my preference.

> >   If the host has SELinux enabled then it can run without CAP_SYS_ADMIN or CAP_SYS_RESOURCE, but it will only be allowed to write labels that the host system understands, any label not understood will be blocked. Not only this, but the label that is running virtiofsd pretty much has to run as unconfined, since it could be writing any SELinux label.
> 
> You could fix that easily enough by teaching SELinux about the proper
> use of CAP_MAC_ADMIN. Alas, I understand that there's no way that's
> going to happen, and why it would be considered philosophically repugnant
> in the SELinux community. 
> 
> >
> > If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we can run with a confined SELinux label only allowing it to sexattr on the content in the designated directory, make the container/vm much more secure.
> >
> User xattrs are less protected than security xattrs. You are exposing the
> security xattrs on the guest to the possible whims of a malicious, unprivileged
> actor on the host. All it needs is the right UID.

Yep, we realise that; but when you're mainly interested in making sure
the guest can't attack the host, that's less worrying.
It would be lovely if there was something more granular, (e.g. allowing
user.NUMBER. or trusted.NUMBER. to be used by this particular guest).

> We have unused xattr namespaces. Would using the "trusted" namespace
> work for your purposes?

For those with CAP_SYS_ADMIN I guess.

Note the virtiofsd takes an option allowing you to set the mapping
however you like, so there's no hard coded user. or trusted. in the
daemon itself.

Dave

> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

