Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TJmTlA028246
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 14:48:29 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TJnVUJ017119
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 19:49:31 GMT
Message-ID: <45BE4FC6.4090502@mentalrootkit.com>
Date: Mon, 29 Jan 2007 14:49:26 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Catalin DIMA <dima@univ-paris12.fr>
CC: selinux@tycho.nsa.gov
Subject: Re: Problems installing current version of refpolicy with FC6
References: <45BE44FC.8080303@univ-paris12.fr>
In-Reply-To: <45BE44FC.8080303@univ-paris12.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Catalin DIMA wrote:
> I am trying to install different versions of refpolicy on Dell X1 
> machines with FC6, for teaching purposes, but no choice of build.conf 
> parameters can make it.

Just to check - are you certain that you want the full policy? You may 
be able to do the teaching you need with policy modules only.

  I get outcomes from "kernel panic" (when trying
> to install the "strict monolithic" version of refpolicy) to system stall 
> (when trying to install "targeted monolithic" version), or outputs like 
> below (when trying to install "targeted modular" version -- this 
> installation ends in stack problems which also cause system halt). Every 
> time the kernel does not panic, there's a whole list of booleans that 
> are unknown to libsepol.load_booleans, though generated from refpolicy 
> via the "install" target of the Makefile.
> 

Did you enable mcs? The standard FC6 policy is targeted-mcs and the 
presence of the mcs components in the file system labels may be the 
cause of your problems.

> I have tried on two different laptops but the outcome is the same. I 
> have also tried with the latest or older versions and the output is the 
> same. Did anyone observe similar behaviors with laptops/FC6/refpolicy ?...
> 
> Output :
> libsepol.load_booleans: unknown boolean user_ttyfile_stat (and others)

The unknown boolean messages should be harmless I believe.

You can extract the build.conf from the policy source rpm as well, which 
is likely a good starting point.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
