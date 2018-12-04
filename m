Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F63C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236502081C
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 19:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag3TS3C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236502081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeLDTBs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:01:48 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:45828 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLDTBs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 14:01:48 -0500
Received: by mail-qk1-f178.google.com with SMTP id y78so10299354qka.12
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIxFdddZs+0p864BPt0o3zPse4iawipcI+ydFd+8iyY=;
        b=ag3TS3C+ym04gMGeuVjVfaLW/JQuoHgSqIWj0VwU6XnEuHoYYO4pytNUEjOXwplyvM
         wewWP+cxz6iz0zJ+7HMAgLqDZr8PoWgjJrxa+eqj42ARhlaSzCvmKi+Zj0txabLXkoJh
         5bhmBg5Wko+AgOHiTnQaAc9+PfcEzcLhfYFxHqo/5cINgwkNDxZg0sG8itOPyV7uYcj6
         OpnmDSjvDLxi5Pf9F1lmNS/jC4yxsOXWlmC9TJpYSO7438M7eoQ56L3N8HaWnB6O5vM8
         6ztKazLEVHBYt6apzylm9eFta56jVBCMD1c4rXQwdgOix114AH93hivgfYDKTDfbaHQH
         aScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIxFdddZs+0p864BPt0o3zPse4iawipcI+ydFd+8iyY=;
        b=ioKSYlp5Jit2eT63CP8NCKc1qe3ou0om13U7O55jpQ/bdSoYpj5hOub4NY20U/XHYQ
         qdiE84OGa4ZW9E+ekmVWRc4LfH7dLLQEmqz2J8qrLNzLE33f8oToJbwMODb/nxJ4LXCx
         DIbuAbZQvk68LmBHa5vGvA2WGX+gp5z5p7NxWedCQ2SmHE2bV5oqwMkJv1eevjAAAL3z
         ktxNCrw7WS4gfynu8S/yBonUjN+tZXnT2GTAgl8PNovGs2teFIJ3JUlDtktCw54IDOcJ
         E+SnT+Z4lQTSbxUpbSiXC7/FVA28kmByOJrIDH6D0ODyeY29jbOGpMlpYmvhtBdn1xwI
         fxhw==
X-Gm-Message-State: AA+aEWbYqbhDgd0pZeOeMYNPn9OoVGgwbR3rKmbJG6C9a7nVNOTMruzD
        5buDrluuU/RTlB180igz6F9YBgc9MaWgwPfKRzUpOPrA
X-Google-Smtp-Source: AFSGD/VZSneY7zPMhMZHW4cRm0DZecMy81C6INOJf+aVQr3htzorcrJDltyqEYIToYpMpNBPAgxiRrQgURfUGQE8tEo=
X-Received: by 2002:a37:9181:: with SMTP id t123mr19081407qkd.187.1543950107117;
 Tue, 04 Dec 2018 11:01:47 -0800 (PST)
MIME-Version: 1.0
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
 <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov> <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
 <CAFSQBhHMG9cgda3KAo1y6pNWinkKvRAuwTNn6+d3j43Dphozew@mail.gmail.com> <b9924ce3-9039-94d3-71b4-709fdd218d94@tycho.nsa.gov>
