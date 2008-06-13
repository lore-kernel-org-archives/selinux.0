Subject: Re: [PATCH] libselinux: new and updated man pages for
	AVC,	mapping, label
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@parisplace.org>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4852C128.30700@tycho.nsa.gov>
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
	 <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>
	 <1213298430.17842.297.camel@moss-spartans.epoch.ncsc.mil>
	 <1213300336.17842.309.camel@moss-spartans.epoch.ncsc.mil>
	 <48518F23.6080406@tycho.nsa.gov>
	 <1213359860.17842.321.camel@moss-spartans.epoch.ncsc.mil>
	 <1213367226.17842.346.camel@moss-spartans.epoch.ncsc.mil>
	 <4852C128.30700@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 15:11:53 -0400
Message-Id: <1213384313.17842.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-06-13 at 14:49 -0400, Eamon Walsh wrote:
> Stephen Smalley wrote:
> 
> [snip]
> 
> > One other question I have is what we should do about the flask.h
> > definitions and string tables in libselinux.  We obviously need to
> > retain the legacy definitions for old userspace object managers, but we
> > also have the old X definitions there and the db definitions.  make
> > LIBSELINUX_D=/path/to/libselinux tolib from refpolicy/policy/flask will
> > install updated headers and string tables with the latest definitions
> > but do we want them all now or just the legacy ones?
> >   
> 
> I think we need to start removing the userspace classes, starting with 
> the DB and X ones.  Even for the legacy object managers, removing the 
> definitions won't break any binaries, just the source code compiling.

I don't think that's correct - take a look at r2559.  There is still a
dependency on the generated tables in libselinux for legacy object
managers to function, and those use the symbol definitions.  At most we
could take the definitions private within libselinux/src.

> > I suppose partly that depends on whether we want to use newer object
> > managers on older kernels that don't support the dynamic class/perm
> > discovery mechanism.  
> >   
> 
> I would argue no, given that X at least depends a lot on new kernel 
> features.

The change to mls_compute_sid for polyinstantiation?  Anything else?
What happens if you try to run it on an older kernel; just no MLS
polyinstantiation there, right?

> >   
> >> As a separate matter, we may want to discuss whether we are getting the
> >> flexibility we hoped from this dynamic mapping.  The other day I was
> >> adding a new kernel class for experimentation purposes and inserted it
> >> before the new X classes, thinking that this would be ok since they can
> >> be dynamically looked up and thus don't require fixed indices.  However,
> >> when booting the resulting kernel with a stock policy, I found that the
> >> kernel refused to load the policy because it saw a conflict between its
> >> kernel definition for that class value (the new kernel class) and the
> >> policy definition for that class value (the X class).  Which would mean
> >> that new kernels on legacy distros would break.
> >>     
> 
> Well I think the kernel needs to grow its own mapping support then.

Maybe, although handle_unknown also factors in here, and isn't yet
supported by userspace.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
