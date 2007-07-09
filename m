To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: getfilecon return code
References: <ogtmyy5lacd.fsf@oolong.mitre.org>
	<1184005840.12430.139.camel@moss-spartans.epoch.ncsc.mil>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 09 Jul 2007 16:01:44 -0400
In-Reply-To: <1184005840.12430.139.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <ogt644tl51z.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve, 

Thanks for your quick reply.

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On Mon, 2007-07-09 at 14:07 -0400, John D. Ramsdell wrote:
> > ... In fact, I wrote code that freecon'd a context whenever the
> > return value was not -1.
> 
> freecon(NULL) is perfectly legal and harmless, like free(NULL), so
> that part is ok.

There is also the case of printing a security context.  The getfilecon
program that is part of the libselinux package thinks one can print a
security context if the return code is non-negative, and thus prints:

/proc/sys/kernel/pid_max	(null)

If some other program tried to use the second field of this output as
a security context, it could spell trouble.

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
