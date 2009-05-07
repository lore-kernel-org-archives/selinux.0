Date: Thu, 7 May 2009 14:57:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@ZenIV.linux.org.uk,
        sds@tycho.nsa.gov
Subject: Re: SELinux and access(2), we want to know.
Message-ID: <20090507195729.GA21104@us.ibm.com>
References: <1241723924.2791.107.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241723924.2791.107.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Eric Paris (eparis@redhat.com):
> 3) I've also heard it hinted that we could do this with audit by just
> having audit drop the denials that include the access(2) syscall and the
> scontext and tcontext for the slew of things the SELinux policy writers
> know we are not interested in.  And while it seems good, now we have

What is the difference whether an attacker does access(2) to check for
/etc/shadow rights, or does a failed open()?

Either you care that someone is poking around, or you don't.  Right?

> SELinux 'policy' in places other than the policy, harder to distribute,
> and it requires that everyone who turns on SELinux also turns on syscall
> auditing with its associated overhead.
> 
> Obviously I think the right thing to decide if an LSM wants to send a
> denial message or not is the LSM.  The only problem I have is that the
> LSM doesn't know today when it is getting different types or requests
> and so can't make that decision.

I think the problem is that you want to guess the intent, and you
can't do that.  Knowing that a process did access instead of open
really isn't sufficient.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
