Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n150bPj7010805
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2009 19:37:25 -0500
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n150bNh3023429
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2009 00:37:24 GMT
Date: Thu, 5 Feb 2009 11:37:21 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1] selinux: Remove the "compat_net" compatibility
 code
In-Reply-To: <20090204214236.11992.20432.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0902051136560.5054@tundra.namei.org>
References: <20090204214236.11992.20432.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Feb 2009, Paul Moore wrote:

> The SELinux "compat_net" is marked as deprecated, the time has come to
> finally remove it from the kernel.  Further code simplifications are
> likely in the future, but this patch was intended to be a simple,
> straight-up removal of the compat_net code.

Need to also remove documentation from Documentation/kernel-parameters.txt

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
