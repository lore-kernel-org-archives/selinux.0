Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB5KUXsO000807
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2013 15:30:33 -0500
Message-ID: <52A0E25A.6000800@tresys.com>
Date: Thu, 5 Dec 2013 15:30:18 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Information flow paths over devtty_t
References: <1386273455.65331.YahooMailNeo@web163402.mail.gq1.yahoo.com>
In-Reply-To: <1386273455.65331.YahooMailNeo@web163402.mail.gq1.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/05/13 14:57, Andy Ruch wrote:
> I'm implementing a strict SELinux policy based on the reference policy using RHEL 6.3. Using 'apol' to analyze my information flow paths, I've been able to eliminate most of the tty/console paths. However, I can't seem to find a way to eliminate the access to the controlling terminal devtty_t.
> 
> I see that this is allowed in domain.te:
> 
> # Use trusted objects in /dev
> dev_rw_null(domain)
> dev_rw_zero(domain)
> term_use_controlling_term(domain)
> 
> 
> Is devtty_t something I should be concerned about? Is this a type that can be used to share information between processes or is it special like /dev/null and /dev/zero?

Its essentially an alias for the terminal associated with the process.  So read/write to it is the same as read/write on the actual tty/pty.  So two processes could only communicate if the real terminal, e.g. /dev/tty0 is accessible to both of the processes.

see `man 4 tty`

So in a nutshell, its special like /dev/null and zero, so typically its ignored during an info flow analysis.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
