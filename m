Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16646
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 15:24:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA10792
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 20:24:41 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzband.ncsc.mil  with ESMTP id UAA10788
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 20:24:39 GMT
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA14356
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 12:23:22 -0800 (PST)
	mail_from (florin@sgi.com)
Received: from crom.corp.sgi.com (crom.corp.sgi.com [130.62.63.32])
	by nodin.corp.sgi.com (8.11.2/8.11.2/nodin-1.0) with ESMTP id f2KKOW14111094
	for <@fddi-odin.corp.sgi.com:selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 12:24:32 -0800 (PST)
Received: from stantz.corp.sgi.com (stantz.corp.sgi.com [130.62.175.86]) by crom.corp.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA60688 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 12:28:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by stantz.corp.sgi.com (Postfix) with ESMTP id CEE7E14E62D
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 12:24:04 -0800 (PST)
Subject: Re: SELinux compatible with XFS?
From: Florin Andrei <florin@sgi.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <200103191645.LAA08103@coalstove.epoch.ncsc.mil>
Content-Type: text/plain
Date: 20 Mar 2001 12:24:04 -0800
Mime-Version: 1.0
Message-Id: <20010320202404.CEE7E14E62D@stantz.corp.sgi.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 19 Mar 2001 11:45:23 -0500, Howard Holm wrote:
> 
> While I'm not completely familiar with XFS, my understanding is that
> one of its advantages is that it stores extended attributes with the
> files.  So, it should, hopefully, be relatively easy to add a PSID to the
> extended file attributes.  That said, it isn't one of NSA's priorities
> to add that support.  If someone else wants it enough to do the work,
> we'd certainly like to see the results made available.

So, i suppose the same is true for SELinux and ReiserFS, right?

It would be nice to have journaling FS with SELinux... ;-)

-- 
Florin Andrei


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
