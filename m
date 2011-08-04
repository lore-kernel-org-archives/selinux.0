Subject: Re: Howto transition socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Christian <martin.christian@secunet.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <4E36CA2C.8080300@secunet.com>
References: <4E36CA2C.8080300@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 08:30:45 -0400
Message-ID: <1312461045.20973.3.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-08-01 at 17:45 +0200, Martin Christian wrote:
> Hi,
> 
> excuse this very basic question: How can I define a transition for a socket?
> 
> Let's assume I've got a process p with label u_t, denoted as p:u_t. The
> process opens a listening tcp socket s on port 80 (e. g. nc -l -p 80).
> As far as I understood, s would get the label from the process: s:u_t.
> However, I would like the socket to have label o_t. Hence, I define a
> transition:
> 
> (u, u) -> o
> 
> or in policy syntax;
> 
> type_transition u_t u_t:tcp_socket o_t;
> 
> But this doesn't seem to work. Any ideas?
> 

Kernel version?  Support for type transitions on sockets was first
introduced in kernel 2.6.39.  Older kernels would always label sockets
with their creator's context or with the context specified by the
application using setsockcreatecon(3) from libselinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
