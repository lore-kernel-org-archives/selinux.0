Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_TVD_FUZZY_SECURITIES,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E6AC433F5
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4696460F45
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbhIFO4j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 10:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239634AbhIFO4i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Sep 2021 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630940133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuJQ3d86zOdSndkgpNKh8Y22Hrim56ARoO6+9G+J+AQ=;
        b=MgG8y6zFwCDaMQwcj+PNVJcgsl9uW5tnqXVzmeQuFqviRGaQ1BV11tLruvfjAr/6TE/ZbX
        xhm4aNPSVr92kcUoHWDH2Sbg5XbjJVr7V856Ht5234GlDDXG6Pxz5zPVvvNqEdV/7PAfEn
        b1bIe0o0wd4dBda4/pM41K07fLHudhw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-yuGcXoGxMf6OJr0GTQvTRA-1; Mon, 06 Sep 2021 10:55:32 -0400
X-MC-Unique: yuGcXoGxMf6OJr0GTQvTRA-1
Received: by mail-wm1-f71.google.com with SMTP id p29-20020a1c545d000000b002f88d28e1f1so2423193wmi.7
        for <selinux@vger.kernel.org>; Mon, 06 Sep 2021 07:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuJQ3d86zOdSndkgpNKh8Y22Hrim56ARoO6+9G+J+AQ=;
        b=E8qu096VEmJB/k47sIpL4K6AZRSSXdzBOd1Hb5QNY/dHelivGCYrT9gqdaicoqqrXj
         8pv5QN/zsjkCbdh9p+4Z5Bml0JtKIeoFctWMZIuwvg1z5z6t3d0a+Ox0CJb/I9zbXFfL
         NFkNdVEQ9sK8OlcdHK/KezreYlGkm5/PYpBwOzu31QR+0edXgUEW4gs2uhWV/FzDdPqp
         dTlwwjDYtFbeX163GyCNspHD8RXLgCfjjsjeQjOcnLOTeiPfc1ac2n5dIPJtVg7IBHWD
         DCD5AEDwcXD5m+Bsaq7h3Pkdh8lcBIf8s+x782tf0AZvCNMCP3iB7pCFQhvB1QULwjPa
         TvJw==
X-Gm-Message-State: AOAM532rtcdPus3xTDcO27t8kA+dZPsC0GAyrCsvgIReP0J0m+AsAiCm
        wnJkV+eJMmmGyjpAxwL2MwEfrMitPOJdPLkh4GZQUDscswr4/lDNsCVC8e6t75pryJv2WWN58EZ
        AH1+WMUT2Q3vaF3QGkw==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr12111944wmj.85.1630940131320;
        Mon, 06 Sep 2021 07:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7G11soewZleZXFNlU6hNQkMzaIZ61i+xkpkLePDsamNTU1MoFcHYNhJ0ALCPN/xHIpE8IAg==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr12111916wmj.85.1630940131068;
        Mon, 06 Sep 2021 07:55:31 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id o5sm8023611wrw.17.2021.09.06.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 07:55:30 -0700 (PDT)
Date:   Mon, 6 Sep 2021 15:55:28 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YTYr4MgWnOgf/SWY@work-vm>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com>
 <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Casey Schaufler (casey@schaufler-ca.com) wrote:
> On 9/2/2021 1:06 PM, Vivek Goyal wrote:

> >  If LSMs are not configured,
> > then hiding the directory is the solution.
> 
> It's not a solution at all. It's wishful thinking that
> some admin is going to do absolutely everything right, will
> never make a mistake and will never, ever, read the mount(2)
> man page.

That is why we run our virtiofsd with a sandbox setup and seccomp; and
frankly anything we can or could turn on we would.

> > So why that's not a solution and only relying on CAP_SYS_ADMIN is the
> > solution. I don't understand that part.
> 
> It comes back to your design, which is fundamentally flawed. You
> can't store system security information in an attribute that can
> be manipulated by untrusted entities. That's why we have system.*
> xattrs. You want to have an attribute on the host that maps to a
> security attribute on the guest. The host has to protect the attribute
> on the guest with mechanisms of comparable strength as the guest's
> mechanisms.

Can you just explain this line to me a bit more: 
> Otherwise you can't trust the guest with host data.

Note we're not trying to trust the guest with the host data here;
we're trying to allow the guest to store the data on the host, while
trusting the host.

> 
> It's a real shame that CAP_SYS_ADMIN is so scary. The capability
> mechanism as implemented today won't scale to the hundreds of individual
> capabilities it would need to break CAP_SYS_ADMIN up. Maybe someday.
> I'm not convinced that there isn't a way to accomplish what you're
> trying to do without privilege, but this isn't it, and I don't know
> what is. Sorry.
> 
> > Also if directory is not hidden, unprivileged users can change file
> > data and other metadata.
> 
> I assumed that you've taken that into account. Are you saying that
> isn't going to be done correctly either?
> 
> >  Why that's not a concern and why there is
> > so much of focus only security xattr.
> 
> As with an NFS mount, the assumption is that UID 567 (or its magically
> mapped equivalent) has the same access rights on both the server/host
> and client/guest. I'm not worried about the mode bits because they are
> presented consistently on both machines. If, on the other hand, an
> attribute used to determine access is security.esprit on the guest and
> user.security.esprit on the host, the unprivileged user on the host
> can defeat the privilege requirements on the guest. That's why.

We're OK with that; remember that the host can do wth it likes to the
guest anyway - it can just go in and poke at the guests RAM if it wants
to do something evil to the guest.
We wouldn't suggest using a scheme like this once you have
encrypted/protected guest RAM for example (SEV/TDX etc)

> >  If you were to block modification
> > of file then you will have rely on LSMs.
> 
> No. We're talking about the semantics of the xattr namespaces.
> LSMs can further constrain access to xattrs, but the basic rules
> of access to the user.* and security.* attributes are different
> in any case. This is by design.

I'm happy if you can suggest somewhere else to store the guests xattr
data other than in one of the hosts xattr's - the challenge is doing
that in a non-racy way, and making sure that the xattr's never get
associated with the wrong file as seen by a guest.

> >  And if LSMs are not configured,
> > then we will rely on shared directory not being visible.
> 
> LSMs are not the problem. LSMs use security.* xattrs, which is why
> they come up in the discussion.
> 
> > Can you please help me understand why hiding shared directory from
> > unprivileged users is not a solution
> 
> Maybe you can describe the mechanism you use to "hide" a shared directory
> on the host. If the filesystem is mounted on the host it seems unlikely
> that you can provide a convincing argument for sufficient protection.

Why? What can a guests fs mounted on the host, under one of the
directories that's already typically used for container fs's do - it's
already what fileservers, and existing container systems do.

Dave



> >  (With both LSMs configured or
> > not configured on host). That's a requirement for virtiofs anyway. 
> > And if we agree on that, then I don't see why using "user.*" xattrs
> > for storing guest sercurity attributes is a problem.
> >
> > Thanks
> > Vivek
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

