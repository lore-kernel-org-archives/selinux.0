Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4GLJjJ0016389
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 17:19:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id m18so1270540lfj.0
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 14:19:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494969093.21557.20.camel@tycho.nsa.gov>
References: <20170512164423.17190-1-sds@tycho.nsa.gov>
 <CAHC9VhTcuba55YGaTFg0r8AewE9MXovhHpmnpYSc0D4ZCbLg7g@mail.gmail.com>
 <1494969093.21557.20.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 May 2017 17:19:41 -0400
Message-ID: <CAHC9VhQjJ8qG2hYEvD9aJFN5hnp5durLffB-M1W8SJ+CyD=DQA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log policy capability state when a policy is
 loaded
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 16, 2017 at 5:11 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-05-16 at 16:56 -0400, Paul Moore wrote:
>> On Fri, May 12, 2017 at 12:44 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > Log the state of SELinux policy capabilities when a policy is
>> > loaded.
>> > For each policy capability known to the kernel, log an
>> > informational
>> > message with the policy capability name and the value set in the
>> > policy.
>> > For policy capabilities that are set in the loaded policy but
>> > unknown
>> > to the kernel, log a warning with the policy capability index,
>> > since
>> > this is the only information presently available in the policy.
>> >
>> > Sample output with a policy created with a new capability defined
>> > that is not known to the kernel:
>> > [   43.812265] SELinux:  policy capability network_peer_controls=1
>> > [   43.812266] SELinux:  policy capability open_perms=1
>> > [   43.812266] SELinux:  policy capability extended_socket_class=1
>> > [   43.812267] SELinux:  policy capability always_check_network=0
>> > [   43.812267] SELinux:  policy capability cgroup_seclabel=0
>> > [   43.812268] SELinux:  unknown policy capability 5
>> >
>> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> > v2 drops the Resolves line since I think we are not supposed to
>> > include
>> > bug tracking info in upstream kernel commit messages (correct me if
>> > wrong).
>> >
>> >  security/selinux/include/security.h |  2 ++
>> >  security/selinux/selinuxfs.c        | 13 ++-----------
>> >  security/selinux/ss/services.c      | 23 +++++++++++++++++++++++
>> >  3 files changed, 27 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/security/selinux/include/security.h
>> > b/security/selinux/include/security.h
>> > index f979c35..c4224bb 100644
>> > --- a/security/selinux/include/security.h
>> > +++ b/security/selinux/include/security.h
>> > @@ -76,6 +76,8 @@ enum {
>> >  };
>> >  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>> >
>> > +extern char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
>> > +
>> >  extern int selinux_policycap_netpeer;
>> >  extern int selinux_policycap_openperm;
>> >  extern int selinux_policycap_extsockclass;
>> > diff --git a/security/selinux/selinuxfs.c
>> > b/security/selinux/selinuxfs.c
>> > index ce71718..ea2da91 100644
>> > --- a/security/selinux/selinuxfs.c
>> > +++ b/security/selinux/selinuxfs.c
>> > @@ -41,15 +41,6 @@
>> >  #include "objsec.h"
>> >  #include "conditional.h"
>> >
>> > -/* Policy capability filenames */
>> > -static char *policycap_names[] = {
>> > -       "network_peer_controls",
>> > -       "open_perms",
>> > -       "extended_socket_class",
>> > -       "always_check_network",
>> > -       "cgroup_seclabel"
>> > -};
>> > -
>> >  unsigned int selinux_checkreqprot =
>> > CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
>> >
>> >  static int __init checkreqprot_setup(char *str)
>> > @@ -1750,9 +1741,9 @@ static int sel_make_policycap(void)
>> >         sel_remove_entries(policycap_dir);
>> >
>> >         for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
>> > -               if (iter < ARRAY_SIZE(policycap_names))
>> > +               if (iter < ARRAY_SIZE(selinux_policycap_names))
>> >                         dentry = d_alloc_name(policycap_dir,
>> > -                                             policycap_names[iter]
>> > );
>> > +                                             selinux_policycap_nam
>> > es[iter]);
>> >                 else
>> >                         dentry = d_alloc_name(policycap_dir,
>> > "unknown");
>> >
>> > diff --git a/security/selinux/ss/services.c
>> > b/security/selinux/ss/services.c
>> > index 60d9b02..0abdec2 100644
>> > --- a/security/selinux/ss/services.c
>> > +++ b/security/selinux/ss/services.c
>> > @@ -70,6 +70,15 @@
>> >  #include "ebitmap.h"
>> >  #include "audit.h"
>> >
>> > +/* Policy capability names */
>> > +char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>> > +       "network_peer_controls",
>> > +       "open_perms",
>> > +       "extended_socket_class",
>> > +       "always_check_network",
>> > +       "cgroup_seclabel"
>> > +};
>> > +
>> >  int selinux_policycap_netpeer;
>> >  int selinux_policycap_openperm;
>> >  int selinux_policycap_extsockclass;
>> > @@ -1986,6 +1995,9 @@ static int convert_context(u32 key,
>> >
>> >  static void security_load_policycaps(void)
>> >  {
>> > +       unsigned int i;
>> > +       struct ebitmap_node *node;
>> > +
>> >         selinux_policycap_netpeer =
>> > ebitmap_get_bit(&policydb.policycaps,
>> >                                                   POLICYDB_CAPABILI
>> > TY_NETPEER);
>> >         selinux_policycap_openperm =
>> > ebitmap_get_bit(&policydb.policycaps,
>> > @@ -1997,6 +2009,17 @@ static void security_load_policycaps(void)
>> >         selinux_policycap_cgroupseclabel =
>> >                 ebitmap_get_bit(&policydb.policycaps,
>> >                                 POLICYDB_CAPABILITY_CGROUPSECLABEL)
>> > ;
>> > +
>> > +       for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
>> > +               pr_info("SELinux:  policy capability %s=%d\n",
>> > +                       selinux_policycap_names[i],
>> > +                       ebitmap_get_bit(&policydb.policycaps, i));
>> > +
>> > +       ebitmap_for_each_positive_bit(&policydb.policycaps, node,
>> > i) {
>> > +               if (i >= ARRAY_SIZE(selinux_policycap_names))
>> > +                       pr_warn("SELinux:  unknown policy
>> > capability %u\n",
>> > +                               i);
>>
>> Should this really be KERN_WARN?  An undefined policy capability may
>> be odd, but it doesn't seem like it warrants "warning" status; while
>> not quite apples-to-apples, missing classes/perms are displayed with
>> KERN_NOTICE.
>
> If the kernel does not support a policy capability that was enabled in
> the policy, then it may not be capable of enforcing the policy as
> intended, and may therefore be operating insecurely (e.g. consider if
> your kernel was too old to support network_peer_controls or
> always_check_network or open_perms but your policy has enabled them and
> is relying on those checks to be present) ...

Well, I think the key is "may"; depending on the policy capability and
the handle_unknown setting things might not fail in an insecure
manner, but the system would definitely behave strangely.  Regardless,
I see your point and I'm now wondering if we should just fail the
policy load if we detect any policy capabilities beyond what we know
about.

> With undefined classes/perms, the behavior is governed by
> handle_unknown, so a policy built with handle_unknown=allow has already
> accepted the potential for unknown classes/permissions being allowed,
> while a policy built with handle_unknown=deny will fail closed/safe and
> thus not degrade in security.  Arguably though maybe those ought to be
> warnings too.

Possibly.  I'm less worried about that.

-- 
paul moore
www.paul-moore.com
