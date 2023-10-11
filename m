Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC7CDB47E
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJKWyv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjJKWyu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 18:54:50 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16499D
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 15:54:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so377029276.1
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697064887; x=1697669687; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DTQoBPki/7lbaXItaVKX6uVuJ7GBIgQz1d6eyUe7e6g=;
        b=cYRrg6ZrJu2LprkgIqkxnEHiyswgTjh2fTACeSyZ/+kAoBGHKXag2dZ+d4BbbbVBCN
         gacKdNAb0UAXdd2VJ32SlNAHFhmhNuzsdkxil5BiUGOuuovf5OH/wI1kS3jPys27FsnG
         27FZbpe78YTACTYQhCq3+Dd/lL3DkrN2ZvK+/Gk58emOjl9ZjjaGtj5MipfxLKn3OByj
         7YiJ/wopEcBbTtxcoESnuh/RNfj69tPZtUrhwrZs3C0q1GvUIgc9QCpVjbuJeQJGBD6g
         JDDEjPlJCJ35oQspTUh8juiX9U/kAeRtph7FThDcmi8U+5ZyuWkD+bwfEGSjHIipHO3R
         SMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064887; x=1697669687;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTQoBPki/7lbaXItaVKX6uVuJ7GBIgQz1d6eyUe7e6g=;
        b=Qm2ba6/kdNBbQN9oOdL1H3edwLdH0ak/7RpSFBx4LVhY/4ORerrR4kFIXixfq9QW75
         M9PAl3p4pFXYrUtqABRJnJqh6XjyleexZIxSziKmYF4yJfRuHI7Ae+KEhJ9s/d/KN6sc
         yW7A76dOzdDx9ViSQHd7lrUQK+XjoS6bkmqqdWLrFFuIa461dCC6p2ZKVCETvUaq9iyZ
         Pkw9O1Agfskbj+RcHFoU8BWAeqFjdMejbbbpzDQjSdOLAVDOWVEdj8PA/aZJAPzZMGBT
         sPmGG0EDsF9Y8wpmgFqdD6ZbyMqLqilHQTQaq3m2PoAWkh/qEScNei0sy63k+UfxxbGV
         z1sA==
X-Gm-Message-State: AOJu0YyfxbPE75AniJzaZihPnRoApuwBCvt9gXF7h1DJQbWOah6rmtIF
        dVVmXYszFW+8y61ryfggzRQjPcc51kZMVguST8u6WUEQdiQnOjVqlg==
X-Google-Smtp-Source: AGHT+IGbC1XqrfdKIPCg9qjSq3SQmwFbsdhnmaqt7uqkH/qXBT8JPhcVFatKjZgH14R0TLl0kTmJLLDO0dsNMUalbE4=
X-Received: by 2002:a05:6902:3c5:b0:d9a:5312:dd3f with SMTP id
 g5-20020a05690203c500b00d9a5312dd3fmr6980615ybs.55.1697064887545; Wed, 11 Oct
 2023 15:54:47 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Oct 2023 18:54:36 -0400
Message-ID: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
Subject: RFC: thoughts on SELinux namespacing
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

The SELinux namespace effort has been stuck for several years as we
try to solve the problem of managing individual file labels across
multiple namespaces. Our only solution thus far, adding namespace
specific xattrs to each file, is relatively simple but doesn't scale,
and has the potential to become a management problem as a namespace
specific identifier needs to be encoded in the xattr name.  Having
continued to think about this problem, I believe I have an idea which
might allow us to move past this problem and start making progress on
SELinux namespaces.  I'd like to get everyone's thoughts on the
proposal below ...

THE IDEA

With the understanding that we only have one persistent label
per-file, we need to get a little creative with how we represent a
single entity's label in both the parent and child namespaces.  Since
our existing approach towards SELinux policy for containers and VMs
(sVirt) is to treat the container/VM as a single security domain,
let's continue this philosophy to a SELinux namespace: a child
namespace will appear as a single SELinux domain/type in the parent
namespace, with newly created processes and objects all appearing to
have the same type from the parent's point of view.  From the child
namespace's perspective, everything will behave as they would
normally: processes would run in multiple domains as determined by the
namespace's policy, with files labeled according to the labeling rules
defined in the namespace's policy (e.g. xattrs, context mounts, etc.).
The one exception to this would be existing mounted filesystems that
are shared between parent and child namespaces: shared filesytems
would be labeled according to the namespace which mounted the
filesystem originally (the parent, grandparent, etc.), and those file
labels would be shared across all namespace boundaries.  If a
particular namespace does not have the necessary labels defined in its
policy for a shared filesystem, those undefined labels will be
represented just as bogus labels are represented today
("unlabeled_t").  For this to work well there must be shared
understanding/types between the parent and child namespace SELinux
policies, but if the namespaces are already sharing a filesystem this
seems like a reasonable requirement.

I'll leave this as an exercise for the reader, but this approach
should also support arbitrary nesting.

THOUGHTS ON MAKING IT WORK

One of the bigger challenges here is how to handle the case of the
parent mounting a filesystem for full use by the child namespace
(per-file labeling, etc.).  Above I talked about how filesystems would
be labeled according to the mounting namespace, so if we want to
delegate labeling of the filesystem to a child namespace (without
allowing the child to perform the mount) we need to have a mechanism
to indicate that the mounting namespace is deferring labeling to a
different namespace.  I think the obvious solution to that would be to
add two new mount options: "selinuxns_outer=<label>" and
"selinuxns_owner=<label>".  The "selinuxns_outer" option would
accomplish two things: mark the filesystem for deferred labeling by
another namespace, and establish a single label, similar to a context
mount, that the mounting namespace would see instead of whatever
labeling the filesystem would normally support.  The "selinuxns_owner"
option would specify the domain label of the child namespace, granting
that domain control over whatever labeling is supported by the
filesystem.  In most normal use cases where the child namespace runs
with a single domain/type from the parent's perspective I would expect
"selinuxns_outer" and "selinuxns_owner" to be set to the same value,
although that is not a requirement.

Triggering the creation of a child SELinux namespace, the userspace
API in general, and the implementation work needed to support multiple
views of the same kernel entities is all still very TBD/hand-wavy.  I
wanted to make sure the approach described here made sense first.

THOUGHTS ON POLICY

This is an area where I think the single-label parent view makes it
much easier to develop policy for containing child namespaces.  Since
we want the parent namespace to effectively bound the access of the
child namespace, treating the namespace as a single domain allows the
parent to develop policy independent of what the child's types and
behaviors; the parent simply describes the allowed interactions and
let's the child manage it's own policy and labeling.

Filesystems shared across policy boundaries are somewhat interesting
in that for it to be fully usable it requires every participating
namespace to have the filesystem labels defined in their own policy,
but it does not require each namespace to treat the files in the same
manner.  However, it is important to note that regardless of what a
child namespace might allow in a shared filesystem, it is still
subject to the policy rules of any parent namespaces.

-- 
paul-moore.com
