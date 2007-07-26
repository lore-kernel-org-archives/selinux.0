MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: newrole and ftp
Date: Thu, 26 Jul 2007 13:48:44 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB7469@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB7440@blums0008.bluelnk.net> <1185475697.12224.216.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, July 26, 2007 11:48 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov; Christopher J. PeBenito
> Subject: Re: newrole and ftp
> 
> On Thu, 2007-07-26 at 11:29 -0700, Clarkson, Mike R (US SSA) wrote:
> > When I use newrole to start up an ftp server at a particular mls
level,
> > it doesn't start the server at the specified level. For instance:
> >
> > newrole -l SystemHigh -- -c "/etc/init.d/vsftpd start"
> >
> > The server starts up with the range SystemLow-SystemHigh.
> >
> > However, this works:
> >
> > runcon -t ftpd_t -l SystemHigh /etc/init.d/vsftpd start
> >
> > Anyone know why?
> 
> Sounds like a range_transition rule causing the exec
> of /etc/init.d/vsftpd to automatically transition to
> SystemLow-SystemHigh.
> 
> In the newrole case, you have newrole exec'ing the user's shell in a
> specified context, and then the user's shell exec'ing the command w/o
> any specific context, thus automatic domain, role, or range
transitions
> may take affect.
> 
> In the runcon case, you have runcon directly executing the command in
a
> specified context, thereby overriding any automatic transitions
defined
> in policy.
> 
> Possibly newrole should have a way to directly exec commands without
> going through a shell.
> 
> But the first question is whether you have such a range transition
rule
> in your policy, and if so, did you mean to have such a rule?

Yes, the problem resulted because I was starting out in the unconfined_t
domain. /etc/init.d/vsftpd is labeled initrc_exec_t, and the unconfined
domain makes the call init_domtrans_script(unconfined_t) which includes
a range_transition rule. A simple workaround was to reset my domain as
well as my level so that the range_transition rule would not apply:
	newrole -t ftpd_t -l SystemHigh -- -c "/etc/init.d/vsftpd start"

BTW, thanks for pointing out the range_transition rule. I wasn't aware
of them.

> 
> --
> Stephen Smalley
> National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
