Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JH66rT000720
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 13:06:06 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JH4pvJ002532
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 17:04:52 GMT
Subject: Re: MySQL Policy Patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jiann-Ming Su <sujiannming@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <561dc326041019095644afc579@mail.gmail.com>
References: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net>
	 <561dc326041019095644afc579@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1098205374.29525.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 13:02:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 12:56, Jiann-Ming Su wrote:
> I'm new to SE Linux.  Where can I download the mysql policy?  I'm
> using Fedora Core 2, if that helps.  Thanks for any tips.

IIRC, on FC2, you would do:
yum install policy-sources
cd /etc/security/selinux/src/policy
vi domains/program/mysqld.te

to look at the mysqld policy that shipped with FC2.  But you would
likely do better to update to FC3T3 if using SELinux, as much has
changed and FC2 policy hasn't had any updates AFAIK.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
