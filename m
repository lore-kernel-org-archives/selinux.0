Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E9C49EA3
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BCF61C6C
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 13:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhF1Njb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232378AbhF1Ni7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jun 2021 09:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624887393;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8y8IjxvgZqMHaHii25ORWzzvVrWAlZ+hclmNVcMi+M=;
        b=EseEgWBrTc68PaD/YAjwg7z92oYBobAenL5Xza8rEc2MabEcwpCc3YeIiAXm9Z1W3eS20f
        oQmxeBNNDRfdqvgmtaXAregpqUxcuH5BUQCmarzxhiJBFuRH3I387hBz4wx8uku/+grFfT
        Zut4M9c2MJ0vwqSgN0N2lXMyP9KKlUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-HRaSLbERPWGIO6ZUwz0STg-1; Mon, 28 Jun 2021 09:36:32 -0400
X-MC-Unique: HRaSLbERPWGIO6ZUwz0STg-1
Received: by mail-qk1-f200.google.com with SMTP id t144-20020a3746960000b02903ad9c5e94baso17512262qka.16
        for <selinux@vger.kernel.org>; Mon, 28 Jun 2021 06:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=n8y8IjxvgZqMHaHii25ORWzzvVrWAlZ+hclmNVcMi+M=;
        b=pRJjl9o4s31w7i3oRNnAgKPP+TieoJr6e3KbZhwDbozQx4h6lRjSbRRzkcCZ9ESfy2
         vUUr3PBaVDTIFxMD57j7koVT2AgqJ0On0tLxUEHly9/SKsRNqdg3sT3nxPmwJwYOky0v
         HtQlgdDWiVpk8lZCXQQQDojwsxpKd2nc7DUBhlqCTpFmC53Bdctu2dX5WGwrUjpZM06N
         UFkiMTsYRsDOiCt/3pt/zfJSPFnBbkiNCppzKYMuweFrFMXI9Hx3cpspqO/oEScV0Se4
         aA3ggZ4gbOwZEaW+DeSDcaLwQmcywOzcc3L3/hUA4pjMB7K6411V2Je33fdrY+mqDmi8
         /sWw==
X-Gm-Message-State: AOAM5300PhqP6kEjIEMcoV+55U2Txu62LgkaP3tpxC+F+etit+2fiS75
        SNud8vwHoTayj9MY+rBN+GCfZYmEPGmXvODQtKpnm8ZHAETMByuNEPEXPLUSaUhXM4465+i3Jy1
        n1w1QhFZukLpE501vDNXtqMcMJ9sGgHDRMs28vq+44htSRF8PqjRkYyRfYiCPWm5IZTo=
X-Received: by 2002:a37:b6c5:: with SMTP id g188mr24378041qkf.92.1624887391078;
        Mon, 28 Jun 2021 06:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDBr+6k33V1n9z70IW9/6M+lW1ZgF/r3kzSNLCjlDuhLCUCTsWNhndPJTMgARipWfgqsL+ag==
X-Received: by 2002:a37:b6c5:: with SMTP id g188mr24378006qkf.92.1624887390816;
        Mon, 28 Jun 2021 06:36:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id g19sm8175866qtg.36.2021.06.28.06.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:36:30 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     Vivek Goyal <vgoyal@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
