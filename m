Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79CEL98024800
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 08:14:21 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l79CEIea021389
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 12:14:19 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: reference policy filesystem.if
Date: Thu, 9 Aug 2007 08:11:01 -0400
Message-ID: <1186661461.25504.15.camel@gorn.columbia.tresys.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0219DB98@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0219DB98@blums0008.bluelnk.net>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-08 at 16:01 -0700, Clarkson, Mike R (US SSA) wrote:
> Aside from the obvious comment cut and paste error, shouldn't this
> interface also provide add_entry_dir_perms?

No, it shouldn't.  Those perms are for creating a file in a directory,
and write doesn't imply create.

> Maybe this has fixed in newer versions of the reference policy. I'm
> using refpolicy-20061212.tar.bz2 downloaded from Tresys.
> 
> 
> ########################################
> ## <summary>
> ##	Read files on a NFS filesystem.
> ## </summary>
> ## <param name="domain">
> ##	<summary>
> ##	Domain allowed access.
> ##	</summary>
> ## </param>
> #
> interface(`fs_write_nfs_files',`
> 	gen_require(`
> 		type nfs_t;
> 	')
> 
> 	allow $1 nfs_t:dir list_dir_perms;
> 	write_files_pattern($1,nfs_t,nfs_t)
> ')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
