Subject: Re: Postfix with domain keys
From: Stephen Smalley <sds@tycho.nsa.gov>
To: martins.listz@gmail.com
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1231250108.2946.118.camel@kr0sty.livra.local>
References: <1231243582.2946.106.camel@kr0sty.livra.local>
	 <1231248177.9746.7.camel@localhost.localdomain>
	 <1231250108.2946.118.camel@kr0sty.livra.local>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 09:06:22 -0500
Message-Id: <1231250782.9746.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-01-06 at 11:55 -0200, Martin Spinassi wrote:
> On Tue, 2009-01-06 at 08:22 -0500, Stephen Smalley wrote:
> > On Tue, 2009-01-06 at 10:06 -0200, Martin Spinassi wrote:
> > > Hello list!
> > > 
> > > 
> > > I'm a little stuck with selinux and postfix, hope you can give me
> > > feedback with it.
> > > 
> > > We're trying to add domain keys to a postfix server, but it can't open
> > > ports used by dkim to sign the mail. Here is some output of audit.log:
> > > 
> > > 
> > > type=AVC msg=audit(1231242373.605:52): avc:  denied  { name_bind } for
> > > pid=5386 comm="master" src=10026
> > > scontext=root:system_r:postfix_master_t:s0
> > > tcontext=system_u:object_r:postfix_master_t:s0 tclass=tcp_socket
> > > 
> > > type=SYSCALL msg=audit(1231242373.605:52): arch=c000003e syscall=49
> > > success=no exit=-13 a0=11 a1=2b06cdbc46d0 a2=10 a3=7fffe2d2f64c items=0
> > > ppid=1 pid=5386 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
> > > fsgid=0 tty=(none) ses=3 comm="master" exe="/usr/libexec/postfix/master"
> > > subj=root:system_r:postfix_master_t:s0 key=(null)
> > > 
> > > 
> > > 
> > > I've allready added the port to the postfix_master_t domain with:
> > > # semanage port -a -t postfix_master_t -p tcp 10026
> > 
> > postfix_master_t is a domain type, i.e. a type that should only be
> > associated with postfix master processes.  You don't want to apply it to
> > the port.  So I'd delete that entry (likewise using semanage).
> > 
> > What denial did you get originally before mapping the port to
> > postfix_master_t?  Was it just port_t originally?  Looking at a copy of
> > the reference policy, it looks like postfix_master_t is allowed
> > name_bind permission for port_t, reserved_port_t, and smtp_port_t.
> > 
> > If you really wanted to lock down this port specifically, you could of
> > course introduce your own type for it (dkim_port_t?) and allow
> > postfix_master_t to bind it via a local policy module, and then use
> > semanage to map the port to that new type.
> 
> 
> Thanks for the response Stephen.
> 
> I don't know if it's the best solution, but it is working now.
> 
> Here is what I did (just in case someone else needs it):
> 
> 
> As rhel 5 doesn't have selinux-tageted-source package any more, I'd to
> see how to resolve it with semanage.

The old policy -sources package became unnecessary with the introduction
of support for loadable policy modules and semanage, which first
happened in the Fedora Core 5 release.  Instead, you can just create
your own local policy module, build it and install it without needing
the base policy sources at all.

See for example:
http://docs.fedoraproject.org/selinux-faq-fc5/#faq-entry-local.te

(Note to Dan:  I don't see anything comparable in the current Fedora
SELinux FAQ or the Fedora 10 SELinux Guide on how to write a local
policy module, only about using audit2allow.)

> First I removed previous entry for that port (my mistake)
> 
> # semanage port -d -t postfix_master_t -p tcp 10026
> 
> and then added it to smtp_port_t
> 
> # semanage port -a -t smtp_port_t -p tcp 10026
> 
> 
> Doing a it's own type (dkim_port_t) would be the best, but need a bit of
> practice to do it.
> 
> 
> Thanks again for the response, I'll try to do it's own type once I
> finish the O'Reilly selinux book ;-)

I'd recommend looking at something more recent, unless there is a new
edition of that book.  The original edition only described the state of
SELinux circa Fedora Core 2/3 and thus doesn't deal with loadable policy
modules, semanage, or reference policy at all.  The SELinux by Example
book is more recent.  Then there are various online resources, see:
http://selinuxproject.org/page/User_Resources


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
