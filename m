Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C85C0032E
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjJTQQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjJTQQ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 12:16:29 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E610DD
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697818584; bh=H21H4uwkMTARAp98exTgf+26C8gWlEUhtZdEid8aKIY=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=jp3oIr2hHKcJo1OaVLnDeM+7dySNDHB0dNjCYJgSH3pWya7VHksIDDmhOFxM7v4jXfaGcyxZ6683DYKaavQ/4Bhz6b5cHF+4OFwBRHeYnxiJVXS+IJgyEa5oOhKApa6yIEKIpVztb7oKO4YhgQ3fddmFzxBu6p+yvD+hsV/u2le85DDK+ujGBRTFvwsPHYigro9Iz/OM4ganC3g4Jh2ejJhRR7OaXXCglnvIb48ywghksKmxyIW9OdTzQ963UlR/zwcWigh2HS95mffVGPalLFHvjKWOZ7oiOwWSOvtMvFDIpWwy9J1uYd5RnY1BqZ4U/n5LV552UVyZQg47hkQfiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697818584; bh=IuE5j8FiUrSG4t22GGm4wENFa9gD8TDlW2lg6jJKDg2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IRJfVKDSGip2tLAr1taBbsDRvdsEnKJimzCDfwJZn1a2Y4MdDSI3+ac7g6IHiSl6R2CBG5zpsAjfmlVt7Amtwkw0gfvVSAvsC5KynDDdXYk7v/rJBGRgUVaVPHMdNxz4WDK9D+UxgYdxzAinFPPPemVW0QOpoNKODoDpnmVevdePav7vuu91V9jtpsDFSuNLr9Ta+JjvFT/iVQrq1n2/PWJMTPSqFGu2wGTqr3FSYuVe5KMQGdWLeOWSN6yvwukIGDUAUv2XI11j1jk8rv+oDiC15dDkle1rq9yiR1GDHGcIDY7A0AD/DlNuyOakhneJwO2VtszXgN+HYHLJAtvQhQ==
X-YMail-OSG: Qk3Hd.0VM1nQ8920vhFuJbju7gxyK0gwSbx4QAVa_hvpmqUPVd5DRoyTjqgfKwm
 DP1qB8utwSnBGIFvzh_v6QBLnegJtXtvO8BR99PpthNAqndLoCpYIDzh26MSTerx4EiGzIIenXjv
 TM25z8nh3_TMRCuSYXvYBCH1GlygRMrYyzrlb5tiymBVzUYVfO59RXfluj2RHQ4b46ZFENYZnBMx
 YU.plSmZt4fKrX2YXHnxVtuqeXjoilQdt3YsAR1NantbtKXah3LJhiRkDB6MKf7n8njG6KAdWImX
 IiVW2L7fTS7bKu1cwTxVtmjkqYKtcS5UQmxo_sz9hG5Wn41Vj.LEnDfDFgsHIyKmYN4XtEIMZiWV
 RY17lgM3VmehU9030VaoigguCWRy9lCSTMcmOBjo.VMIW7xINoMEY0WpXfQdGID5KSQdBes6EIGR
 .MpsyPjHrxXXEJTVjXSW7SSXiSttcdn1twiFJh1_L4Wk7dWD3d8v5w9cUF_Qac0JBGmoxmLBn8KF
 b.301x01k2z1YarLzyGFRCjc8.nB_OZ9qZe_vFrigAIMVhPwFYt2lpqErmgZdsDpmS4YVxI1YNyu
 abbcd9AbOTxIvmFRh0EhAn.oIIaiGsR397NXiXVHmcs32lK9CJnuyTQbiD709BXtTIbenfIJCDzp
 gOPLo0_NE_X_UEW9CglIgi76gOpbtRHN1vI3AV4lSlTFXYJGNbKgvcH5FsKJxuiatNq7bJRvYPWw
 tbg8Ay9iWkeP8ux6jBe9SUKb5IZax9IiPCKBJq08hIHhPMQDyy4tTDrrd2xJxxW7HgFxWbQ0Y.hD
 Qkx6kmUWxXdeJMLJATqw6paalbdwLDIaoCH6WqFnIpmYbOdBxr9iMsqTT_WPmOnXI5AebwLgwV4i
 HGhICWDkKLl2tfp5iH0ebPfokDIr5r.wJlS7_VkkVBSepL_GtX3cYM4rAdU6rcq39y0MEbWPuXHV
 DgNapZF7UGsYw4jf.5nd5zcASvrWGy2NF2kDeUNUqrScnXWOAitI9Iu3HOLtZWQmWvuOBV.ipuzN
 kBtLyDJUVfPt8Pm8Ff.8DXajR9dGA_TLDRJFbSYBb9EL9vFdFQB735wSNfbrjJ_X3doCCgUMVNiA
 9j9rXQwt.QIFBYI_pGUnY3OtHjCgKt8WtU7TI_VY.00Ur4L0ikxtu.N9ZrEyav3.m_fG4eaXKC6z
 _2zeP7a0uNeJqwzMynd9rW.C4IwWyxwJqKPVxU.CpVbYsC7.4NKFV1huuy73u7wJ3T5a7sQkVkT5
 mz_xVWwrEtypnhJ7iPglBo4TDyva9g0JyGJLDG5T5lWEH0E_wsJtbhFSQwqKrUtHrHwrpf42jIpb
 _0CmNnQANhRfM5pVv9GfV7LBRHQ4v7sgw445qazc5cTtfrLkhngM_1NxE2lM2MSg_Rv_HZ4vk_8q
 aPJOs0w2Lpv056COdJJstMdMLVjJFaBnXbB7eBxkEuq7V6dGGvLZGErutPJRL.QdMu0O2JfIJC6O
 LMR9Y9iSHTlCvJQshz_ggxH__mRRIeUcJ5uTrJ6E76JqQX9HsKMZNrc5ZsVGl8djRe.pSj1P0.5n
 v0GgY3p6yb.TaPChfOEfot3vplHhXOtnoI2hkq2MSnFhRejdO5DDYRUubQeyC1OP9bNeswfyo0.N
 FhDQccx6qkrSq6d_eajB.zFyMalFmO52Ehkok7Fjwy98_4ynu77bRDl5IyGGhE2rQfFTYIB04cdE
 LahFRb6.pSczL6wBnzp6YR1s7s5gzBZb53YiCkhL_SAuznmI.sEzOM_7kN19EIT6DcketeGd2DZ6
 SXh1LQ7w3tg2RQiQlhb4HCIuuhGSdCFForQvicMoG1jSwDW765tz8re4zkZsoOcP.F2lT8b35rbZ
 G3sv_H7peQLoBQy5J2tqyMnPi9Of2onAVOyqZHO9LUY9nZOuep.etIThlepNLDrltEmjU1mwpvlb
 YQ3bRTRhAdYq0EMlSKuDh9OdBhGb77N_G.tyzyDT2Nn2YEG0.sg8qGPXCkQD2bmTJeOZ8UYAdv6d
 IyFNc9_blhdSpgKrcCSCld17.2e73Vjwa2pXrKtW4zy17JGV4qWhf3oQsHSYrvbw_.1hVMypmixg
 galbzoTjaK.Aq34vqwFUwOtsIrmVBOQXV97KEm3a5aXfY76Id6bixqq8zKOK1Hsm5EcjbMFtt7CJ
 Q6cMsYMGn2lZxwVK5471FACYPcbtWTyhWb3XK8hFUdUrC02EJ7Yb9fMOjDcxm4p1RqGt4NtbtCKO
 HofKp5mwA8SD53FBysSvjTc40fb7Amv2Dk6d_7GzApXOgW66muvqratTJmVYHxy5PayK1WjksKz4
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fb1a1a6c-b608-4479-8a18-06eb92c20e6e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 16:16:24 +0000
Received: by hermes--production-ne1-68668bc7f7-bjk24 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1462bd0fa1921a782df01db58e9cdebe;
          Fri, 20 Oct 2023 16:16:24 +0000 (UTC)
