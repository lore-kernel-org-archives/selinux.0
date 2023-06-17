Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48BEB64D9
	for <selinux@archiver.kernel.org>; Sat, 17 Jun 2023 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFQSJM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 17 Jun 2023 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQSJL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 17 Jun 2023 14:09:11 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0191736;
        Sat, 17 Jun 2023 11:09:09 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-78f628079eeso85155241.1;
        Sat, 17 Jun 2023 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687025348; x=1689617348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fssKiLo5AVO4HeBr8JKIr7Y8dQEVklO//1RgZvvAsVY=;
        b=Jeb/J32voZAobEpZ1sEciPivSAbRuXNRhV1E5/6H0gdfoO8WLJLvKHn5aLjyoZaPAl
         WTdW0814NenYi2Oc8HVrq14MawaoKMZ6i9yK2x36ro4Olb74QmFCDx0hnvVcasP7fPvo
         z4epV771ISeDW2+KKLy8YV7rksT8a+1IT4oNb3Svh1n9+2VdP7h+rwBIiOKn0+abqosa
         zIV4qvVVHz3RhcaZyjAr1i0QhpPAEFZxWz/2ENIaHvbcvLN5zk2a9+v4aJoHxQGpIY0E
         IrBB8R0H/285ZGMeklp2POedgw2UTGxhsjLoomMBEhlwmbc4d8tUKWTBDS/PE9PrQHL4
         BiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687025348; x=1689617348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fssKiLo5AVO4HeBr8JKIr7Y8dQEVklO//1RgZvvAsVY=;
        b=NXqd1UTsFckajQYr+UmbJQ3YwPRsm9t+/3Hdy0h4AxjWNn/OIO6WthqHWlu4Sky2CR
         s102JHUAHzd+MlHYJiJOl/uxem4dG0Jh1dh2SBJhBHjHmtZiLu+DyCjZh25JpcbW0Pem
         /3v+LECt7uXeDu2MpMnpdwQ95Mrs9sxeQrAc/tsBw/QpkgsJMgI7QUQX+yrOZyN4aa+Y
         CIC6qb9XDT5Q6A0DJpBE06CVLZiMpadbirXphc6DIhiF9iM7NgdQPoFqUhna7cKVBVZC
         09pSIPL/iMKBZRHeyc+z/4cCKEejBjox1A12WMOxcU4Cp5l6nza0rjp3eZSlW91/PdC8
         d01g==
X-Gm-Message-State: AC+VfDxDD1QDRBg3VSXkZrPl2ykXN+OJjVVLpxw5a9/rpwL1+tUT3rS4
        gROzI7S/i2DaIPDP0iw7xd5G8dJirk3/swcYrGxBdo6z2WmGfqv6
X-Google-Smtp-Source: ACHHUZ6MCOqdgWG+X/WQsn+Yd5PE/2ds7SRWQYX4MsGAy14DV31b1AHafqaXMPsDCxC3dV/HRb+FmeUZ6p4pKDVCJKc=
X-Received: by 2002:a67:bb0d:0:b0:440:a760:dc9d with SMTP id
 m13-20020a67bb0d000000b00440a760dc9dmr430081vsn.16.1687025348166; Sat, 17 Jun
 2023 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRAXQyzG7OsgXQfWT09qEFQRmeN2foGLGnU8cHdRKePUA@mail.gmail.com>
 <87r0qcotc0.fsf@redhat.com>
