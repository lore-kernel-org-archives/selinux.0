Message-ID: <20050324204100.87156.qmail@web31613.mail.mud.yahoo.com>
Date: Thu, 24 Mar 2005 12:41:00 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Do you trust X server?
To: Tom <tom@lemuria.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Tom <tom@lemuria.org> wrote:

> > If you
> > chose to use the X server as a component of
> > your policy enforcement that is your affair,
> > but the appropriate use of that code is your
> > responsibility, not that of the X server.
> 
> That depends. As far as we can provide policy
> enforcement externally,
> the X server doesn't have to care.

Yes, that is correct.

> However, it has
> been noted in past
> discussions that the X server is, like login or ssh,

Excuse me, but the X server is not like login or ssh.
Login and ssh are policy enforcing programs. As I
noted above, the X server is not.

> one of the
> programs that cannot fulfill their role within an
> SELinux environment
> without either endangering said environment or
> becoming policy-aware.

If this is true it is a problem with the SELinux
environment, not the X server. The SGI Irix B1
evaluation of 1995 used an unmodified X server
that did no policy enforcement. The environment
was not endangered by the presence of the X server.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
