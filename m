Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DCxbrT002280
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 08:59:37 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DCwgHC004457
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 12:58:42 GMT
Subject: Re: Type or domain for module utility?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040911160301.54915.qmail@web51502.mail.yahoo.com>
References: <20040911160301.54915.qmail@web51502.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1095080257.22460.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 08:57:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-09-11 at 12:03, Park Lee wrote:
> The second goal is to protect the integrity of the kernel. The policy
> configuration defines distinct types for the boot files,......, module
> utilities, ......  .It defines separate domains for the module
> utilities, .......  .It only allows a small set of privileged domains
> to transition 
> to he module utility domains.
>  
> Then, does it means that the policy configuration defines both type
> and domain for module utility?
> Is there some thing wrong?

Type for the program file (e.g. insmod_exec_t), domain for the process
in which it runs (e.g. insmod_t).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
