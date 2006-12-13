Subject: Re: matchpathcon() for arbitrary subjects
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <457F30FD.8060200@hp.com>
References: <457F0145.7020305@hp.com>
	 <1165952421.998.100.camel@moss-spartans.epoch.ncsc.mil>
	 <457F151F.6030107@hp.com>
	 <1165956639.998.114.camel@moss-spartans.epoch.ncsc.mil>
	 <1165956816.998.117.camel@moss-spartans.epoch.ncsc.mil>
	 <457F1F57.5080204@hp.com>
	 <1165959675.998.135.camel@moss-spartans.epoch.ncsc.mil>
	 <457F30FD.8060200@hp.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 08:32:08 -0500
Message-Id: <1166016728.998.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-12 at 17:45 -0500, Matt Anderson wrote:
> Stephen Smalley wrote:
> > On Tue, 2006-12-12 at 16:29 -0500, Matt Anderson wrote:
> >> Thats true, once there was output it would block other users from using
> >> that queue until it was removed.  This is intentional.
> > 
> > Ok.  Polyinstantiating the destination file would be nicer from a
> > functional point of view.
> > 
> >> The idea is to bring some sort of useful SELinux support to file
> >> printers.  In the case of file printers I've taken this to mean that the
> >> user who printed the job would be able to access the output directly.
> >>
> >> Cups has no mechanism to access the file after its been printed.
> >>
> >> In talking to Dan Walsh about the policy aspect of it we had talked
> >> about polyinstantiating the output type, effectively user_lpr_t would
> >> generate user_print_output_t.  While that would block secadm_lpr_t from
> >> printing it would also stop secadm from reading someone else's output.
> > 
> > In that case, security_compute_create() is what you want.  Passing in
> > the client's context as the first context, the context of the parent
> > directory in which the destination file will be created as the second
> > context, and SECCLASS_FILE for the security class, and returning the
> > context to put on the file.  That context would have the client's level,
> > and it would have either the parent directory's type (if no type
> > transition rule matches) or the type specified by a type transition rule
> > on the client's type and the parent directory type.
> 
> Yes, thats exactly what I'd like to do.
> 
> > I assume you would limit the client to only read and write access to the
> > file, and not give it other permissions (e.g. create, unlink, rename,
> > etc), leaving such manipulations entirely to cupsd.
> 
> >From the perspective of $1_lpr_t I was intending to only allow write
> permission, in order to validate that the user was able to print.  For
> user_t it seemed to me that { read getattr relabelfrom link unlink
> rename } was the correct set of permissions.  That way a user could copy
> the output to another location.

read and getattr should be sufficient for copying the file to another
location, including copying it to a file of a different label (any label
to which the user can write).  unlink would be sufficient for removing
it.  relabelfrom isn't a good idea - user could relabel the printer file
in place, causing cupsd to get a denial.  link and rename seem prone to
abuse (e.g. user creates a link to the file in a different location,
tricking some other output stream to go into that printer file as well;
user renames the printer file to a different printer file's name, etc)
and unnecessary for the functionality you describe (just reading/copying
the output and removing the file when finished).

> I'm not sure how you would tell cupsd to remove the file.  Some sort of
> admin role such as sysadm might also need the ability to unlink all of
> these types in order to manage the queue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
