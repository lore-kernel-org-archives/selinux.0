Date: Fri, 12 Apr 2002 09:06:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412122349.A28382@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204120840060.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Tom wrote:

> I have just installed a new SELinux test machine. It had an SELinux
> earlier, but I deleted that and installed a new one, from the Debian
> packages.
>
> During boot, I get this error message:
>
> security:  starting up (compiled Jan 12 2002)
> security:  loading policy configuration from /ss_policy
> security:  policydb version 8 does not match my version 7
> security:  error while loading /ss_policy, cannot initialize.
> SELinux:  Could not initialize
> Freeing unused kernel memory: 208k freed
> Adding Swap: 498004k swap-space (priority -1)
> security_context_to_sid: called before initial load_policy on unknown context system_u:object_r:policy_config_t

The policydb binary representation changed between the 2001121010 release
(December) and the 2002011718 release (January).  You need to rebuild your
policy configuration with the current version of the checkpolicy policy
compiler, so that the binary representation will be consistent with what
the kernel expects.  Make sure that you have rebuilt checkpolicy from the
new packages and installed it, and then rebuild your policy.

> but my "make install" fails:
>
> arkham:/etc/selinux# make install
> install -m 644 -o root -g root policy /ss_policy
> chsid system_u:object_r:policy_config_t /ss_policy
> system_u:object_r:policy_config_t: Invalid argument
> make: *** [install] Error 1

This is harmless (not the cause of your problem), although it differs from
the upstream SELinux distribution.  Russell appears to have modified the
policy Makefile to always try to relabel /ss_policy after each install,
and the chsid will fail when you install SELinux on a non-SELinux kernel
(but this doesn't matter in that case).  We have a separate relabel target
in the policy Makefile for this purpose (so you can do 'make install
relabel' in policy when on a SELinux kernel, or just 'make install' when
on a non-SELinux kernel).  We have the same kind of support in the utils
Makefile so you can do 'make install relabel' in utils as well when
re-installing the modified daemons and utilities on a SELinux kernel.  It
looks like Russell changed the policy Makefile's relabel target to refer
to setfiles so that he could unify the policy and setfiles Makefiles.

> arkham:/etc/selinux# checkpolicy
> checkpolicy:  loading policy configuration from policy.conf
> security:  5 users, 5 roles, 488 types
> security:  29 classes, 52901 rules
> checkpolicy:  policy configuration loaded

The policy.conf file may be fine, but if you are running the wrong version
of checkpolicy, you'll generate the wrong binary representation.  You need
to build and install the new version of checkpolicy and then build your
policy.

> I also have this error:
>
> arkham:/etc/selinux# load_policy /ss_policy
> security_load_policy: Invalid argument

load_policy only works on a SELinux kernel, since you can't load a policy
into a non-SELinux kernel.

> maybe it's related. Since this fails, I can't relabel:
>
> arkham:/etc/selinux# make relabel
> /usr/bin/load_policy /ss_policy
> security_load_policy: Invalid argument
> make: *** [tmp/load] Error 2

I assume that this is specific to Russell's modified Makefile.  'make
relabel' for setfiles should work fine on a non-SELinux kernel and
shouldn't try to run load_policy.

> I did remove the persistent label things:
>   rm -rf /...security /var/...security

You only need to do this if you were running the non-LSM version of
SELinux, due to a change in the mappings between the non-LSM and LSM
versions of SELinux.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
