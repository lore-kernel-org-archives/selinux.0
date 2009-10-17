Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9HBdvM4021631
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 07:39:58 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9HBfeE0008416
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 11:41:40 GMT
Message-ID: <4AD9AD06.9030309@redhat.com>
Date: Sat, 17 Oct 2009 07:39:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Larry Ross <selinux.larry@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: sshd error: Failed to get default security context
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
In-Reply-To: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/16/2009 08:15 PM, Larry Ross wrote:
> I have created a custom selinux user for the strict policy on RHEL5.3 who's
> purpose is to connect via ssh and scp files off the machine.  When that user
> tries to login via ssh, I see the following messages in /var/log/secure:
> 
> In enforcing:
> Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser
> from 192.168.1.1 port 64680 ssh2
> Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default security
> context for scpuser.
> Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux failure. Aborting
> connection.
> 
> In permissive:
> Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser from
> 192.168.1.1 port 56254 ssh2
> Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get default security
> context for scpuser.
> Oct 16 07:55:59 localhost sshd[23302]: error: SELinux failure. Continuing in
> permissive mode.
> 
> Could someone explain what these messages mean?
> 
> I believe that I have a default context defined in the "default context"
> file that should work. I believe I have an executable context available for
> this user (using rbash rather than bash).
> 
> How is sshd making this decision?  It looks like it is calling setexeccon,
> but I'm not sure how that makes its decision.  Where should I look for clues
> as to how to fix it?
> 
>    Thank you,
>    Larry
> 
Did you add an entry to default_types?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
