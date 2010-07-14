Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6ECQDDG009572
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 08:26:13 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6ECPHDW000300
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 12:25:17 GMT
Message-ID: <4C3DACE6.7000706@manicmethod.com>
Date: Wed, 14 Jul 2010 08:26:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: recommending interfaces for audit2allow
References: <201007101022.46235.russell@coker.com.au>
In-Reply-To: <201007101022.46235.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> corenet_tcp_connect_mysqld_port(foo_milter_t)
>
> I think that we need a way for an interface file to recommend itself to have a
> higher priority for certain matches.  For example the above policy line does
> permit foo_milter_t to talk to a MySQL server on a different system.  But you
> probably want something like the following:
>
> mysql_tcp_connect(foo_milter_t)
> optional_policy(`
>    mysql_stream_connect(foo_milter_t)
> ')
>
> So it seems that audit2allow should know that mysql_tcp_connect() is a
> preferred option to corenet_tcp_connect_mysqld_port() and that having an
> option to connect to a Unix domain socket would be good.
>
> Also maybe we should have a single interface with an optional section for
> MySQL client access.
>

Agreed. This seems like it could be solved if sepolgen just 
automatically demoted corenet_* since that would probably be the 
majority of cases where this happens (since corenet is allowed to 
essentially break abstractions).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
