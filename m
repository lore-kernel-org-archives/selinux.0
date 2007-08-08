Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78N1T8X013108
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 19:01:29 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78N1SsW003408
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 23:01:28 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l78N0WK7009486
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 19:00:32 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l78N01Xl016087
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 19:00:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: reference policy filesystem.if
Date: Wed, 8 Aug 2007 16:01:25 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0219DB98@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Aside from the obvious comment cut and paste error, shouldn't this
interface also provide add_entry_dir_perms?

Maybe this has fixed in newer versions of the reference policy. I'm
using refpolicy-20061212.tar.bz2 downloaded from Tresys.


########################################
## <summary>
##	Read files on a NFS filesystem.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`fs_write_nfs_files',`
	gen_require(`
		type nfs_t;
	')

	allow $1 nfs_t:dir list_dir_perms;
	write_files_pattern($1,nfs_t,nfs_t)
')



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
