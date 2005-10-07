Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4346CE4C.1030201@tresys.com>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 15:54:12 -0400
Message-Id: <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 15:36 -0400, Joshua Brindle wrote:
> I don't know of any reason to selectively enable the global branch, it 
> should always be enabled or else there won't be any rules in the 
> expanded policy.

So what is the purpose of the current code in checkpolicy and
libsemanage (prior to my changes) to enable the branch?  Should
expand_module unconditionally enable this?

> Hrm... Would it be better to always expand it to the latest format we 
> know about and handle downgrading at write time? What if the kernel 
> policyvery is lower than the requested write version? There is a 
> possibility of lost information.

policydb representation is always the "latest"; version only matters at
read/write time.  So this setting of the version is just to decide how
it is written to the kernel policy file.  If we can write the kernel's
version, then we want to do that.  If not, then we want to write the
closest version to the kernel's version, so we'll go with the conf
version which will default to the max version supported by libsepol.  I
revised that logic after sending the diff.

> <snip>
> > @@ -1165,7 +1157,7 @@ int semanage_link_sandbox(semanage_handl
> >  	}
> >  	free(module_filenames);
> >  	for (i = 0; mods != NULL && i < num_modules; i++) {
> > -		sepol_module_package_destroy(mods[i]);
> > +		sepol_module_package_free(mods[i]);
> >  	}
> >  	free(mods);
> >  	return retval;
> 
> What is this?

I changed the interfaces on the libsepol side to be consistent with the
other public ones, so init/destroy -> create/free.  I don't personally
care about it, of course.

> Only if the kernel policyvers lookup fails we use the config file?

I revised this to use the conf setting (or default max) if the kernel
policy version falls outside the range supported by the shared libsepol.

BTW, I now have everything building again (except semodule_link/expand,
which I disabled for now), with semodule and semodule_package both using
only shared libs, and trivial tests of semodule/semodule_package seem to
be working as expected.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
