Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBE696Ii009830
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 01:09:06 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBE67OjC008910
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 06:07:24 GMT
Date: Tue, 14 Dec 2004 01:09:02 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [patch] selinux_capget()
In-Reply-To: <20041214004849.25751.qmail@web50201.mail.yahoo.com>
Message-ID: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Dec 2004, Casey Schaufler wrote:

> Briefly, the intent of the POSIX specification
> is that you should not "correct" the effective set
> due to the impact of additional policies or
> conditions.

How does the application determine the real effective set?  
(confusing enough terms ? :-)

Surely it is a reasonable thing to expect to be able to do.  I'm not sure
that your example is valid here as euid==0 doesn't mean anything in
SELinux (if it did, the application could check that first and infer that
it has all capabilities).


- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
