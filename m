Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8RJPXrT003896
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 15:25:33 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8RJOVhp010158
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 19:24:31 GMT
Subject: Re: Patch for strict policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41584D2F.5020902@redhat.com>
References: <41542FF5.2090502@redhat.com>
	 <1096303384.3234.7.camel@moss-lions.epoch.ncsc.mil>
	 <41584D2F.5020902@redhat.com>
Content-Type: text/plain
Message-Id: <1096313069.3234.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 27 Sep 2004 15:24:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged -- I think.  

There were an awful lot of cvs adds and removes, I believe I got them
all, but... :)

On Mon, 2004-09-27 at 13:26, Daniel J Walsh wrote:
> James Carter wrote:
> 
> >Shouldn't there be a ktalkd.te?  I don't think ktalkd_exec_t is defined
> >anywhere.
> >
> >On Fri, 2004-09-24 at 10:32, Daniel J Walsh wrote:
> >  
> >
> >>Added policy templates for swat, ktalkd, in.comcast, and rsyn daemons to 
> >>be run by xinetd.
> >>Separated out inetd_child_t context into a macro.
> >>Mailman fixes
> >>
> >>______________________________________________________________________
> >>diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ktalkd.fc policy-1.17.20/file_contexts/program/ktalkd.fc
> >>--- nsapolicy/file_contexts/program/ktalkd.fc	1969-12-31 19:00:00.000000000 -0500
> >>+++ policy-1.17.20/file_contexts/program/ktalkd.fc	2004-09-24 10:05:50.845362460 -0400
> >>@@ -0,0 +1,2 @@
> >>+# kde talk daemon 
> >>+/usr/bin/ktalkd	--	system_u:object_r:ktalkd_exec_t
> >>    
> >>
> >
> >  
> >
> Oops, yes here is a new patch including ktalkd, some of russells fixes.
> 
> ______________________________________________________________________
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
