Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQDkRRb019338
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 08:46:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAQDkQqY003135
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:46:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAQDkQ0o003132 for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:46:26 GMT
Subject: Re: genfs_contexts file
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>,
   Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FC4ADD3.9040505@redhat.com>
References: <3FC3CE10.8020307@ipen.br>
	 <200311261135.09128.russell@coker.com.au>  <3FC4ADD3.9040505@redhat.com>
Content-Type: text/plain
Message-Id: <1069854373.30315.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 08:46:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-26 at 08:42, Daniel J Walsh wrote:
> Is there a way to change libselinux to return this data, ie if
> getfilecon is going to return NULL, then have it return the genfscon
> value?

libselinux is the wrong place.  If userspace needs access to the labels,
then the filesystem needs to export an xattr handler.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
