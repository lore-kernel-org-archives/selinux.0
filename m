Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7DHqkrT025406
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 13:52:46 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7DHq8Uu020418
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 17:52:08 GMT
Subject: Re: vsftpd and security labels
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Marcus" <jmarcus@mvalent.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CA50D95@exchange.mvalent.local>
References: <E6E16A6D4277CD459BBDE6713766033CA50D95@exchange.mvalent.local>
Content-Type: text/plain
Message-Id: <1092419487.23108.260.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 13:51:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-13 at 11:23, James R. Marcus wrote:
> /usr/sbin/setfiles:  read 570 specifications
> /usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
> line number 596

This means that the new policy wasn't loaded into the kernel, so it
doesn't recognize the new types defined by the ftpd policy.  Reload your
policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
