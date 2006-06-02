Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <12970.1149255051@warthog.cambridge.redhat.com>
References: <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil>
	 <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil>
	 <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil>
	 <12509.1149240105@warthog.cambridge.redhat.com>
	 <12388.1149253325@warthog.cambridge.redhat.com>
	 <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil>
	 <12970.1149255051@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:52:05 -0400
Message-Id: <1149256325.524.457.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-02 at 14:30 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > Discretionary access control is what the basic Linux access control
> > > model is.  Mandatory access control is what SELinux provides.
> > 
> > So to clarify:  SELinux is presently performing a parallel MAC
> > permission check for each existing DAC permission check, and the MAC
> > check occurs after the DAC check (and only occurs if the DAC check
> > succeeds).  
> 
> That makes things clearer, thanks; though why is it called a 'DAC' when it is
> in fact mandatory?  And why 'MAC' when it's discretionary in the fact that
> it's _not_ checked if you don't have a security context?

Discretionary means "at the discretion of the user or program", i.e. the
standard Linux permission checks are based on permission bits set by the
user/program, and the user/program is free to give away access
arbitrarily, making it vulnerable to flawed and malicious applications
and to careless users.  Mandatory means administratively-defined policy
along with control over all processes and objects and decisions based on
all security-relevant information (more than just user identity).

Everything has a security context assigned to it (whether via default
inheritance or explicit labeling), and the SELinux MAC check is always
applied before any operation is permitted.  But the SELinux MAC check
won't be reached if some earlier error condition occurs, whether that is
a validation error on some input argument that precedes permission
checks entirely or an error from the DAC permission checks.  That is ok,
as the operation won't proceed in that situation, and there is no
information leak since both DAC and MAC denials yield EACCES.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
