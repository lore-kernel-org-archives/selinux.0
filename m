MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libsemanage: free policydb before fork
Date: Mon, 4 Feb 2008 10:32:11 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181EEE2@exchange.columbia.tresys.com>
In-Reply-To: <1202138657.3070.61.camel@moss-spartans.epoch.ncsc.mil>
References: <47A5311F.2020703@manicmethod.com> <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com> <1202138657.3070.61.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>Might be interesting to see the results of that change, but just to
> note, from the man page for vfork in Linux:
> 
> BUGS
>        It is rather unfortunate that Linux revived this specter from
>        the past. The  BSD  man  page  states:  "This system call will
>        be eliminated when proper system sharing mechanisms are 
>        implemented.   Users  should  not depend  on  the memory
>        sharing semantics of vfork() as it will, in that case, be made
> synonymous to fork(2)." 
> 
>        Details of the signal handling are obscure and differ between 
>        systems. The  BSD man page states: "To avoid a possible
>        deadlock situation, pro- cesses that are children in the
>        middle of  a  vfork()  are  never  sent SIGTTOU  or  SIGTTIN 
>        signals; rather, output or ioctls are allowed and input
> attempts result in an end-of-file indication." 

Be that as it may, vfork() is now part of POSIX so I don't think it
is going anywhere.  On modern systems it is really just an asyncronous
fork(), though we are not even relying on that here.  That info from
the BSD manual page dates from back when BSD had a less advanced VM
system.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
