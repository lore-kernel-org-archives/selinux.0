Subject: Re: Postfix with domain keys
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1231248656.9746.10.camel@localhost.localdomain>
References: <1231243582.2946.106.camel@kr0sty.livra.local>
	 <1231248177.9746.7.camel@localhost.localdomain>
	 <1231248656.9746.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Tue, 06 Jan 2009 11:58:38 -0200
Message-Id: <1231250318.2946.122.camel@kr0sty.livra.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-01-06 at 08:30 -0500, Stephen Smalley wrote:
> On Tue, 2009-01-06 at 08:23 -0500, Stephen Smalley wrote:
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
> 
> Oh, actually, the allow rules granting name_bind to port_t and
> reserved_port_t are conditional on allow_ypbind and disabled by default.
> 

Audit2allow "recommended" to allow transition from postfix_master_t to
port_t and then allow create socket port_t, but I didn't feel it much
secure...what do you think?


Thanks again for your time Stephen.

Cheers.

Martín


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
