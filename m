Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KsTXZ000245
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:54:30 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1Kr9CC005268
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:53:09 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, samba-technical@samba.org,
   tng-technical@samba-tng.org
In-Reply-To: <20041101210038.GL9643@lkcl.net>
References: <418662EE.5090001@trustedcs.com>
	 <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com>
	 <20041101203524.GJ9643@lkcl.net>
	 <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101210038.GL9643@lkcl.net>
Content-Type: text/plain
Message-Id: <1099342233.21386.233.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 15:50:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 16:00, Luke Kenneth Casson Leighton wrote:
> > Except that SELinux mediates access to file descriptors upon transfer
> > via local socket IPC as well as attempted use for read/write, so SELinux
> > is still going to apply a permission check to the parent smbd process in
> > that situation.  
> 
>  that i would expect.

So you are ok with allowing smbd_t the union of all smbd_$1_t
permissions?

> > Not to mention that this no doubt has a significant
> > cost.
> 
>  that i was not expecting.

Not the cost of the mediation, the cost of fork+exec'ing these children
for each client.  Isn't that likely to add significant overhead?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
