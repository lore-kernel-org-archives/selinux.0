Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UG8YDo015765
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 11:08:34 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UG4jph021912
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:04:45 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com>
References: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 11:13:24 -0500
Message-Id: <1112199204.8592.13.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 07:52 -0800, Casey Schaufler wrote:
> --- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > On Wed, 2005-03-30 at 07:05 -0800, Casey Schaufler
> > wrote:
> > ...
> > > > Desktop apps will be restricted to only access
> > the
> > > > appropriate one.
> > > > "Downloading" apps will be restricted to
> > download to
> > > > untrusted_content_t. 
> > > 
> > > Am I the only one wary of a slippery slope here?
> > 
> > What's the problem?
> 
> Unless I read your intent incorrectly (which
> is possible) you're talking about requiring
> the rearchitecting of the data storage schemes
> for every user application on the planet to
> accomodate the presence of DTE. And you're
> talking about it as if it might actually happen.

Do you have a better proposal for restricting desktop applications
to minimum privilege?

Nothing needs to be rearchitectured. The user just needs
to be made aware that this is where the documents belong, and
the app can't write all over the place like it would in a non-selinux
environment. Apps that still run in user_t would be unaffected until
their policy is changed.

Of course, I'm thinking in the future such folders would be prominently
displayed in Gnome with their own little icons, and their windows-style
names like "My Media" or whatever (which should not be the same 
as the actual dir. name), and those would go in the Places menu or
something, and sound juicer for example would know to write there by
default as opposed to somewhere else. 

I guess this discussion now becomes more GNOME-oriented, now that I
think about it. Maybe I should go bother the GNOME people to see what
they think about adding content-specific folders to /home that we can
label with different contexts..

... or am I missing something fundamental here? 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
