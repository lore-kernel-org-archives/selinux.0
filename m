Date: Wed, 22 Apr 2009 23:27:31 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Problems related to using SELinux
Message-ID: <20090423042731.GA12270@us.ibm.com>
References: <1239290911.22856.58.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239290911.22856.58.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Carter (jwcart2@tycho.nsa.gov):
> 1. Differences between different distributions
> 	a. setroubleshoot
> 	b. Denial log location
> 	c. init system
> 	d. Use of MLS
> 2. The tools related to SELinux are not consistently named
> 	a. It is hard to discover the right command.
> 3. Inadequate documentation
> 	a. Of the low-level mechanisms
> 	b. For the policy author
> 	c. For the administrator
> 	d. For the user

Just to elaborate on the documentation for the user...

Something which i would want to know how to do as a new admin or owner
of an selinux system is lock down a userid to something other than
unconfined_t. I.e. one userid to play games, one to do banking, etc.
This should be pretty simple, maybe

	useradd xa
	semanage user -a -R user_r xa
	semanage login -a -s xa xa

but figuring out the right recipes can be unnecessarily painful.

A few specific things which I think could help users (at least
those who don't use the guis):

1. 'semanage login help' (for instance) could give context-specific help

2. man adduser/useradd could point either to semanage, or to selinux.8
(and smack.8 if these are part of the man-pages project).

3. selinux.8 could use either a section on user/domain lockdown, or
a pointer to semanage, or a pointer to a seuser.8 or somesuch overview
file.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
