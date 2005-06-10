Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1118415315.10190.329.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118319901.10190.25.camel@localhost>
	 <1118342206.30110.132.camel@moss-spartans.epoch.ncsc.mil>
	 <1118413296.10190.312.camel@localhost>
	 <1118413116.3774.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1118415315.10190.329.camel@localhost>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 10:50:01 -0400
Message-Id: <1118415001.3774.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 15:55 +0100, antoine wrote:
> Not sure about the can_exec though? Why would you ever want to execute a
> logfile?

Good question.  I know that at one point, logrotate was generating
temporary script files and executing them, but they should have their
own type, and it looks like even that has been removed from the Fedora
logrotate (by a -noTMPDIR patch).   I'd drop it and see if anything
breaks.

You may also want to check how the Gentoo logrotate compares with the
one in the Fedora CVS tree; looks like there are several patches in the
Fedora package, including one related to SELinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
