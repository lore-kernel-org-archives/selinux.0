Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13137
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 12:33:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1DHXRI10274
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 17:33:27 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
        by jazzband.ncsc.mil  with ESMTP id h1DHXPf10265 for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 17:33:25 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.4/Switch-2.2.4) with SMTP id h1DHMGL26597
	for <selinux@tycho.nsa.gov>; Thu, 13 Feb 2003 11:22:16 -0600 (CST)
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14C62@md-exchange1.na.nai.com>
From: Kelly_Djahandari@nai.com
To: sds@epoch.ncsc.mil
Cc: selinux@tycho.nsa.gov
Subject: RE: File labeling issue
Date: Thu, 13 Feb 2003 09:36:18 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'll look at setfiles. I also want to test a different policy segment for
inetd. 

Kelly Djahandari
Network Associates Laboratories

> -----Original Message-----
> From: Stephen D. Smalley [mailto:sds@epoch.ncsc.mil]
> Sent: Monday, February 10, 2003 12:50 PM
> To: selinux@tycho.nsa.gov; Kelly_Djahandari@nai.com
> Subject: Re: File labeling issue
> 
> 
> 
> > While testing xinetd, I ran into a problem with the build of the
> > file_contexts file. Because file_contexts is a 
> concatenation of files in
> > alphabetical order, inetd.fc can override labeling of 
> /usr/sbin/in.*d files
> > if the fc file is alphabetically before inetd.fc.
> 
> The general issue has come up before on the list; it was originally
> mentioned as a concern when the file contexts configuration was
> partitioned into multiple files.  The setfiles logic needs to be
> revised to use the best matching specification.
> 
> > The default type for files in /usr/sbin is 
> system_u:object_r:sbin_t. If
> > services started by xinetd are labeled sbin_t, they are run 
> in the inetd_t
> > domain--not good. 
> 
> Yes, which is why there is a default labeling rule to put them into
> inetd_child_t.  Of course, if inetd_t doesn't need execute access to
> sbin_t at all, then you could simply remove the execute permission to
> it and possibly to any type that doesn't cause a domain transition.
> 
> > Talkd is an example of a service which does not have a fc
> > file and would be labeled with the default inetd.fc labeling
> > (inetd_child_exec_t).
> 
> Yes, the inetd_child_exec_t labeling is intended to put such daemons
> into a default domain.
> 
> > Is it reasonable to request that all services started by 
> inetd have a .fc
> > file and a corresponding .te file and remove the default 
> inetd labeling in
> > inetd.fc? 
> 
> IMHO, no.
> 
> > Or should we keep the default inetd labeling and figure out some
> > other way to not overwrite specific labeling? Since this 
> could be a problem
> > not just of inetd.fc, but with any wildcard usage, we may 
> need to think of a
> > more general solution. 
> 
> Yes, we should investigate revisions to the setfiles logic.
> 
> --
> Stephen Smalley, NSA
> sds@epoch.ncsc.mil
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
