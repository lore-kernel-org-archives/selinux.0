Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SGqCDo028080
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 11:52:12 -0500 (EST)
Received: from web31603.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j2SGpM1g013890
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 16:51:22 GMT
Message-ID: <20050328165109.60425.qmail@web31603.mail.mud.yahoo.com>
Date: Mon, 28 Mar 2005 08:51:09 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Desktop apps interoperability
To: Tom <tom@lemuria.org>, Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Fedora SELinux support list for users &amp,  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Tom <tom@lemuria.org> wrote:
> On Mon, Mar 28, 2005 at 12:27:31AM -0500, Ivan
> Gyurdiev wrote:
> > Part of the problem seems to be the way Linux apps
> treat /home, as the
> > place for everything. 
> 
> It doesn't. It treats $HOME as the only place that
> the user has
> permission to store his stuff. On a well-configured
> system, that
> assumption is correct.

Windows and MacOS are designed as single user systems.
Unix and Linux are designed as multiuser systems.
Configuring a Windows system for multiple 
concurrent users is quite painful. Configuring
unix for a single user seems unnecessarily difficult.

Interestly, when we did the B1/LSPP versions of 
unix the home directory model helped reduce the
problem of user sensitivity restrictions by
isolating the part of the directory hierarchy
that had to be customized for the user.


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
