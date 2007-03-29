Subject: Re: "HASHTAB_OVERFLOW" undeclared
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <460BA67D.40807@gmail.com>
References: <460B2925.1080403@gmail.com>
	 <1175166411.3864.504.camel@moss-spartans.epoch.ncsc.mil>
	 <460BA67D.40807@gmail.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 07:55:56 -0400
Message-Id: <1175169356.3864.523.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 19:43 +0800, Ken YANG wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-03-29 at 10:49 +0800, Ken YANG wrote:
> >> i want to use findcon to find a type "tmpfs_t".
> >> but in FC, there is setools* package contaning findcon.
> >> i find that secmds(findcon) is in setools-console subpackage
> >> why fc has not this subpackage?
> > 
> > That's a question for Dan Walsh (cc'd above) or fedora-selinux-list.
> 
> ok, i have cc to fedora-selinux-list
> 
> > 
> >> i down a setools-3.1-1.src.rpm from tresys site, and encounter
> >> a build error:
> >>
> >> policy_extend.c: In function 'qpol_policy_build_attrs_from_map':
> >> policy_extend.c:170: error: 'HASHTAB_OVERFLOW' undeclared (first use in 
> >> this function)
> >> policy_extend.c:170: error: (Each undeclared identifier is reported only 
> >> once
> >> policy_extend.c:170: error: for each function it appears in.)
> >> policy_extend.c: In function 'qpol_policy_fill_attr_holes':
> >> policy_extend.c:246: error: 'HASHTAB_OVERFLOW' undeclared (first use in 
> >> this function)
> >> make[4]: *** [policy_extend.o] Error 1
> >> make[4]: Leaving directory 
> >> `/workbench/rpmbuild/BUILD/setools-3.1/libqpol/src'
> >>
> >>
> >> i have not find "HASHTAB_OVERFLOW" in selinux trunk, especially in
> >> libsepol. where is this symbol defined?
> > 
> > Those error codes were replaced by standard ones
> > (include/sepol/errcodes.h) in the trunk version of libsepol, so you
> > would need to build setools against the stable branch version of
> > libsepol until they update setools.
> 
> thank you.
> 
> i play some tricks on the setools :-)
> 
> in the spec file of setools-3.1-3.fc7, i find "findcon" and other cmds
> had been removed:
> 
> rm -f ${RPM_BUILD_ROOT}/usr/bin/findcon
> rm -f ${RPM_BUILD_ROOT}/usr/bin/replcon
> rm -f ${RPM_BUILD_ROOT}/usr/bin/searchcon
> rm -f ${RPM_BUILD_ROOT}/usr/bin/indexcon
> rm -f ${RPM_BUILD_ROOT}/usr/share/man/man1/searchcon.1
> rm -f ${RPM_BUILD_ROOT}/usr/share/man/man1/indexcon.1
> rm -f ${RPM_BUILD_ROOT}/usr/share/man/man1/replcon.1
> rm -f ${RPM_BUILD_ROOT}/usr/share/man/man1/findcon.1
> rm -rf ${RPM_BUILD_ROOT}%{_includedir}/libsefs/sqlite
> 
> 
> so i comment "findcon relative" items, and add corresponding items
> in "files" list.
> 
> it seems that this kind of "findcon" works.
> 
> this is a temporary method, i just want to use findcon to search
> certain context

How does it differ from find . -context ...?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
