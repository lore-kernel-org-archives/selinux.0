Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14FkO53008138
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 10:46:24 -0500 (EST)
Subject: Re: How to install CVS wine
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107531236.8078.70.camel@moss-spartans.epoch.ncsc.mil>
References: <1107499460.29033.7.camel@cobra.ivg2.net>
	 <1107520773.8078.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1107521277.8078.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1107531407.31488.4.camel@cobra.ivg2.net>
	 <1107531236.8078.70.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 10:46:18 -0500
Message-Id: <1107531978.31488.9.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 10:33 -0500, Stephen Smalley wrote:
> On Fri, 2005-02-04 at 10:36, Ivan Gyurdiev wrote:
> > I haven't done anything with roles so far, but I will investigate :)
> > Speaking of roles, is the jadmin user in local.users supposed to be 
> > uncommented? It's been that way for a while.
> 
> Looks like an oversight to me.  Dan?  Jim?

.. and why is it that when I change it nothing happens?
Is this the wrong file?

I'm editing /etc/selinux/strict/src/policy/local.users

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
