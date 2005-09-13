Subject: Re: error building file_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1126620421.4218.18.camel@localhost.localdomain>
References: <1126563533.13869.5.camel@localhost>
	 <1126617433.29303.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1126618085.4218.14.camel@localhost.localdomain>
	 <1126620053.29303.59.camel@moss-spartans.epoch.ncsc.mil>
	 <1126620421.4218.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 10:18:39 -0400
Message-Id: <1126621119.29303.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 15:07 +0100, Antoine Martin wrote:
> Any code snippet to do the pre-processing? Or do I have to extract the
> code from the Makefile?

Actually, the replacement of HOME* and ROLE* is what genhomedircon does.
Full circle.

Possibly you could just send a copy of your file_contexts file?  I
suppose it would be the temporary copy just prior to running
genhomedircon, i.e. file_contexts/file_contexts.tmp.  Might need to
modify your Makefile to not remove it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
