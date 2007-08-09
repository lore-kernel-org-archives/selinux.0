Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79JZqFS002632
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 15:35:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l79JZnVe002058
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 19:35:49 GMT
Subject: RE: reference policy filesystem.if
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0219DBB5@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0219DB98@blums0008.bluelnk.net>
	 <1186661461.25504.15.camel@gorn.columbia.tresys.com>
	 <FB39F4E77226B448BC1388D3BE4E00CD0219DBB5@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 19:35:16 +0000
Message-Id: <1186688116.25504.24.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 07:28 -0700, Clarkson, Mike R (US SSA) wrote:
> Since we're dealing with files in this case, and given that append is a
> separate permission from write, why doesn't writing a file imply
> creating a file?

You may want to limit a domain to only write to existing files and not
create new ones.

> > -----Original Message-----
> > From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> > Sent: Thursday, August 09, 2007 5:11 AM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov
> > Subject: Re: reference policy filesystem.if
> > 
> > On Wed, 2007-08-08 at 16:01 -0700, Clarkson, Mike R (US SSA) wrote:
> > > Aside from the obvious comment cut and paste error, shouldn't this
> > > interface also provide add_entry_dir_perms?
> > 
> > No, it shouldn't.  Those perms are for creating a file in a directory,
> > and write doesn't imply create.
> > 
> > > Maybe this has fixed in newer versions of the reference policy. I'm
> > > using refpolicy-20061212.tar.bz2 downloaded from Tresys.
> > >
> > >
> > > ########################################
> > > ## <summary>
> > > ##	Read files on a NFS filesystem.
> > > ## </summary>
> > > ## <param name="domain">
> > > ##	<summary>
> > > ##	Domain allowed access.
> > > ##	</summary>
> > > ## </param>
> > > #
> > > interface(`fs_write_nfs_files',`
> > > 	gen_require(`
> > > 		type nfs_t;
> > > 	')
> > >
> > > 	allow $1 nfs_t:dir list_dir_perms;
> > > 	write_files_pattern($1,nfs_t,nfs_t)
> > > ')
> > 
> > --
> > Chris PeBenito
> > Tresys Technology, LLC
> > (410) 290-1411 x150
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
