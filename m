Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CCwHrT001609
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 08:58:17 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CCwGPJ008212
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 12:58:16 GMT
Subject: Re: policy to allow upgrade of nfs-utils
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407111904.24856.russell@coker.com.au>
References: <200407081319.05138.russell@coker.com.au>
	 <200407092252.08749.russell@coker.com.au>
	 <1089392030.11726.66.camel@moss-spartans.epoch.ncsc.mil>
	 <200407111904.24856.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089637087.22449.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 08:58:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 05:04, Russell Coker wrote:
> A patched version of vi should solve that.  In any case if the file gets etc_t 
> then it is just readable to everyone which isn't so bad.  The only potential 
> problem is if you edit the file with an unpatched editor and delete all 
> content so that initrc_t will want to append "#" to it.
> 
> What do you think of the attached patch?

Looks ok, but is it sufficient, i.e. does it only require permission to
write to the existing /etc/exports, or does it need to be able to unlink
and re-create the file?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
