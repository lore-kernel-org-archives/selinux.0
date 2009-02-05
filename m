Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n15CQPxV018627
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2009 07:26:25 -0500
Received: from g1t0027.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n15CQNEf025687
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2009 12:26:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v1] selinux: Remove the "compat_net" compatibility code
Date: Thu, 5 Feb 2009 07:26:20 -0500
Cc: selinux@tycho.nsa.gov
References: <20090204214236.11992.20432.stgit@flek.lan> <alpine.LRH.1.10.0902051136560.5054@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0902051136560.5054@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902050726.20367.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 04 February 2009 7:37:21 pm James Morris wrote:
> On Wed, 4 Feb 2009, Paul Moore wrote:
> > The SELinux "compat_net" is marked as deprecated, the time has come
> > to finally remove it from the kernel.  Further code simplifications
> > are likely in the future, but this patch was intended to be a
> > simple, straight-up removal of the compat_net code.
>
> Need to also remove documentation from
> Documentation/kernel-parameters.txt

Good catch, forgot about that.  I'll make the change today.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