Message-ID: <051cde5d-c6ef-4b44-ba0f-ebad382fa656@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 09:16:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: thoughts on SELinux namespacing
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
Content-Language: en-US
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRw9hfx8rBRj4R1e-EELAW2eB8GtkpTzbjqoKGF0Zu20g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/11/2023 3:54 PM, Paul Moore wrote:
> Hello all,
>
> The SELinux namespace effort has been stuck for several years as we
> try to solve the problem of managing individual file labels across
> multiple namespaces. Our only solution thus far, adding namespace
> specific xattrs to each file, is relatively simple but doesn't scale,
> and has the potential to become a management problem as a namespace
> specific identifier needs to be encoded in the xattr name.  Having
> continued to think about this problem, I believe I have an idea which
> might allow us to move past this problem and start making progress on
> SELinux namespaces.  I'd like to get everyone's thoughts on the
> proposal below ...
>
> THE IDEA
>
> With the understanding that we only have one persistent label
> per-file, we need to get a little creative with how we represent a
> single entity's label in both the parent and child namespaces.  Since
> our existing approach towards SELinux policy for containers and VMs
> (sVirt) is to treat the container/VM as a single security domain,
> let's continue this philosophy to a SELinux namespace: a child
> namespace will appear as a single SELinux domain/type in the parent
> namespace, with newly created processes and objects all appearing to
> have the same type from the parent's point of view.  From the child
> namespace's perspective, everything will behave as they would
> normally: processes would run in multiple domains as determined by the
> namespace's policy, with files labeled according to the labeling rules
> defined in the namespace's policy (e.g. xattrs, context mounts, etc.).
> The one exception to this would be existing mounted filesystems that
> are shared between parent and child namespaces: shared filesytems
> would be labeled according to the namespace which mounted the
> filesystem originally (the parent, grandparent, etc.), and those file
> labels would be shared across all namespace boundaries.  If a
> particular namespace does not have the necessary labels defined in its
> policy for a shared filesystem, those undefined labels will be
> represented just as bogus labels are represented today
> ("unlabeled_t").  For this to work well there must be shared
> understanding/types between the parent and child namespace SELinux
> policies, but if the namespaces are already sharing a filesystem this
> seems like a reasonable requirement.
>
> I'll leave this as an exercise for the reader, but this approach
> should also support arbitrary nesting.

