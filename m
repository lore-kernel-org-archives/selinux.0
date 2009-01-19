Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0J87xwl023691
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 03:07:59 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0J855fg028572
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2009 08:05:06 GMT
Message-ID: <497434CA.1070104@ak.jp.nec.com>
Date: Mon, 19 Jan 2009 17:07:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
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

Please note that the above wiki entry is on "postgresql.org".
It assumes PostgreSQL folds (not SELinux specialist) as audiences.
The purpose of description about "netstat -Z" is to make clear
the fact security context can be assigned to various kind of
objects (like socket), except for filesystem also.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
