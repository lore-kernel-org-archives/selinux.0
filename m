Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LFOGWU032628
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 11:24:16 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LFOEF3020300
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 15:24:15 GMT
From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: Question on networking accesses
Date: Mon, 21 May 2007 11:22:25 -0400
Cc: selinux@tycho.nsa.gov
References: <93504.42890.qm@web36614.mail.mud.yahoo.com>
In-Reply-To: <93504.42890.qm@web36614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705211122.25948.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 21 2007 9:48:52 am Casey Schaufler wrote:
> I have what I hope is a fairly straitforward question on the SELinux
> networking model. Let's pretend that I have a process A that sends a
> UDP packet P to a second process B. From the viewpoint of access control
> is this:
>
>     - process A writing to process B
>     - process B reading from process A
>     - process A creating packet P, and process B reading packet P
>
> some combination of the above, or something else entirely?

>From 10,000 feet up in the air that sounds roughly about right.  Although if 
you are talking about labeled networking it can be a bit more involved, 
especially if you are using labeled IPsec.

Can you be a bit more specific?

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
