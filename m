Date: Wed, 18 Dec 2002 12:28:30 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: forrest whitcher <fw@fwsystems.com>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: Re: Domain transition -- enabling user_r in eklogin
Message-ID: <20021218012830.GC31462@snoopy.apana.org.au>
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <20021217192856.427b5d68.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021217192856.427b5d68.fw@fwsystems.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 17, 2002 at 07:28:56PM -0500, forrest whitcher wrote:
> I'll look into adding kerberos auth to newrole(1) to save retypings of
> password next.

Interesting idea, it would be good not to have to type in your password
each time.

However, I have to wonder if this is such a good idea...

At the very least you would need to have a strict policy that only
allows very trusted programs to access the ticket or to run a program
(eg. newrole) that has access to this ticket.

This might be a good thing anyway, you probably don't want a copy of
mozilla being able to automatically run commands on remote computer with
your Kerberos ticket for instance.

If there is any weakness in this strict policy, and for instance program
X finds it can run newrole indirectly via, say bash, and automatically
get sysadm_r priviliges, you loose any benifit SE-Linux could provide.

Some sort of tool for analysing policy might be good here, for instance
so you can ask questions like "Can Mozilla access the Kerberos ticket
either directly or indirectly by loading another program first?".

I am not yet sure how good SE-Linux will be at solving this type of
problem, without duplicating a lot of domains, for instance
a set of domains for programs with Kerberos ticket access, and
a duplicate set for programs without Kerberos ticket access).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
