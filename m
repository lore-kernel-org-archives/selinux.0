Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEDOSSf024120
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 08:24:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAEDORqY026968
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 13:24:27 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id hAEDOQ0o026965 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 13:24:26 GMT
Date: Fri, 14 Nov 2003 08:24:07 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: unix_chkpwd
In-Reply-To: <200311141901.14660.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0311140823320.21499-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Nov 2003, Russell Coker wrote:

> We can do one of three things:
> 1)  dontaudit system_chkpwd_t inetd_t:fd use;
> 2)  Change sshd to use fcntl() before doing any PAM stuff.
> 3)  Put code in pam_unix.so to close all file handles after the fork().
> 
> Which do you think is best?  2 seems most correct to me, but may be most 
> difficult to get accepted upstream.

Yes, 2 seems correct to me as well, what objections would they have 
upstream?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
