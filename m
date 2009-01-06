Subject: Re: Postfix with domain keys
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1231253635.9746.46.camel@localhost.localdomain>
References: <1231243582.2946.106.camel@kr0sty.livra.local>
	 <1231248177.9746.7.camel@localhost.localdomain>
	 <1231248656.9746.10.camel@localhost.localdomain>
	 <1231250318.2946.122.camel@kr0sty.livra.local>
	 <1231251202.9746.37.camel@localhost.localdomain>
	 <1231253888.2946.132.camel@kr0sty.livra.local>
	 <1231253635.9746.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Tue, 06 Jan 2009 13:17:33 -0200
Message-Id: <1231255053.2946.138.camel@kr0sty.livra.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-01-06 at 09:53 -0500, Stephen Smalley wrote:
[snip]
> > > 	module mypostfix 1.0;
> > > 	require {
> > > 		type postfix_master_t;
> > > 		type port_t;
> > > 		class tcp_socket name_bind;
> > > 	}
> > > 	allow postfix_master_t port_t:tcp_socket name_bind;
> > > 
> > > See for example:
> > > http://docs.fedoraproject.org/selinux-faq-fc5/#id2961385
> > > http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/sect-Security-Enhanced_Linux-Fixing_Problems-Allowing_Access_audit2allow.html
> > > 
> > 
> > Correct me if I'm wrong, but allowing this will accept the domain use
> > any tcp socket, and call me paranoid, but it could allow postfix
> > something like a reverse telnet or something. Is it right? (I've already
> > warned you that I'm a complete rookie, so it could be a ridiculous
> > response).
> 
> It allows the domain to bind to any port that is not otherwise mapped to
> a specific type by the policy and thus defaults to port_t.  Well-defined
> ports like telnet (23) are mapped to specific types like telnetd_port_t
> by policy, and the reserved port range is covered by default mappings to
> reserved_port_t or hi_reserved_port_t if there is no specific match.
> 
> As I said, the above policy module is what I would expect it to generate
> if you were to run it on avc denials generated without any specific
> semanage port assignment for the 10026 port and thus defaulting to
> port_t.  If you instead define your own port type and map the 10026 port
> to that type, then the allow rule could be specific to your new port
> type.

Thank you very much for clear it!

I'll be checking those links and then try that module.


I really really appreciate your help.


Cheers


Martín


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
