Message-ID: <52724ABC.8020705@tycho.nsa.gov>
Date: Thu, 31 Oct 2013 08:19:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux-NSA <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Split policycoreutils up?
References: <5272491F.2090004@tycho.nsa.gov>
In-Reply-To: <5272491F.2090004@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/31/2013 08:12 AM, Stephen Smalley wrote:
> Hi,
> 
> policycoreutils started life as a minimalist set of utilities required
> for SELinux operation.  It has grown far beyond that, and now includes a
> number of non-essential components.  Some of those components have also
> grown dependencies on external libraries from setools (in particular,
> sepolicy, which is now a dependency for semanage, sandbox, and gui?).
> 
> So I was wondering whether it is worthwhile to split up policycoreutils
> into multiple source packages, or otherwise support a minimalist build
> of it.
> 
> Fedora already generates multiple separate binary packages from it:
> 
> 1) policycoreutils (secon, semodule_*, fixfiles, genhomedircon,
> load_policy, restorecon, run_init, semodule, sestatus, setfiles, setsebool)
> 
> Not sure what relies upon secon that leads to it being included in the
> base package - maybe init scripts? semodule_deps, semodule_expand, and
> semodule_link are all purely developer tools that shouldn't be needed in
> common practice.  semodule_package is necessary only if building policy
> modules, so I'd tend to put that in a -devel package.  Not sure whether
> run_init is truly required in Fedora outside of -mls policy?  sestatus
> isn't required for operation but is convenient to have.  The rest make
> sense to me as part of the base package.
> 
> 2) policycoreutils-devel (sepolicy and sepolgen* from the separate
> sepolgen source package, which gets combined into the policycoreutils
> source package in Fedora)
> 
> Not sure how much sense this one makes in its current form separate from
> policycoreutils-python below.
> 
> 3)  policycoreutils-python (audit2allow, audit2why, seamanage, chcat,
> sandbox?, /usr/lib*/python*/site-packages/*)
> 
> Confused by why sandbox appears here but its dependencies are below in
> policycoreutils-sandbox.  audit2allow/audit2why are effectively policy
> development tools.   chcat seems more like a base utility although I'm
> not sure how many people use it rather than just using chcon -l or
> semanage these days.  semanage is required for management if using
> managed/modular policy, so it is more fundamental than
> audit2allow/audit2why, chcat, or sandbox.
> 
> 4) policycoreutils-gui (selinux-polgengui, system-config-selinux)
> 
> Seems reasonable.
> 
> 5) policycoreutils-newrole (newrole)
> 
> I'd tend to put this into the base or at least with run_init.  IIRC, it
> was only separated to avoid having an unnecessary setuid/file-caps
> binary in the non-MLS case. If the common thread is MLS, then I'd tend
> to put newrole, run_init, and chcat together.
> 
> 6) policycoreutils-restorecond (restorecond)
> 
> Makes sense as an optional component.

Also, do we even need/use restorecond anymore?  Isn't it obsoleted by
name-based type transitions?

> 
> 7) policycoreutils-sandbox (seunshare, /usr/share/sandbox)
> 
> Ditto, except that I'd expect sandbox from policycoreutils-python in
> this one too.
> 
> So, I guess the question is whether it provides any value to split up
> the source package itself (as opposed to just the generated packages),
> and if so, what the best decomposition is.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
