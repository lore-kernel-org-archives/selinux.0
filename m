Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15433
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 13:51:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA15932
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 17:50:50 GMT
Received: from hotmail.com (f92.law14.hotmail.com [64.4.21.92])
	by jazzswing.ncsc.mil  with ESMTP id RAA15928
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 17:50:50 GMT
From: "M. H." <metalhead00@hotmail.com>
To: wsalamon@tislabs.com
Cc: selinux@tycho.nsa.gov
Subject: Re: socket_secure fails with "Function not implemented"
Date: Wed, 14 Aug 2002 10:50:49 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F92VHt8fddAkOhw2RlC000009e1@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the status of the secure socket calls? What issues remain unresolved 
(I am most interested in finding out the sid of a UNIX domain socket peer.)

Thanks.



>From: Wayne Salamon <wsalamon@tislabs.com>
>To: "M. H." <metalhead00@hotmail.com>
>CC: <selinux@tycho.nsa.gov>
>Subject: Re: socket_secure fails with "Function not implemented"
>Date: Tue, 13 Aug 2002 13:34:24 -0400 (EDT)
>
>On Tue, 13 Aug 2002, M. H. wrote:
> >
> > I was trying to write a little test program using socket_secure(), 
>however
> > it never succeeds and sets errno to "Function not implemented."
>
>   Did you enable the 'NSA SELinux extended socket calls (EXPERIMENTAL)'
>option when you configured the kernel.  This option is under the
>'NSA SELinux Support' option in the Security options panel.
>
>By default, extended socket calls are not built as they are considered
>experimental.
>
>
>--
>Wayne Salamon
>wsalamon@tislabs.com




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
