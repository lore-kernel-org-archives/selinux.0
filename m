Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EFRTWt019148
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 11:27:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9EFRM0p021482
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 15:27:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9EFRMr7021471
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 15:27:22 GMT
Subject: Re: avc_toggle and avc_enforcing
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3F8BE8E5.9050006@ipen.br>
References: <3F8BE8E5.9050006@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1066145242.5054.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 11:27:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-14 at 08:15, Carlos Anísio Monteiro wrote:
> Please, where I find the commands: avc_toggle and avc_enforcing. What
> are it the packages where it are?

They no longer exist as programs.  With the new SELinux API, you can
simply 'cat /selinux/enforce' to see the current enforcing value,
'echo 1 > /selinux/enforce' to switch into enforcing mode, and
'echo 0 > /selinux/enforce' to switch into permissive mode (if permitted
by the policy).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