In-Reply-To: <b9924ce3-9039-94d3-71b4-709fdd218d94@tycho.nsa.gov>
From:   BMK <bmktuwien@gmail.com>
Date:   Tue, 4 Dec 2018 20:01:35 +0100
Message-ID: <CAFSQBhEXDy5RRXYqNM1Wn8naadrjS2MHO4qf5V=6U2a-AZzg8w@mail.gmail.com>
Subject: Re: SELinux logging problem
To:     sds@tycho.nsa.gov
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 7:37 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 12/4/18 1:00 PM, BMK wrote:
> > On Tue, Dec 4, 2018 at 5:50 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> On 12/4/18 11:38 AM, Stephen Smalley wrote:
> >>> On 12/4/18 11:03 AM, BMK wrote:
> >>>> Hello,
> >>>>
> >>>> I am currently struggling with a strange SELinux problem,
> >>>> for which I am not able to find an answer by reading the documentation
> >>>> and researching online.
> >>>>
> >>>> The problem is, that some AVC denial log entries seem to get lost in
> >>>> permissive mode,
> >>>> in other words, they are not logged...
> >>>> I've already deactivated all dont audit rules and I know for sure that
> >>>> the denial actually occurs, because I can trace it via strace...
> >>>> Although I can't see a corresponding entry in the audit.log.
> >>>> By the way, in enforcing mode I can see suddenly the missing denial
> >>>> entry...
> >>>> If the permissive mode lacks/drops some denials which we can only see
> >>>> in enforcing mode,
> >>>> then this would be truly terrible for the policy writers...
> >>>> Otherwise I am out of ideas, what other things could cause the loss of
> >>>> SELinux denials...
> >>>>
> >>>> I hope you can point me to right direction with this matter and
> >>>> I thank you in advance for your help.
> >>>
> >>> Permissive mode only logs the first instance of a denial by design to
> >>> avoid flooding the logs with repeated instances of the same denial.  So
> >>> if you triggered the denial a while ago and repeat the operation, you
> >>> might not see the denial again.  To be precise, in permissive mode, upon
> >>> the first denial of a permission, the permission is audited and then
> >>> added to the AVC entry so that subsequent denials using that cache entry
> >>> won't keep producing a denial. You can flush the cache to force denials
> >>> to re-appear by reloading policy (load_policy) or by switching back and
> >>> forth between permissive and enforcing mode (setenforce 1 && setenforce 0).
> >>
> >> NB Any semodule operation will also trigger a policy reload (unless you
> >> specify -n or are acting on a policy other than the active one), so
> >> semodule -DB would also have flushed the cache for you when it removed
> >> all dontaudit rules.
> >>
> >>>
> >>> If that doesn't explain the behavior you are seeing, then we can't
> >>> really help without more information about the problem, e.g. the denial
> >>> message you say is visible in enforcing mode but not permissive mode,
> >>> your kernel version, possibly the strace output, a reproducer if you
> >>> have one, what distro / policy you are using, etc.
> >>>
> >>> There are cases where the audit system could drop records due to OOM
> >>> conditions, its ratelimit, or its backlog limit.  In those cases, you
> >>> should have a audit: message logged indicating that messages were lost.
> >>>    Check your dmesg or journalctl logs for such messages from the audit
> >>> system.  Those are audit system issues rather than SELinux.  You can
> >>> configure the limits via auditctl and/or the audit configuration.  But
> >>> generally those only apply when the audit system is under heavy load
> >>> from many denials (or many other audit messages) and you should see at
> >>> least some of them.
> >>
> >
> > Thank you for your quick reply!
> >
> > Let me give you a little bit more details about my setup.
> > I am working on debian 9.4 release with kernel version 4.9.0-6-amd64.
> > I have my own custom policy based on the refpolicy version
> > RELEASE 2 20161023. (it is pretty old but I have to work with that
> > specific version).
> > I am currently building a monolithic policy with dontaudit rules disabled.
> >
> > Now here are the steps to reproduce the logging problem I described above.
> > Let say, I have a test domain foo_t, which is defined roughly as follows:
> >
> > type foo_t;
> > domain_type(foo_t)
> > corecmd_exec_bin(foo_t)
> >
> > Then I login as unconfined_u user and run the following command:
> >
> > runcon -u system_u -r object_r -t foo_t -l s0 mkdir foobar
>
> object_r is only for objects (e.g. files) not for processes, so you
> should never pass it to runcon.  system_r would make sense for a daemon,
> or unconfined_r for a user program launched by an unconfined_u user.
>

Thank you for the tip, but I think it doesn't make difference for my
actual problem.

> >
> > Note that unconfined_t and foo_t actually need little bit more rules to execute
> > the runcon command above, but they are irrelevant for my case...
> >
> > The mkdir binary is selinux aware by which I mean that it loads
> > the libselinux.so shared library.
> > The libselinux library executes upon loading the following syscall:
> > (see https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/init.c#L156)
> >
> > access(SELINUXCONFIG, F_OK)
> >
> > This call would need a search dir permission for selinux_config_t and since
> > the domain foo_t doesn't have the permission I was expecting a denial log entry.
> > But the AVC denial never shows up in the logs in permissive mode.
> > I also tried to empty the logging cache by executing
> > setenforce 1 && setenforce 0, which didn't help.
> > However in enforcing mode the denial is logged as expected.
> >
> > Hope this helps to clarify my question a bit further...
>
> Hmm...this access would be covered by a dontaudit rule normally since
> many programs that link with libselinux don't actually need to access
> /etc/selinux/config.  And in your example above mkdir will work just
> fine without ever using /etc/selinux/config, so it truly isn't needed.
> Thus, silencing the denial is the right thing to do.
>

Yes, I am aware that mkdir still works but I chose it simply as an easily
reproducible example where a search permission denial gets dropped
in permissive mode...

> I suspect that you aren't actually stripping dontaudit rules, or you
> aren't loading the policy you built but instead are loading the one that
> still has the dontaudit rules in place.
>
> sesearch will show you whether there is a dontaudit rule, e.g. sesearch
> --dontaudit -s foo_t -t selinux_config_t.
>
Yes, I double checked it and then I even deleted the corresponding
dontaudit rules
manually from the refpolicy but unfortunately it didn't help.
And as I said, the denial *shows up* in enforcing mode, so I think
dontaudit rule isn't here
the problem...

As next step, I could try this out on other distros...
