Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBEFJaIi012092
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 10:19:36 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBEFHsq9028231
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 15:17:54 GMT
Subject: Re: [patch] selinux_capget()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <1103035060.30808.40.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
	 <1103035060.30808.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1103037269.30808.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 14 Dec 2004 10:14:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-14 at 09:37, Stephen Smalley wrote:
> An application (with appropriate permissions) could invoke the
> libselinux avc_has_perm() or security_compute_av() interfaces to
> determine what capabilities are allowed by SELinux.  On the downside,
> that requires the application to perform an extra call and to be
> SELinux-aware.

BTW, note that you could always provide a new library function, e.g.
selinux_capget(), that internally does the capget() call and a
security_compute_av() call and combines the results.  Then your
applications can just make that single call.  Or even selectively
override capget() with that function using your own shared object if you
can't modify the applications.  No need for a kernel change.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
