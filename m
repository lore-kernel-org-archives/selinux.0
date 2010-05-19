MIME-Version: 1.0
In-Reply-To: <1274276003.1143.74.camel@moss-pluto.epoch.ncsc.mil>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
	 <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTikDEXmWbKQMp_clbGxCVoqpxwp21sUPmF0oaC_d@mail.gmail.com>
	 <1274276003.1143.74.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 19 May 2010 19:03:57 +0500
Message-ID: <AANLkTim9goaYNqDSrQZtfOWJWMywBFV-fPieBJEXYfir@mail.gmail.com>
Subject: Re: How to cross install policy store?
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> What if there is a difference of policy versions between the host and
>> target :) Even difference of selinux libs?
>
> Can you run the following on the target system:
> $ cat /selinux/policyvers
>
> And the following on the build host:
> $ checkpolicy -V
>
> The first command shows you the highest policy version that can be
> understood by your kernel.  The kernel can also understand any lower
> version, down to the first version ever supported by Linux 2.6.0
> (version 15), as it provides full backward compatibility.
>
> The second command shows you the policy version range that can be read
> or written by your libraries and policy compiler.
>
> Any policy version supported by the libraries on the target should also
> be loadable on the target, even if the kernel only supports an older
> version.  This is because the libraries will automatically downgrade the
> policy file to the version supported by the kernel at policy load time
> if necessary.  However, given the option, I would directly generate a
> policy version that can be loaded by your kernel without requiring such
> runtime downgrading in order to eliminate a potential cause of failure
> at runtime and an extra in-memory copy of the policy during the
> downgrade process.
>
> If checkpolicy on the build host supports a newer version of policy than
> the kernel on the target, then you can just force it to generate an
> older version.  To specify an older version, you use the -c option to
> checkpolicy, which is automatically used if you specify an
> OUTPUT_POLICY= setting in build.conf for a monolithic policy build.  For
> modular builds, you can specify a policy-version
> in /etc/selinux/semanage.conf to force generation of an older policy
> version, or you can run checkpolicy by hand to later convert the policy,
> e.g.
> checkpolicy -M -c 20 -b policy.24 -o policy.20
> will take a policy.24 file and downgrade it to a policy.20 file for you.
>
> If checkpolicy on the build host supports an older version of policy
> than the kernel on the target, then you have two options:
> 1) Just generate the older policy version - the target will still be
> able to load it due to the backward compatibility.  This is fine as long
> as you don't actually need any of the features introduced in the newer
> policy version. -or-
> 2) Install a private copy of a newer version of the selinux userspace on
> the build host (not overwriting the ones the build host normally uses,
> but e.g. under some other path; we sometimes do this via make
> DESTDIR=/path), and use that private copy to build the policy for the
> target.  That just requires setting up your LD_LIBRARY_PATH, PATH, and
> similar variables when building policy for the target.  Then you can
> generate newer policy versions on the build host for the target without
> affecting anything else on the build host.

Very useful information. I have another question ... will a module
built on build host with one version of policy compatible to load with
another policy version running on the target?

> It depends on how divergent your userspace environment, size
> requirements, and goals are from the ones used for refpolicy.
> Nakamura et al found it difficult to prune refpolicy for their embedded
> SELinux work.

Can we have policy modules, interfaces and booleans without reference policy?


-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
