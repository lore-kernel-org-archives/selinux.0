Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6OBQcuE013557
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 07:26:38 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6OBQbUh019282
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 11:26:37 GMT
Received: by py-out-1112.google.com with SMTP id a78so7414398pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 04:26:37 -0700 (PDT)
Subject: Re: hierarchy_check_constraints() needs reworks?
From: Stephen Smalley <stephen.smalley@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <48881546.6070903@ak.jp.nec.com>
References: <48881546.6070903@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 07:24:19 -0400
Message-Id: <1216898673.3881.4.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-07-24 at 14:38 +0900, KaiGai Kohei wrote:
> I found out that hierarchy_check_constraints() in libsepol
> does not work correctly, as follows:
> 
> ---- example: foo.te ----
> module foo 1.0;
> 
> require {
>         class file { read write getattr setattr ioctl };
> };
> 
> type src;
> type src.child;
> type tgt;
> 
> allow src       tgt : file { read write };
> allow src.child tgt : file { read write getattr setattr };
> ----------
> [root@fedora9 kaigai]# checkmodule -m -M foo.te -o foo.mod
> checkmodule:  loading policy configuration from foo.te
> checkmodule:  policy configuration loaded
> checkmodule:  writing binary representation (version 8) to foo.mod
> [root@fedora9 kaigai]# /usr/sbin/semodule -i foo.pp

Check /etc/selinux/semanage.conf to see if you have expand-check=1 set;
otherwise, there is no hierarchy checking or neverallow checking
occurring there.  Disabled by default in Fedora due to the overhead and
the view that it should be handled at policy build time rather than
insertion time.  refpolicy has a make validate target that runs
semodule_link followed by semodule_expand manually.

> [root@fedora9 kaigai]#
> 
> The "foo.te" can make a hierarchy constraint violation, but we got
> no assertion in this case.
> 
> I inject several printf()s to show internal state, and it shows me
> the given p->te_avtab is empty, so no checks are applied. :-(
> Now, I'm tracing it more.
> 
> 
> In addition, I found two more potential matter in this code.
> 
> The first one is lack of checks for permissions via attribute.
> When a child domain has an attribute which does not applied to
> the parent one, the child can have wider permissions that its
> parent.
> I think any attribute attached to child domain also have to be
> attached to the parent domain.
> (I guess it derived from legacy attribute implementation.)
> 
> The later one is dependencies to the state of boolean.
> Hierarchy constraint allows a child domain to have permissions
> which are enabled for the parent, only if specific boolean is
> turned on. It potentially makes a situation that child domain
> has wider permissions.
> I think it is difficult to check in the policy toolchain, so
> checks on an avc entry creation is better way.
> 
> Any comment?
> 
> Thanks,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
