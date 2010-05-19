MIME-Version: 1.0
In-Reply-To: <1274281931.1143.148.camel@moss-pluto.epoch.ncsc.mil>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
	 <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTikDEXmWbKQMp_clbGxCVoqpxwp21sUPmF0oaC_d@mail.gmail.com>
	 <1274276003.1143.74.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTim9goaYNqDSrQZtfOWJWMywBFV-fPieBJEXYfir@mail.gmail.com>
	 <1274281931.1143.148.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 19 May 2010 20:27:49 +0500
Message-ID: <AANLkTim39ccwJAroJoAmKc2NsbUl3V1ISlx2Rnfm9PMX@mail.gmail.com>
Subject: Re: How to cross install policy store?
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> Very useful information. I have another question ... will a module
>> built on build host with one version of policy compatible to load with
>> another policy version running on the target?
>
> Policy modules have their own versioning; you can see what module
> versions are supported by your libraries and policy compiler via
> checkmodule -V on both the build host and the target host.
>
> If checkmodule on the build host supports a newer version of modules
> than the libraries on the target host, then (just like the corresponding
> case for kernel policy versions) you'd need to generate the older module
> version for the target system.  While that should be supported already
> by the libraries, I don't think we have a build.conf or a semanage.conf
> setting today that would specify the output module version, and
> checkmodule doesn't appear to support the -c switch.  So someone would
> have to code up the support for doing that.  In the interim, I think
> your only option for this case is to install a private copy of the same
> selinux userspace as the target on the build host and use that to
> compile your modules so that the versions will be compatible.

How can we deny the usefulness of building the module on the target at
this point? This is where my mind is stuck. I query the available
interfaces on target and send a policy that will build with those
interfaces using package manager and it's post and pre scripts for the
package in context. Are there any weaknesses here that I am
overlooking.

> If checkmodule on the build host supports an older version of modules
> than the libraries on the target host, you have two options as with the
> corresponding case for kernel policy versions.  You can just generate
> the older module version and use that on the target system (at a
> possible cost in newer features in the newer module format), or you can
> install a private copy of the selinux userspace from the target on the
> build host and use that to generate the newer module version.

>> Can we have policy modules, interfaces and booleans without reference policy?
>
> Booleans are a policy primitive directly supported by the kernel.
> Modules are an abstraction supported by the policy toolchain (selinux
> userspace).  Interfaces are an abstraction supported by the refpolicy,
> but they are implemented just via m4 macros.
>
> So you can certainly use booleans and modules apart from refpolicy, and
> whatever policy you create is free to define and use macros for
> convenience (hence interfaces).

Before I can learn m4 or something similar and get command over policy
writing I think experimenting with reference policy is suitable.

Performance is not an issue as such on our end.

> Reference policy is just a specific policy configuration and associated
> build infrastructure.


-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