In-Reply-To: <87r0qcotc0.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 17 Jun 2023 20:08:57 +0200
Message-ID: <CAJ2a_Dd0EM10WsgrEGY_SUh3L444d23_T1F36pphdJDnk_DSLg@mail.gmail.com>
Subject: Re: SELinux and systemd integration
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 16 Jun 2023 at 07:43, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Paul Moore <paul@paul-moore.com> writes:
>
> > Hello all,
> >
> > Amongst Christian's various other SELinux contributions, over the past
> > several years Christian has been working on improving the SELinux
> > integration in systemd.  One of the things that Christian has been
> > working on is revamping the SELinux permissions that systemd uses for
> > unitfile operations, both to resolve problems and generally improve
> > the mapping of permissions to systemd operations.  As this work has
> > been languishing for several years, I would like to see if we can get
> > things "unstuck" by proposing two things:
> >
> > 1. I've provided links to the systemd GH PRs below, but I think it
> > might be helpful if Christian could provide a quick summary of the new
> > permissions, how they map to systemd operations, and how they map to
> > the existing SELinux/systemd permissions with a focus on helping
> > policy developers migrate existing SELinux policies.
> >
> > 2. Given the significance of systemd to modern Linux distributions, I
> > think it might be a good idea if we selected a SELinux "liaison" for
> > the systemd project.  This person, or group of people, would work with
> > the systemd folks to keep the SELinux integration in good working
> > order, review systemd code as necessary, and help represent the
> > SELinux project within systemd.
> >
> > How does that sound to everyone?  If we are in agreement on #2, and
> > assuming he would be willing to help out, I would like to nominate
> > Christian as our SELinux liaison to systemd; any objections?  Anyone
> > else interested in helping out?
>
> I agree with the Christian's nomination.
>
> As for #1, I looked on both, but I have to admit that I had a lack of
> understanding of the problem and so I would need some time to get
> into it. Therefore I postponed it due to other priorities, (but never
> come back). If it's still open I'll focus on it next week.
>
>
> > For reference, Christian's systemd PRs on GH:
> > * https://github.com/systemd/systemd/pull/10023
> > * https://github.com/systemd/systemd/pull/20387
> >
>
> Thanks,
>
> Petr
>

Hi all,

Thanks Paul for attracting some attention to the SELinux integration
of systemd.  It has been several months since I last worked on the
systemd related patches, so they all need a rebase and another round
of testing.

Addressing the first point, here are some details about the changes I
would like to see in systemd.  There are some systemd specific ones
and some which also affect other object managers, e.g. D-Bus.


I. Re-add SELinux checks for unit install operations

systemd v190 introduced SELinux checks for unit install operations,
like enabling a unit.  This is useful to limit the access of daemons,
which are running as root and having access to systemd via the D-Bus
connection.  The related security class is `service { start stop
status reload enable disable }` used by both the Reference Policy and
the Fedora one.
Due to an internal refactoring the checks for unit install operations
were dropped in systemd v225[1], so starting or stopping a unit is
still subject to a SELinux check but en-/disabling or un-/masking are
not.  Reintroducing those checks was the initial intention for my
patches.

The most recent pull request targeting this issue is #20387[2] (it
contains some additional changes I am going to talk about in the next
section).

Migration and compatibility with regard to SELinux policies depend on
the individual policy.
When they do not define the security class `service` or its
permissions `enable` and `disable` the policy setting deny_unknown
will determine whether the proposed checks are granted or denied.
Both the Reference Policy and the Fedora one however do define those
two permissions.  For generic access they use the permission macros
`manage_service_perms` and `all_system_perms
` (which include `enable` and `disable`), so the sysadm and unconfined
domains should continue to work fine.  Individual module interfaces,
especially in the reference policy, might need some tweaks in the case
a caller is actually en-/disabling a unit, as they commonly use the
lone permissions `start` and/or `stop` directly.


II. Introduction of two new unit permissions

Even with the re-introduction of the unit install operations several
other unit operations are still not subject to any SELinux check:
  * applying a preset to a unit (`systemctl preset <unit>`)
  * reverting a unit (`systemctl revert <unit>`)
  * modifying dependencies of a unit (`systemctl add-wants/add-requires <unit>`)
All of them might influence the behavior of a unit and therefore
should from a SELinux point of view not be granted by default to all
root user D-Bus clients of systemd.

