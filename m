Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EGAJWt019460
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:10:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EGAImR014080
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 16:10:18 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h9EGAIjp014077 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 16:10:18 GMT
Date: Tue, 14 Oct 2003 17:10:13 +0100
From: Dale Amon <amon@vnl.com>
To: Carlos An?sio Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
Subject: Re: avc_toggle and avc_enforcing
Message-ID: <20031014161013.GM6726@vnl.com>
References: <3F8BE8E5.9050006@ipen.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F8BE8E5.9050006@ipen.br>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 14, 2003 at 10:15:33AM -0200, Carlos An?sio Monteiro wrote:
> Please, where I find the commands: *avc_toggle* and *avc_enforcing*. 
> What are it the packages where it are?

Gone. You just echo 1 or 0 to /selinux/enforcing (I think that is
the right name, I haven't got my testbox onlne at the moment) to
set or clear it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
