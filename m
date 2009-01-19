Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0J8HdH0024579
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 03:17:39 -0500
Received: from mail-gx0-f20.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0J8EkRt000113
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 08:14:47 GMT
Received: by gxk13 with SMTP id 13so2384298gxk.18
        for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 00:17:38 -0800 (PST)
Message-ID: <4974371E.9090104@gmail.com>
Date: Mon, 19 Jan 2009 00:17:34 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: netstat -Z
References: <200901181932.37457.russell@coker.com.au>
In-Reply-To: <200901181932.37457.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> The command "netstat -Z -t" will show two entries for a localhost connection 
> and thus show the context of each end of the socket.
>
> The command "netstat -Z -x" seems to only show a single entry for the 
> connection which will be from the server end.
>
> http://wiki.postgresql.org/wiki/SEPostgreSQL
>
> The above wiki page mentions "netstat -Z" and my personal interpretation of 
> this was that I could use "netstat -Z" to find the context of a client end of 
> a socket.  But it seems that I can only get the server end.
>
> Is this what is desired?
>
>   
I think this is a good idea considering
the new policy_capability option.
(unfortunately if -Z is an option already, ubuntu jaunty
doesn't offer that yet);

regards;

Justin P. Mattock




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