An SELinux label is currently made up of several components. You
could add a new "subdomain" component. The subdomain component would
be ignored unless the process is in a namespace, in which case it
would be treated as an additional restriction. All processes in the
namespace could have the same domain as far as the host in concerned.
The subdomain would be propagated in the namespace according to normal
rules. The rules for propagating subdomains on the host could be simple
(e.g. don't do it) or as complex as you like.

It wouldn't be backward compatible, unless there's already mechanism
for ignoring label components that aren't being used.

Just a thought. 

>
> THOUGHTS ON MAKING IT WORK
>
> One of the bigger challenges here is how to handle the case of the
> parent mounting a filesystem for full use by the child namespace
> (per-file labeling, etc.).  Above I talked about how filesystems would
> be labeled according to the mounting namespace, so if we want to
> delegate labeling of the filesystem to a child namespace (without
> allowing the child to perform the mount) we need to have a mechanism
> to indicate that the mounting namespace is deferring labeling to a
> different namespace.  I think the obvious solution to that would be to
> add two new mount options: "selinuxns_outer=<label>" and
> "selinuxns_owner=<label>".  The "selinuxns_outer" option would
> accomplish two things: mark the filesystem for deferred labeling by
> another namespace, and establish a single label, similar to a context
> mount, that the mounting namespace would see instead of whatever
> labeling the filesystem would normally support.  The "selinuxns_owner"
> option would specify the domain label of the child namespace, granting
> that domain control over whatever labeling is supported by the
> filesystem.  In most normal use cases where the child namespace runs
> with a single domain/type from the parent's perspective I would expect
> "selinuxns_outer" and "selinuxns_owner" to be set to the same value,
> although that is not a requirement.
>
> Triggering the creation of a child SELinux namespace, the userspace
> API in general, and the implementation work needed to support multiple
> views of the same kernel entities is all still very TBD/hand-wavy.  I
> wanted to make sure the approach described here made sense first.
>
> THOUGHTS ON POLICY
>
> This is an area where I think the single-label parent view makes it
> much easier to develop policy for containing child namespaces.  Since
> we want the parent namespace to effectively bound the access of the
> child namespace, treating the namespace as a single domain allows the
> parent to develop policy independent of what the child's types and
> behaviors; the parent simply describes the allowed interactions and
> let's the child manage it's own policy and labeling.
>
> Filesystems shared across policy boundaries are somewhat interesting
> in that for it to be fully usable it requires every participating
> namespace to have the filesystem labels defined in their own policy,
> but it does not require each namespace to treat the files in the same
> manner.  However, it is important to note that regardless of what a
> child namespace might allow in a shared filesystem, it is still
> subject to the policy rules of any parent namespaces.
>
