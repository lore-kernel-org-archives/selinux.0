Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OEvMRb023429
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 09:57:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OEtmlK020144
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 14:55:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1OEtlOX020141
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 14:55:47 GMT
Subject: Re: identity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1077634629.21221.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 09:57:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-24 at 09:47, James Morris wrote:
> On Mon, 23 Feb 2004, Russell Coker wrote:
> 
> > The idea is to have something like rjc#10.0.0.1:user_r:user_t to indicate that 
> > I logged in from IP address 10.0.0.1.
> 
> How would the kernel know the IP address you're logged in from?  Would you 
> also want to log the serial device if that's how the user logged in?

I tend to view this discussion as more appropriate for an auditing
framework rather than SELinux.  Likewise for preserving the original
user identity across all operations; that is typically an auditing
requirement rather than an access control requirement.  So I'd suggest
taking this up with people who are working on auditing frameworks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
