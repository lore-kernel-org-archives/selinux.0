Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79ET9DM004475
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 10:29:09 -0400
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79ET6ea023173
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:29:07 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l79ERLgA010240
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 10:27:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: reference policy filesystem.if
Date: Thu, 9 Aug 2007 07:28:15 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0219DBB5@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0219DB98@blums0008.bluelnk.net> <1186661461.25504.15.camel@gorn.columbia.tresys.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since we're dealing with files in this case, and given that append is a
separate permission from write, why doesn't writing a file imply
creating a file?

> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Thursday, August 09, 2007 5:11 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: reference policy filesystem.if
> 
> On Wed, 2007-08-08 at 16:01 -0700, Clarkson, Mike R (US SSA) wrote:
> > Aside from the obvious comment cut and paste error, shouldn't this
> > interface also provide add_entry_dir_perms?
> 
> No, it shouldn't.  Those perms are for creating a file in a directory,
> and write doesn't imply create.
> 
> > Maybe this has fixed in newer versions of the reference policy. I'm
> > using refpolicy-20061212.tar.bz2 downloaded from Tresys.
> >
> >
> > ########################################
> > ## <summary>
> > ##	Read files on a NFS filesystem.
> > ## </summary>
> > ## <param name="domain">
> > ##	<summary>
> > ##	Domain allowed access.
> > ##	</summary>
> > ## </param>
> > #
> > interface(`fs_write_nfs_files',`
> > 	gen_require(`
> > 		type nfs_t;
> > 	')
> >
> > 	allow $1 nfs_t:dir list_dir_perms;
> > 	write_files_pattern($1,nfs_t,nfs_t)
> > ')
> 
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
