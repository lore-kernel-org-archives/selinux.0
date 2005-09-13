Subject: Re: error building file_contexts
From: Antoine Martin <antoine@nagafix.co.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1126620053.29303.59.camel@moss-spartans.epoch.ncsc.mil>
References: <1126563533.13869.5.camel@localhost>
	 <1126617433.29303.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1126618085.4218.14.camel@localhost.localdomain>
	 <1126620053.29303.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 15:07:01 +0100
Message-Id: <1126620421.4218.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 10:00 -0400, Stephen Smalley wrote:
> On Tue, 2005-09-13 at 14:28 +0100, Antoine Martin wrote:
> > Where is this regex coming from? Is there any way to figure out which .fc
> > it is coming from? Is there a tool to validate .fc files individually?
> 
> Given that this particular regex is being mutated by genhomedircon, I'd
> suggest instrumenting the script itself or tracing it to see the actual
> value of regex there.
I tried tracing it but didn't get anywhere :-(

> File contexts files can be validated against a policy via setfiles -c,
> but they have to be preprocessed, i.e. m4 ifdefs, HOME*, and ROLE* have
> to be expanded already.
Any code snippet to do the pre-processing? Or do I have to extract the
code from the Makefile?

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
