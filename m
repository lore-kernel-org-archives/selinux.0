Subject: Re: How to cross install policy store?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTim39ccwJAroJoAmKc2NsbUl3V1ISlx2Rnfm9PMX@mail.gmail.com>
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
	 <AANLkTim39ccwJAroJoAmKc2NsbUl3V1ISlx2Rnfm9PMX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 May 2010 12:46:53 -0400
Message-ID: <1274287613.1143.212.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-19 at 20:27 +0500, Shaz wrote:
> >> Very useful information. I have another question ... will a module
> >> built on build host with one version of policy compatible to load with
> >> another policy version running on the target?
> >
> > Policy modules have their own versioning; you can see what module
> > versions are supported by your libraries and policy compiler via
> > checkmodule -V on both the build host and the target host.
> >
> > If checkmodule on the build host supports a newer version of modules
> > than the libraries on the target host, then (just like the corresponding
> > case for kernel policy versions) you'd need to generate the older module
> > version for the target system.  While that should be supported already
> > by the libraries, I don't think we have a build.conf or a semanage.conf
> > setting today that would specify the output module version, and
> > checkmodule doesn't appear to support the -c switch.  So someone would
> > have to code up the support for doing that.  In the interim, I think
> > your only option for this case is to install a private copy of the same
> > selinux userspace as the target on the build host and use that to
> > compile your modules so that the versions will be compatible.
> 
> How can we deny the usefulness of building the module on the target at
> this point? This is where my mind is stuck. I query the available
> interfaces on target and send a policy that will build with those
> interfaces using package manager and it's post and pre scripts for the
> package in context. Are there any weaknesses here that I am
> overlooking.

I simply answered your question about compatibility if you were to build
the modules on a build host and then ship them to the target system.
Remember that my proposal was to instead build the complete policy on
the build host and only ship the final generated policy to the target
system, thereby avoiding the need for libsemanage, semodule/semanage,
and the module store on the target system at all.  Then we don't care
about module version compatibility (no modules on the target), only
kernel policy version compatibility.

If you are going to require the target system to support modules, then
yes, you could just ship it the source text of the module and compile it
there as long as you are willing to require the target system to have
checkmodule and the policy interface headers installed.  In fact, that
is the current trend in selinux userspace development (look for Source
Policy Support and src-policy in the list archives), although I think
we're still a ways from making that transition.

> Before I can learn m4 or something similar and get command over policy
> writing I think experimenting with reference policy is suitable.

That's fine - I'm not trying to convince you to not use refpolicy, just
making sure you understand that you have other options if it doesn't fit
your goals.

> Performance is not an issue as such on our end.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
