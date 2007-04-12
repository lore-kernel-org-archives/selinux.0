Subject: Re: [Fwd: Re: seobject.py setransRecords.get_all method return
	values]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <461D24AC.8040601@gmail.com>
References: <461D24AC.8040601@gmail.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 12:22:48 -0400
Message-Id: <1176394968.3986.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-11 at 13:10 -0500, Ted X Toth wrote:
> email message attachment (Re: seobject.py setransRecords.get_all
> method return values)
> > -------- Forwarded Message --------
> > From: Xavier Toth <txtoth@gmail.com>
> > To: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan
> > <kmacmillan@mentalrootkit.com>
> > Subject: Re: seobject.py setransRecords.get_all method return values
> > Date: Tue, 10 Apr 2007 09:01:19 -0500
> > 
> > On 4/10/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On Mon, 2007-04-09 at 14:08 -0500, Ted X Toth wrote:
> > > > When you have aliases in your setrans.conf
> > > > seobject.setransRecords().get_all returns a dictionary containing values
> > > > with the last alias whereas the first alias  is what I'd like (this is
> > > > also what the os uses). Alternatively it could return an ordered list of
> > > > all of the aliases as the dictionary values or maybe this would be a
> > > > different method.
> > >
> > > Unless such a change would pose a problem for current users of
> > > seobject.setransRecords().get_all, I'd be fine with changing it to
> > > return the first alias, and possibly introduce another method if we need
> > > to return all the aliases (to preserve interface compatibility).  cc'd
> > > Dan and Karl since they are likely to be more familiar with how this is
> > > being used today by tools like system-config-selinux.
> > >
> > > Do you want to submit a patch or are you making a RFE?
> > >
> > > --
> > > Stephen Smalley
> > > National Security Agency
> > >
> > >
> > Here's a patch for the first versus last alias. I'm not sure yet about
> > needing all of the aliases.

Just for future reference, please make patches that will apply with -p0
or -p1 from the top of the tree.

Thanks, applied as of policycoreutils 2.0.9.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