To address them the last commit of #20387[2] introduces two new
permissions to the security class `service` and `system`: `preset` and
`modify`.
The same commit also changes the permission for modifying systemd
internal settings (via the D-Bus interface
org.freedesktop.DBus.Properties) from currently `reload` to the newly
added permission `modify`.  This allows a more fine-grained access.
During my last test run setting the log level or target was an example
for such a setting modification (I'll retest after the rebase).

Regarding compatibility any policy with a policy setting of
`deny_unknown allow` will not break, such as the Reference Policy and
the Fedora Policy.
They should however consider adding and using the added permissions
(mainly by adding both to the permission macro
`manage_service_perms`), otherwise the previously checked setting of
systemd properties will be allowed by default (for root user D-Bus
clients of systemd).  Confined usage of the new permissions might
hopefully be quite uncommon affecting only very few domains.


III. Add SELinux checks for systemd-logind D-Bus interfaces

Over the years logind gained a lot of functionality[3].  Also from my
experience various services talk to logind over D-Bus.  So it might to
be a good candidate to add some checks around the more invasive D-Bus
interfaces of logind, especially everything related to reboot handling
and session management (used by pam_systemd(8) clients like sshd or
local_login), again to limit the default access of root user D-Bus
clients.

There is no actual proposal patch yet for this, only an ancient
work-in-progress branch[4].

Compatibility should be trivial for policies with `deny_unknown` set
to `allow` (like Reference Policy and Fedora Policy) since all
potential checks will be against an entire new security class.
Otherwise mainly the sysadm and unconfined domains as well as
pam_systemd(8) clients need adjusting.


IV. Improve audit fields on SELinux denials

This topic is not specific to systemd but affects all SELinux object
managers which perform access control on third party subjects, but
systemd is probably the most affected one (together with D-Bus
(reference implementation and dbus-broker).

Today's audit messages from SELinux denials in object manager look
like the following:

    # dbus-broker
    type=USER_AVC msg=audit(22/09/22 16:58:47.569:313) : pid=789
uid=dbus auid=unset ses=unset
subj=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 msg='avc:
granted  { send_msg } for
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 tclass=dbus
exe=/usr/bin/dbus-broker sauid=dbus hostname=? addr=? terminal=?'

    # systemd
    type=USER_AVC msg=audit(22/09/22 15:35:47.847:132) : pid=1
uid=root auid=unset ses=unset subj=system_u:system_r:init_t:s0
msg='avc: granted { reload } for auid=unset uid=root gid=root
cmdline="" function="method_reload"
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:system_r:init_t:s0 tclass=system
exe=/usr/lib/systemd/systemd sauid=root hostname=? addr=? terminal=?'

They contain the subject and target context relevant for policy rules,
but are missing some information to improve understanding the cause of
the denial.  For example the PID, command or executable name of the
actual subject is not included.  Also in the case of systemd the
embedded message contains a duplicated `auid` field and reuses the
field names `uid` and `gid`.

The kernel part of the USER_AVC messages provide the following:
  - pid=789 : the PID of the message issuer (not of the process
subject to the failed SELinux check)
  - uid=dbus : UID of the message issuer
  - auid=unset : AUID of the message issuer
  - ses=unset : session ID of the message issuer
  - subj=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 : security
context of the message issuer
  - msg='...' : the message of the issuer

Libselinux (src/avc.c:avc_audit()) provides a message formatting of

    avc:  granted  { send_msg } for <<<callback-generated-content>>>
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 tclass=dbus

and libaudit (lib/audit_logging.c:audit_log_user_avc_message())
appends the following into the msg field:

    exe=/usr/bin/dbus-broker sauid=dbus hostname=? addr=? terminal=?

So I would like to introduce a recommended way for SELinux object
managers to format the embedded message, supplied via the
selinux_set_callback(3) option SELINUX_CB_AUDIT.  They are recommended
to supply the uid, gid, pid, exe and cmdline of the actual subject.
Also they should supply the auid of the actual subject as the last
argument of audit_log_user_avc_message(3) (and not their own), since
the auid of the issuer is already supplied by the kernel.  To
distinguish the subject related fields they should be unique, either
via a common prefix of just "s" or "subj_", inspired by the current
list of audit event fields[5].  I tried to start a discussion about
that in the audit issue tracker[6] and proposed two pull requests
against systemd[7,8].

A more standardized and verbose USER_AVC output would benefit SELinux
reporting tools like setroubleshoot[9].


Some miscellaneous notes at the end:

The initial pull request of the re-addition of SELinux checks for unit
install operations[10] renamed the security class for systemd manager
access control (currently "system").  This was to split the userspace
portion of this class from the original kernel portion.  It was
dropped to simplify the transition and minimize the code changes.

I am not familiar with all features of systemd and might not be aware
of some classes of issues.  For example there exists a pull request
from Daniel Walsh regarding labels of nspawn containers[11].


Regards,
       Christian


[1]: https://github.com/systemd/systemd/pull/1044
[2]: https://github.com/systemd/systemd/pull/20387
[3]: https://www.freedesktop.org/wiki/Software/systemd/logind/
[4]: https://github.com/systemd/systemd/pull/15245
[5]: https://access.redhat.com/articles/4409591#audit-event-fields-1
[6]: https://github.com/linux-audit/audit-userspace/issues/283
[7]: https://github.com/systemd/systemd/pull/25264
[8]: https://github.com/systemd/systemd/pull/25322
[9]: https://gitlab.com/setroubleshoot/setroubleshoot/-/merge_requests/19
[10]: https://github.com/systemd/systemd/pull/10023
[11]: https://github.com/systemd/systemd/pull/26141
