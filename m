Subject: RE: mls contraints on adding files to directories
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, Scott Lawler <scott.lawler@lightspeed-tech.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBFAB8@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBFA97@blums0008.bluelnk.net>
	 <1182799181.5636.156.camel@moss-spartans.epoch.ncsc.mil>
	 <FB39F4E77226B448BC1388D3BE4E00CD01DBFAAF@blums0008.bluelnk.net>
	 <1182805012.5636.184.camel@moss-spartans.epoch.ncsc.mil>
	 <FB39F4E77226B448BC1388D3BE4E00CD01DBFAB8@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 17:21:42 -0400
Message-Id: <1182806502.5636.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 14:14 -0700, Clarkson, Mike R (US SSA) wrote:
> 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Monday, June 25, 2007 1:57 PM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov; Scott Lawler
> > Subject: RE: mls contraints on adding files to directories
> > 
> > On Mon, 2007-06-25 at 13:18 -0700, Clarkson, Mike R (US SSA) wrote:
> > >
> > > > -----Original Message-----
> > > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > > > Sent: Monday, June 25, 2007 12:20 PM
> > > > To: Clarkson, Mike R (US SSA)
> > > > Cc: selinux@tycho.nsa.gov
> > > > Subject: Re: mls contraints on adding files to directories
> > > >
> > > > On Mon, 2007-06-25 at 11:54 -0700, Clarkson, Mike R (US SSA)
> wrote:
> > > > > I think that I'm misunderstanding the mls constraints on adding
> > > files to
> > > > > directories.
> > > > >
> > > > > I thought that the following constraint would prevent adding a
> file
> > > at a
> > > > > higher security level than the directory, unless the domain of
> the
> > > > > writing process had been given the mlsfilewritetoclr attribute,
> or
> > > the
> > > > > directory type had been given the mlstrustedobject attribute:
> > > > >
> > > > > mlsconstrain dir { add_name remove_name reparent rmdir }
> > > > > 	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > > > 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1
> domby
> > > > > l2 )) or
> > > > > 	 ( t1 == mlsfilewrite ) or
> > > > > 	 ( t2 == mlstrustedobject ));
> > > >
> > > > (l1, h1) are the low and high levels of the process.
> > > > (l2, h2) are the low and high levels of the directory (usually the
> > > > same).
> > > >
> > > > This is a constraint on a permission check between the process and
> the
> > > > parent directory.  The new file's label doesn't come into play at
> all
> > > in
> > > > this constraint.
> > >
> > > What you mention above is what I understood. However, I would have
> > > expected the touch cmd below to fail. Since I ran the touch cmd
> using
> > > runcon -s3, the touch cmd process's l1 and h1 are both s3.
> > 
> > Hmmm...does runcon set both low and high or just low?  BTW, under the
> > -mls policy, you have to use newrole to change levels like that, so
> you
> > obviously aren't using the same policy we are.
> 
> I just did a quick test, and it appears that runcon sets both the low
> and high levels. In one window I typed:
> 	
> # runcon -l s2 sleep 15
> 
> In another window I typed:
> 
> # ps -efZ | grep sleep
> root:system_r:unconfined_t:s2   root     27399 18911  0 21:05 pts/3
> 00:00:00 sleep 15
> 
> Without the runcon I get a range since my shell has the range of
> SystemLow-SystemHigh
> 
> You're correct, we are not using the mls policy distributed with RHEL5.
> We're currently using a mls policy based off of the targeted policy,
> with the intent to switch to the strict-mls policy distributed with
> RHEL5 once we get our domains set up.
> 
> What's the reason behind not letting runcon switch levels? 

runcon is just a user utility that runs with no additional privileges
beyond what the user already has.  Letting the user directly jump levels
(and without the safeguards placed into newrole) considered harmful.

newrole runs in a separate protected domain and has additional
processing relevant to MLS, like resetting descriptors, relabeling ttys,
setting up polyinstantiated directories, etc.

In any event, it is hard to diagnose the issue without seeing your
policy, or at least the relevant portions thereof.  
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
