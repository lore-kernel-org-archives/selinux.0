Date: Thu, 19 Dec 2002 09:27:04 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Domain transition -- enabling user_r in eklogin
Message-ID: <20021218222704.GH10185@snoopy.apana.org.au>
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <20021217192856.427b5d68.fw@fwsystems.com> <20021218012830.GC31462@snoopy.apana.org.au> <200212180845.22750.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212180845.22750.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 18, 2002 at 08:45:22AM +0100, Russell Coker wrote:
> Which is something you could easily achieve through PAM configuration if that 
> is what you desire, without any kerberos issues etc.

How would you do it with PAM?

What security issues would this raise?

> Also I think that in most situations where a user could be tricked into 
> running newrole then it's game-over anyway.

OK. I was thinking more of scripts, etc.

> > I am not yet sure how good SE-Linux will be at solving this type of
> > problem, without duplicating a lot of domains, for instance
> > a set of domains for programs with Kerberos ticket access, and
> > a duplicate set for programs without Kerberos ticket access).
> 
> What exactly is "ticket access" and how does it conceptually differ from read 
> access to /etc/shadow?  Couldn't we just treat ticket access in the same way 
> as access to /etc/shadow?

There are several differences:

- the ticket is created by login/PAM or kinit, not sysadm_r.

- the ticket has a limited life time, so if somebody accesses it,
  its not quite as bad as somebody accessing one weak entry of the
  shadow file.

- more importantly, there are no immediate security risks by proving a
  trusted program access to the shadow file. It is not the
  authentication key, it is the lock.

However, a kerberos ticket is the key. So if you provide, say rsh access
to the ticket, any process that has ability to run rsh, directly via
exec, or indirectly, say via bash, can run commands like (note I don't
have a man page handy, so I can't check the parameters for certain) "rsh
remotehost rm -rf ."

Even worse is if this ticket allows root access...

So you might need some instances of bash that can run rsh, and
other instances that are used for running untrusted scripts that
cannot run rsh.

I talk about Kerberos tickets here, the same thing would also apply to
ssh-agent connections, with the exception that once the connection is
closed, it is no longer a security threat.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
