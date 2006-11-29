Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAT8NIAD005488
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 03:23:19 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAT8LXE0025485
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 08:21:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Yuichi Nakamura <ynakam@gwu.edu>
Subject: Re: First argument of matchpathcon_filespec_add
Date: Wed, 29 Nov 2006 19:23:28 +1100
Cc: selinux@tycho.nsa.gov, kaigai@kaigai.gr.jp
References: <ddeda73453a4.456d4b0b@gwu.edu>
In-Reply-To: <ddeda73453a4.456d4b0b@gwu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611291923.30237.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 29 November 2006 10:55, Yuichi Nakamura <ynakam@gwu.edu> wrote:
> When we do not want to build busybox with -D_FILE_OFFSET_BIT=64,
> we have to rebuild libselinux.
>
> I think it is a problem.
>
> Does anyone have good idea ?

What harm does it do to build busybox with 64bit file offsets?  For system 
recovery I think that 64bit offsets are desirable.

For embedded systems I guess you could have both the same whichever option you 
choose.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
