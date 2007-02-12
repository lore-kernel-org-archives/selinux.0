Message-ID: <45D0A0A8.1060603@us.ibm.com>
Date: Mon, 12 Feb 2007 11:15:20 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ted X Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: su and context
References: <45CDEDEE.4050205@gmail.com>  <45D09836.5060007@us.ibm.com> <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> The behavior has actually changed over time; you'll find discussions
> about it in the mailing list archives.  The original SELinux kept su
> separate from security context changes.  Earlier versions of Fedora (and
> RHEL 4) integrated them (via pam_selinux) in an effort to provide
> greater transparency, but this caused its own set of problems (e.g. use
> of su from init scripts, losing continuity of context across su when you
> want it for roles and levels).  More recent versions of Fedora (and RHEL
> 5) split them back out again.  One might add an option to su to support
> simultaneous newrole, but you don't want it by default.

I can see having both the functionality of su and newrole in one tool 
being a nice short-cut, but then you really still need the distinctive 
functionality to be supported, the is: changing DAC and changing MAC.

You will need to be able to specify which admin role you wish to 
transition to, much in the same way you can specify the UID/uname to 
change to. However, it would not be possible to specify a default role 
to transition to (without a config file) since SELinux has no 
pre-defined admin role (like root).

I'd just leave them separate.

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
