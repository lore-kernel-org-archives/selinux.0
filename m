Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3163C11F68
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8777D61DE7
	for <selinux@archiver.kernel.org>; Tue, 29 Jun 2021 16:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhF2Qhi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jun 2021 12:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233544AbhF2Qhh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jun 2021 12:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624984509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFtEvrlVui7BaqyBqVH/Nri0P4QA4rILRLxREoawxLs=;
        b=OrPO2KqqxwOo1e5wAltdN9DXCnJOBD9/Fx8EaVwAuwldV66f9/Kf8714WQrUK3UB2umhvX
        k8KxmJYFNHpozT7dkh8GLS16d/eH7ttFwBZ6xNqBIb9EuOmk8UfXBE3jt52Fle9J1Zew+u
        oR3/Tn9RSFFdhI3XazTeB/y+Zj5N/J0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-MSdU1lxNOBOve_zhLZmQTQ-1; Tue, 29 Jun 2021 12:35:06 -0400
X-MC-Unique: MSdU1lxNOBOve_zhLZmQTQ-1
Received: by mail-wr1-f71.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so2272643wrq.15
        for <selinux@vger.kernel.org>; Tue, 29 Jun 2021 09:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFtEvrlVui7BaqyBqVH/Nri0P4QA4rILRLxREoawxLs=;
        b=Fm/K++QZ4tdlmbIIukUSzidBBmzHn+8tbNh6auhf209WKsBso4RHdi07k9k+q4PTmd
         AQs8NkQJfVUkJa5UvZT2z4tOO+oYnLuaXP0k+D7a5fEYZx8fLyK9MzspL9DbynNVK8nw
         omiQ7yUsEzuQDovyBUZgMIUQWFXd8D5eOxraWFtuEcAECNSL4iQGzJFtryLxgStVe++/
         nEaZhbkUN6L0vfjVOAwRmvQMA76GMS0s4eXK9R6P/eojHw8seD01HmYXeIgfPrhwmQUN
         WSCKzw3+pIg4JYePAN8B/JdJkyQbYzlZU2quHdo+HAAG17QpY3R/oN/6XGSiexXFCzQp
         crtA==
X-Gm-Message-State: AOAM5307OKSgPMx8AgrFB/2PnzwENz+7Jt8tuB8qppaWwjM0hxQpr4Lv
        D3qX45cTALMyo6+p3xbMMiStgWubJbShjZdlDn/upXBLnp+SS0a6JwZe98yjbH8KrlN/WLjZAku
        oRZELqxMuxCKfSRZcTw==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr6664206wml.46.1624984505138;
        Tue, 29 Jun 2021 09:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbXpe6YhaxmyBREWJcgIymhFJ1te792D2kTWPT4Yam7vgoBla33uYBYbd6hpfHa5vYENMtew==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr6664187wml.46.1624984504942;
        Tue, 29 Jun 2021 09:35:04 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id f2sm9166880wrd.64.2021.06.29.09.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:35:04 -0700 (PDT)
Date:   Tue, 29 Jun 2021 17:35:02 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, dwalsh@redhat.com,
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
Message-ID: <YNtLtkkDMWye485A@work-vm>
References: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Casey Schaufler (casey@schaufler-ca.com) wrote:
> On 6/29/2021 8:20 AM, Vivek Goyal wrote:
> > On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
> >
> > [..]
> >>>>>> User xattrs are less protected than security xattrs. You are exposing the
> >>>>>> security xattrs on the guest to the possible whims of a malicious, unprivileged
> >>>>>> actor on the host. All it needs is the right UID.
> >>>>> Yep, we realise that; but when you're mainly interested in making sure
> >>>>> the guest can't attack the host, that's less worrying.
> >>>> That's uncomfortable.
> >>> Why exactly?
> >> If a mechanism is designed with a known vulnerability you
> >> fail your validation/evaluation efforts.
> > We are working with the constraint that shared directory should not be
> > accessible to unpriviliged users on host. And with that constraint, what
> > you are referring to is not a vulnerability.
> 
> Sure, that's quite reasonable for your use case. It doesn't mean
> that the vulnerability doesn't exist, it means you've mitigated it. 
> 
> 
> >> Your mechanism is
> >> less general because other potential use cases may not be
> >> as cavalier about the vulnerability.
> > Prefixing xattrs with "user.virtiofsd" is just one of the options.
> > virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
> > We have not chosen that because we don't want to give it CAP_SYS_ADMIN.
> >
> > So other use cases which don't like prefixing "user.virtiofsd", can
> > give CAP_SYS_ADMIN and work with it.
> >
> >> I think that you can
> >> approach this differently, get a solution that does everything
> >> you want, and avoid the known problem.
> > What's the solution? Are you referring to using "trusted.*" instead? But
> > that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.
> 
> I'm coming to the conclusion that xattr namespaces, analogous
> to user namespaces, are the correct solution. They generalize
> for multiple filesystem and LSM use cases. The use of namespaces
> is well understood, especially in the container community. It
> looks to me as if it would address your use case swimmingly.

Yeh; although the details of getting the semantics right is tricky;
in particular, the stuff which clears capabilitiies/setuid/etc on writes
- should it clear xattrs that represent capabilities?  If the host
  performs a write, should it clear mapped xattrs capabilities?  If the
namespace performs a write should it clear just the mapped ones or the
host ones as well?  Our virtiofsd code performs acrobatics to make
sure they get cleared on write that are painful.

Dave

> >
> > Thanks
> > Vivek
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

