From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil> 
References: <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil>  <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil> <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil> <12509.1149240105@warthog.cambridge.redhat.com> <12388.1149253325@warthog.cambridge.redhat.com> <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>,
        Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 14:30:51 +0100
Message-ID: <12970.1149255051@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > Discretionary access control is what the basic Linux access control
> > model is.  Mandatory access control is what SELinux provides.
> 
> So to clarify:  SELinux is presently performing a parallel MAC
> permission check for each existing DAC permission check, and the MAC
> check occurs after the DAC check (and only occurs if the DAC check
> succeeds).  

That makes things clearer, thanks; though why is it called a 'DAC' when it is
in fact mandatory?  And why 'MAC' when it's discretionary in the fact that
it's _not_ checked if you don't have a security context?

> An extended interface will be added via subsequent patch to permit keys to
> be created with a specified security context (using the existing model of
> /proc/self/attr) so that the login managers can create keys based on the
> session security context rather than based on their own security context.

You could also add an extra keyctl function for that.  I added one at one
time, but it was decided not to include it at that point.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
