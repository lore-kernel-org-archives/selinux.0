Message-ID: <4E3A996C.9090107@secunet.com>
Date: Thu, 04 Aug 2011 15:06:52 +0200
From: Martin Christian <martin.christian@secunet.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Howto transition socket
References: <4E36CA2C.8080300@secunet.com> <1312461045.20973.3.camel@moss-pluto>
In-Reply-To: <1312461045.20973.3.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

That explains why RongQings patch doesn't work for me. I'm still using
kernel 2.6.38. With RongQings patch I can see all the sockets always
have the label of the process, even with active type transition. So the
patch is not broken, but the kernel doesn't support it, yet.

Thanks,

Martin.


Am 04.08.2011 14:30, schrieb Stephen Smalley:
> On Mon, 2011-08-01 at 17:45 +0200, Martin Christian wrote:
>> Hi,
>>
>> excuse this very basic question: How can I define a transition for a socket?
>>
>> Let's assume I've got a process p with label u_t, denoted as p:u_t. The
>> process opens a listening tcp socket s on port 80 (e. g. nc -l -p 80).
>> As far as I understood, s would get the label from the process: s:u_t.
>> However, I would like the socket to have label o_t. Hence, I define a
>> transition:
>>
>> (u, u) -> o
>>
>> or in policy syntax;
>>
>> type_transition u_t u_t:tcp_socket o_t;
>>
>> But this doesn't seem to work. Any ideas?
>>
> 
> Kernel version?  Support for type transitions on sockets was first
> introduced in kernel 2.6.39.  Older kernels would always label sockets
> with their creator's context or with the context specified by the
> application using setsockcreatecon(3) from libselinux.
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOOplmAAoJEGpTkDITRjmogmwIALgXSLxICmXof/lnCD/e8F6n
vDe5Mb+pgwLlw3ONIHB/oGID7GvuddRLVjMDiANitzCFu6ZtfhGVuZhPFGolA7OT
MuaZPWcY1gIESjfbv0HHFLXX5Ufh6TlRVVsuu6VpOTZWuoEuoFWvMBLktkhao3um
NeTQdK1UlYqb4NLLtGuR+z/VblwvdIVMb/+oWIfNJ4MSr1Rh/WrWHOGWXZpXKJiX
eQ8mZFkcx3esYggPNuM+axw7ZOCC0ZP599K70oP5S4lKoOXUYzOg6xDBTLkPiR4+
c+0FKpypZOr6voCLIFFSkPcXIyvS0iRh9M08DIC80mbIcs98QjG3UkGakgY9960=
=DFHQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