Date:   Mon, 28 Jun 2021 09:36:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628131708.GA1803896@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/28/21 09:17, Vivek Goyal wrote:
> On Fri, Jun 25, 2021 at 09:49:51PM +0000, Schaufler, Casey wrote:
>>> -----Original Message-----
>>> From: Vivek Goyal <vgoyal@redhat.com>
>>> Sent: Friday, June 25, 2021 12:12 PM
>>> To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> viro@zeniv.linux.org.uk
>>> Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com;
>>> berrange@redhat.com; vgoyal@redhat.com
>> Please include Linux Security Module list <linux-security-module@vger.kernel.org>
>> and selinux@vger.kernel.org on this topic.
>>
>>> Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special files if
>>> caller has CAP_SYS_RESOURCE
>>>
>>> Hi,
>>>
>>> In virtiofs, actual file server is virtiosd daemon running on host.
>>> There we have a mode where xattrs can be remapped to something else.
>>> For example security.selinux can be remapped to
>>> user.virtiofsd.securit.selinux on the host.
>> This would seem to provide mechanism whereby a user can violate
>> SELinux policy quite easily.
> Hi Casey,
>
> As david already replied, we are not bypassing host's SELinux policy (if
> there is one). We are just trying to provide a mode where host and
> guest's SELinux policies could co-exist without interefering
> with each other.
>
> By remappming guests SELinux xattrs (and not host's SELinux xattrs),
> a file probably will have two xattrs
>
> "security.selinux" and "user.virtiofsd.security.selinux". Host will
> enforce SELinux policy based on security.selinux xattr and guest
> will see the SELinux info stored in "user.virtiofsd.security.selinux"
> and guest SELinux policy will enforce rules based on that.
> (user.virtiofsd.security.selinux will be remapped to "security.selinux"
> when guest does getxattr()).
>
> IOW, this mode is allowing both host and guest SELinux policies to
> co-exist and not interefere with each other. (Remapping guests's
> SELinux xattr is not changing hosts's SELinux label and is not
> bypassing host's SELinux policy).
>
> virtiofsd also provides for the mode where if guest process sets
> SELinux xattr it shows up as security.selinux on host. But now we
> have multiple issues. There are two SELinux policies (host and guest)
> which are operating on same lable. And there is a very good chance
> that two have not been written in such a way that they work with
> each other. In fact there does not seem to exist a notion where
> two different SELinux policies are operating on same label.
>
> At high level, this is in a way similar to files created on
> virtio-blk devices. Say this device is backed by a foo.img file
> on host. Now host selinux policy will set its own label on
> foo.img and provide access control while labels created by guest
> are not seen or controlled by host's SELinux policy. Only guest
> SELinux policy works with those labels.
>
> So this is similar kind of attempt. Provide isolation between
> host and guests's SELinux labels so that two policies can
> co-exist and not interfere with each other.
>
>>> This remapping is useful when SELinux is enabled in guest and virtiofs
>>> as being used as rootfs. Guest and host SELinux policy might not match
>>> and host policy might deny security.selinux xattr setting by guest
>>> onto host. Or host might have SELinux disabled and in that case to
>>> be able to set security.selinux xattr, virtiofsd will need to have
>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
>>> guest security.selinux (or other xattrs) on host to something else
>>> is also better from security point of view.
>> Can you please provide some rationale for this assertion?
>> I have been working with security xattrs longer than anyone
>> and have trouble accepting the statement.
> If guest is not able to interfere or change host's SELinux labels
> directly, it sounded better.
>
> Irrespective of this, my primary concern is that to allow guest
> VM to be able to use SELinux seamlessly in diverse host OS
> environments (typical of cloud deployments). And being able to
> provide a mode where host and guest's security labels can
> co-exist and policies can work independently, should be able
> to achieve that goal.
>
>>> But when we try this, we noticed that SELinux relabeling in guest
>>> is failing on some symlinks. When I debugged a little more, I
>>> came to know that "user.*" xattrs are not allowed on symlinks
>>> or special files.
>>>
>>> "man xattr" seems to suggest that primary reason to disallow is
>>> that arbitrary users can set unlimited amount of "user.*" xattrs
>>> on these files and bypass quota check.
>>>
>>> If that's the primary reason, I am wondering is it possible to relax
>>> the restrictions if caller has CAP_SYS_RESOURCE. This capability
>>> allows caller to bypass quota checks. So it should not be
>>> a problem atleast from quota perpective.
>>>
>>> That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
>>> and remap xattrs arbitrarily.
>> On a Smack system you should require CAP_MAC_ADMIN to remap
>> security. xattrs. I sounds like you're in serious danger of running afoul
>> of LSM attribute policy on a reasonable general level.
> I think I did not explain xattr remapping properly and that's why this
> confusion is there. Only guests's xattrs will be remapped and not
> hosts's xattr. So one can not bypass any access control implemented
> by any of the LSM on host.
>
> Thanks
> Vivek
>
I want to point out that this solves a  couple of other problems also.  
Currently virtiofsd attempts to write security attributes on the host, 
which is denied by default on systems without SELinux and no 
CAP_SYS_ADMIN.  This means if you want to run a container or VM on a 
host without SELinux support but the VM has SELinux enabled, then 
virtiofsd needs CAP_SYS_ADMIN.  It would be much more secure if it only 
needed CAP_SYS_RESOURCE.  If the host has SELinux enabled then it can 
run without CAP_SYS_ADMIN or CAP_SYS_RESOURCE, but it will only be 
allowed to write labels that the host system understands, any label not 
understood will be blocked. Not only this, but the label that is running 
virtiofsd pretty much has to run as unconfined, since it could be 
writing any SELinux label.

If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we can 
run with a confined SELinux label only allowing it to sexattr on the 
content in the designated directory, make the container/vm much more secure.


