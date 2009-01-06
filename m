Subject: Re: Postfix with domain keys
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1231251202.9746.37.camel@localhost.localdomain>
References: <1231243582.2946.106.camel@kr0sty.livra.local>
	 <1231248177.9746.7.camel@localhost.localdomain>
	 <1231248656.9746.10.camel@localhost.localdomain>
	 <1231250318.2946.122.camel@kr0sty.livra.local>
	 <1231251202.9746.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Tue, 06 Jan 2009 12:58:08 -0200
Message-Id: <1231253888.2946.132.camel@kr0sty.livra.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-01-06 at 09:13 -0500, Stephen Smalley wrote:
[snip]
> > 
> > Audit2allow "recommended" to allow transition from postfix_master_t to
> > port_t and then allow create socket port_t, but I didn't feel it much
> > secure...what do you think?
> 
> I'm not sure I quite follow the above, as a transition usually means
> that we are changing from one context to another, and there is no
> transition in the above situation, just an attempt to bind to a given
> port.
> 
> The actual verbatim output of audit2allow would likely be more useful.
> Without any semanage entries, I would have expected it to be something
> like:
> 	module mypostfix 1.0;
> 	require {
> 		type postfix_master_t;
> 		type port_t;
> 		class tcp_socket name_bind;
> 	}
> 	allow postfix_master_t port_t:tcp_socket name_bind;
> 
> See for example:
> http://docs.fedoraproject.org/selinux-faq-fc5/#id2961385
> http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/sect-Security-Enhanced_Linux-Fixing_Problems-Allowing_Access_audit2allow.html
> 

Correct me if I'm wrong, but allowing this will accept the domain use
any tcp socket, and call me paranoid, but it could allow postfix
something like a reverse telnet or something. Is it right? (I've already
warned you that I'm a complete rookie, so it could be a ridiculous
response).


Thanks Stephen.


Martín


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
