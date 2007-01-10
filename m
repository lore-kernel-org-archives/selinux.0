Subject: RE: [PATCH] allow semodule -i to accept list of modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015886CA5C6@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015886CA5C6@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 08:29:08 -0500
Message-Id: <1168435748.7993.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 16:53 -0500, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > 
> > On Tue, 2007-01-09 at 15:17 -0500, Stephen Smalley wrote:
> > > On Tue, 2007-01-09 at 11:17 -0500, Joshua Brindle wrote:
> > > > Karl MacMillan wrote:
> > > > > The following patch allows semodule to handle a list of modules 
> > > > > for installation (i.e., semodule -i *.pp now works).
> > > > >
> > > > > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> > > > >
> > > > >   
> > > > Acked-By: Joshua Brindle <jbrindle@tresys.com>
> > > 
> > > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > > 
> > > This means we can also update the semodule man page to remove the 
> > > gross hack we came up with to workaround the absence of 
> > such support,
> > >        # Replace all modules with the ones in the current directory
> > >        $ semodule -b base.pp 'semodule -l | awk '{print "-i " $1 
> > > ".pp"}''
> > 
> > BTW, any reason we wouldn't support the same thing for -u or -r?
> > 
> 
> -r wouldn't work well because it wants the name of the module (eg.,
> apache) instead of the filename (apache.pp)

Still useful for e.g. removing a list of modules specified in a file,
ala semodule -r `cat killlist`

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
