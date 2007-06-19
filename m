Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JJHb7p003667
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:17:37 -0400
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JJHa1U019828
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 19:17:36 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l5JJH6Y9026544
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:17:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: problem setting the security context of directories vs files
Date: Tue, 19 Jun 2007 12:17:31 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01DBF82C@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBF7FE@blums0008.bluelnk.net> <1182272762.2086.78.camel@moss-lions.epoch.ncsc.mil> <467810A5.3090306@redhat.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>, <jwcart2@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a way to apply a context recursively to all subdirectories
below a directory?

For instance, I'd like to label all subdirectories below
"/m2ds/import/stage" as system_u:object_r:import_dir_t:s0, without
explicitly having to list each one (because I'm lazy)

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Tuesday, June 19, 2007 10:22 AM
> To: jwcart2@epoch.ncsc.mil
> Cc: Clarkson, Mike R (US SSA); selinux@tycho.nsa.gov
> Subject: Re: problem setting the security context of directories vs
files
> 
> James Carter wrote:
> > On Tue, 2007-06-19 at 09:34 -0700, Clarkson, Mike R (US SSA) wrote:
> >
> >> I'm having trouble setting the security context of directories
using
> >> file contexts. It seems to be working fine for files, but not
> >> directories.
> >>
> >> I have a module named import. Here is a copy of my import.fc file:
> >>
> >> /m2ds/import	--
gen_context(system_u:object_r:import_dir_t,s0)
> >> /m2ds/import/datasources	--
> >> gen_context(system_u:object_r:import_dir_t,s0)
> >> /m2ds/import/stage	--
> >> gen_context(system_u:object_r:import_stage_t,s0)
> >> /m2ds/import/junk	--
> >> gen_context(system_u:object_r:import_dir_t,s0)
> >> /home/m2/SimulatedImport/bin/SimulatedImport	--
> >> gen_context(system_u:object_r:import_exec_t,s0)
> >> /home/m2/SimulatedImport/bin/SimulatedImport_Server	--
> >> gen_context(system_u:object_r:import_exec_t,s0)
> >>
> >>
> >>
> > Use "-d" for directories, instead of "--".
> >
> > The obscure options available to use are:
> > -b	block
> > -c	character
> > -d 	directory
> > -p	pipe
> > -l	link
> > -s	socket
> > --	regular
> >
> >
> >
> "  " matches all.
> "-" followed by the first character output by 'ls -l'.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
