Subject: Re: Audit2allow in python generates module code.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1132235886.17726.13.camel@moss-spartans.epoch.ncsc.mil>
References: <437C0256.509@redhat.com>
	 <1132235886.17726.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 09:06:39 -0500
Message-Id: <1132236399.17726.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-17 at 08:58 -0500, Stephen Smalley wrote:
> On Wed, 2005-11-16 at 23:08 -0500, Daniel J Walsh wrote:
> > Added -m <modulename> to output module syntax.
> 
> Ok, so I tried:
> 	audit2allow -a -m local -o local.te
> 	checkmodule -M -m -o local.mod local.te
> 	semodule_package -o local.pp -m local.mod
> 	semodule -i local.pp
> which appears to have worked, although I think we want a shorthand way
> of doing the latter steps after the audit2allow.
> 
> A couple of questions/suggestions:
> - What if I want to append further rules later to my local.te file and
> rebuild that module?  That still needs to turn on the generation of
> require statements, but not add another module statement.  That is why I
> suggested having two separate options, one to turn on require statements
> and one to turn on module statements (the latter could imply the former
> as well).  Possibly a -r option to just generate require statements w/o
> adding another module statement?
> 
> - What about versioning of local.te (or do we not care)?  Should
> audit2allow check whether the output file already exists and if so, read
> the current module statement from it and increment the version?  Or
> leave that to the user to do manually if they want versioning? 
> 
> Minor nit:  There is a cut-and-paste leftover in the audit2allow python
> script from genhomedircon (a comment about home dir file context,
> homedir_template, etc).

BTW, error handling seems broken, e.g.:
	audit2allow -m # forgot to include a module name
yields:
Traceback (most recent call last):
  File "./audit2allow", line 268, in ?
    errorExit(string.join("Options Error ", error))
  File "/usr/lib/python2.4/string.py", line 318, in join
    return sep.join(words)
AttributeError: GetoptError instance has no attribute 'join'

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
