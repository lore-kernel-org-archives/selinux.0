Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m17N2t4g018053
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 18:02:55 -0500
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m17N2ru0020357
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 23:02:53 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m17N2TTb009738
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 18:02:29 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m17N2G2Z012544
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 18:02:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ps access
Date: Thu, 7 Feb 2008 15:02:45 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0296160B@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does something equivalent to the below interface exist for the strict
policy? I'm using RHEL5.1 and didn't see anything. If not, it would be a
nice addition. I added this to userdomain.if

################################################
## <summary>
## Allow the ps command visibility to processes in
## the specified domain when used by an 
## unprivileged user
## </summary>
## <desc>
## <param name="domain_allowed_access">
## Domain for which the ps command will have access
## </param
## 
interface(`allow_unpriv_ps_access',`
  gen_require(`
    type $1;
    attribute unpriv_userdomain;
  ')

  ## need this to allow ps to see the process files in the /proc dir
  allow unpriv_userdomain $1:dir search_dir_perms;
  allow unpriv_userdomain $1:file read_file_perms;
  allow unpriv_userdomain $1:lnk_file read_lnk_file_perms;
  allow unpriv_userdomain $1:process getattr;
')



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
