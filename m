Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RF4KWt025351
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 10:04:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9RF4IIE011511
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 15:04:18 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h9RF4I1J011508 for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 15:04:18 GMT
Message-ID: <3F9D33EC.8060705@redhat.com>
Date: Mon, 27 Oct 2003 10:04:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
CC: selinux@tycho.nsa.gov
Subject: Re: question about pam_selinux multiple option
References: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:

>When I saw the man page of pam_selinux, 
>there is a option "multiple". I think it is convenient.
>However, in pam-selinux.patch, the code about "multiple" is commented out,like this.
>+    /*    if (strcmp(argv[i], "multiple") == 0) {
>+      multiple = 1;
>+      }*/
>When I enabled it, the "multiple" option seemed to work.
>Why is it commented out ? 
>Will "multiple" option be enabled in the future?
>
>Thank you.
>
>---------
>Yuichi Nakamura
>  
>

The multiple option was added to allow the user to select the security 
context they would be allowed to login in as.  We have decided to pull 
this functionality from login programs and only allow the user to login 
with the default context.  Afterwards they can change their context 
using newrole.  I will fix the man page.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
