Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA08149
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 13:42:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA15267
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 17:41:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA15263
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 17:41:04 GMT
Date: Tue, 13 Aug 2002 13:34:24 -0400 (EDT)
From: Wayne Salamon <wsalamon@tislabs.com>
To: "M. H." <metalhead00@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: socket_secure fails with "Function not implemented"
In-Reply-To: <F2658oBC9xfDYBWjLb400005049@hotmail.com>
Message-ID: <Pine.LNX.4.33.0208131332130.3606-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Aug 2002, M. H. wrote:
>
> I was trying to write a little test program using socket_secure(), however
> it never succeeds and sets errno to "Function not implemented."

  Did you enable the 'NSA SELinux extended socket calls (EXPERIMENTAL)'
option when you configured the kernel.  This option is under the
'NSA SELinux Support' option in the Security options panel.

By default, extended socket calls are not built as they are considered
experimental.


-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
