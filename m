Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050330175337.29150.qmail@web31602.mail.mud.yahoo.com>
References: <20050330175337.29150.qmail@web31602.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 12:56:20 -0500
Message-Id: <1112205380.8012.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 09:53 -0800, Casey Schaufler wrote:
> The BOF? Oh, I was there. I have witnesses!

Not the X BOF, the talk by Colin Walters on securing the desktop.  See
the website for the slides if you missed it.

> > TE (not DTE, different beast, ask me privately if
> > you want a comparison
> > paper) can operate transparently to the application,
> > but you often can't
> > achieve true least privilege without application
> > modifications or
> > changes in its conventional usage.  
> 
> Well, that will be a barrier to acceptance.

It isn't a TE issue; it is just a least privilege issue in general.
Applications and usage patterns aren't accustomed to having to deal with
least privilege restrictions.  Hence, if you want to move towards least
privilege, some change is necessary.  But you can certainly configure TE
as coarsely as you want to avoid breaking any existing applications or
user behaviors, accepting the corresponding limitations in what security
you can provide.  Your choice...

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
