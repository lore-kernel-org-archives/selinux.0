Subject: Re: matchpathcon() for arbitrary subjects
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <457F1F57.5080204@hp.com>
References: <457F0145.7020305@hp.com>
	 <1165952421.998.100.camel@moss-spartans.epoch.ncsc.mil>
	 <457F151F.6030107@hp.com>
	 <1165956639.998.114.camel@moss-spartans.epoch.ncsc.mil>
	 <1165956816.998.117.camel@moss-spartans.epoch.ncsc.mil>
	 <457F1F57.5080204@hp.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 16:41:15 -0500
Message-Id: <1165959675.998.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-12 at 16:29 -0500, Matt Anderson wrote:
> Thats true, once there was output it would block other users from using
> that queue until it was removed.  This is intentional.

Ok.  Polyinstantiating the destination file would be nicer from a
functional point of view.

> The idea is to bring some sort of useful SELinux support to file
> printers.  In the case of file printers I've taken this to mean that the
> user who printed the job would be able to access the output directly.
> 
> Cups has no mechanism to access the file after its been printed.
> 
> In talking to Dan Walsh about the policy aspect of it we had talked
> about polyinstantiating the output type, effectively user_lpr_t would
> generate user_print_output_t.  While that would block secadm_lpr_t from
> printing it would also stop secadm from reading someone else's output.

In that case, security_compute_create() is what you want.  Passing in
the client's context as the first context, the context of the parent
directory in which the destination file will be created as the second
context, and SECCLASS_FILE for the security class, and returning the
context to put on the file.  That context would have the client's level,
and it would have either the parent directory's type (if no type
transition rule matches) or the type specified by a type transition rule
on the client's type and the parent directory type.

I assume you would limit the client to only read and write access to the
file, and not give it other permissions (e.g. create, unlink, rename,
etc), leaving such manipulations entirely to cupsd.

> Your socket suggestion sounds interesting, but that would be adding
> SELinux support for socket printers.  That might be interested to do at
> some point, but for now I'm trying to wrap things up for the RHEL5
> release.  As it is file printers were being added to automate evaluation
> testing.  If there is no safe, secure way to facilitate file printers
> they may not be supported in the evaluated configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
