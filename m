Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <434EE146.3010804@tresys.com>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1129035115.3308.67.camel@moss-spartans.epoch.ncsc.mil>
	 <1129231767.13490.31.camel@moss-spartans.epoch.ncsc.mil>
	 <434EE146.3010804@tresys.com>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 08:02:08 -0400
Message-Id: <1129291328.15883.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 18:35 -0400, Joshua Brindle wrote:
> > We still need to decide what to do about the
> > sepol_module_package_create_file interface to make it extensible; one
> > option is to discard it and require the caller to build up a
> > sepol_module_package struct via a create/set_xx/set_yy sequence and then
> > use the write interface to write the final package file.  It appears the
> > we would only need/want a set_file_contexts interface at present, as the
> > policydb is allocated by the create interface and can be extracted via
> > get and then populated using the other policydb interfaces (read,
> > expand_module, etc).  The only user of the create_file interface
> > presently is semodule_package.
> > 
> > Also need to deal with the package file format itself, i.e. versioning,
> > sections, etc. per the discussion on fedora-selinux-list.
> > 
> It also seems like the current CLI for semanage_package is insufficient. 
> If we are building support into the format and API for sections and 
> other data the semanage_package options should reflect what sections are 
> you are filling in with what data, something like
> 
> -f file_contexts
> -m module data
> 
> and anything else added later would obviously get an argument.

Does it ever make sense to build a package without a module?  If not,
then I think we can leave the module as a required argument, and only
make things like file contexts and other components option-driven.  It
might also help to in some way more clearly distinguish the output file
from the input arguments to avoid accidentally clobbering a module (I've
done that before) with semodule_package, either via explicit -o option
like checkmodule/checkpolicy (with some default output filename) or have
semodule_package refuse to clobber an existing file.
.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
