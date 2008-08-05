Message-ID: <48985A96.4090402@city-fan.org>
Date: Tue, 05 Aug 2008 14:50:14 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Patch to make libselinux shut up when SELinux is disabled.
References: <4880CFD1.1040102@redhat.com>	 <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>	 <4880D585.9000405@redhat.com> <1216403646.17602.339.camel@moss-spartans.epoch.ncsc.mil> <4880E5E1.8050303@redhat.com> <48971AFA.3070708@city-fan.org> <48973F71.9020402@redhat.com>
In-Reply-To: <48973F71.9020402@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Paul after discussions at the OLS/SELinux mini summit.  Karl MacMillan
> had an interesting talk about how we are perhaps going to far with Least
> Priv.  And the idea of common security goals came up.  He was talking
> about grouping applications with common security constraints into a
> greater policy, this would eliminate lots of potential bugs without
> decreasing security that greatly.  The best example of this in my
> opinion has been our treatment of spam.  We have multiple packages
> within Fedora/Debian whose main goals are the prevention of spam email
> reaching the user.  Spamassassin, razor, pyzor/spamass-milter probably
> more.  Each one of these has a written policy for it and interacts with
> the multiple email clients.  These have caused a huge amount of
> AVCs/Bugzilla's.  And they all pretty much have the same security
> problems.  We want to prevent either a daemon or a user app from reading
> untrusted mail and then doing something bad.  So in Rawhide I have
> worked to consolodate these policies into two types spamd_t and a
> spamc_t policy.   Where the difference is a spam daemon or spam client
> application.  Then we can begin collapsing the rules and labeling down
> to the directories that all of the similar apps need to use.  Hopefully
> this will simplify the policy and eliminate the breakage we currently
> have in handling spam.

This is interesting in that the DAC world seems to have been moving in 
the opposite direction in recent years, such as the split of sendmail 
into separate daemon (not suid root) and client with 8.12, openssh 
adding privilege separation in a small helper etc.

Anyway, what I'm doing with spamass-milter probably ties in reasonably 
well with the Rawhide approach. The milter sits in a sort of middle 
ground between being a daemon and a client. It's a daemon in that it's 
directly involved in SMTP processing with the MTA, but as far as 
spamassassin is concerned, it's a client, calling spamc just like any 
other client.

The only thing directly spam-related in the spamass-milter policy is the 
call to the spamassassin_domtrans_spamc() interface, so I'm leveraging 
the work already done for regular SA usage. All of the other stuff is 
milter-specific and not generally useful to other spam-attacking 
applications I think, though there's a lot of commonality with other 
milter applications, hence the template approach I'm using.

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
