Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hACLRTSf015672
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 16:27:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hACLR3Bb001833
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 21:27:03 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hACLR24o001830
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 21:27:03 GMT
Date: Wed, 12 Nov 2003 21:27:15 +0000
From: Dale Amon <amon@vnl.com>
To: Carlos Anisio Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: AVC messages
Message-ID: <20031112212715.GF23277@vnl.com>
References: <3FB260CC.4020801@ipen.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB260CC.4020801@ipen.br>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 12, 2003 at 02:33:16PM -0200, Carlos Anisio Monteiro wrote:
> a)  I'd like to know in  what manner I can write the "avc messages" to a 
> specific log file to SELinux, for instance, *selinux.log* file, and not 
> in the messages log file.
> 
> b) How I do to that "avc messages" not are displayed in the console only 
> in the selinux.log file ?

You might want to look into syslog-ng. It will let you send things
to log files based on filters.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
