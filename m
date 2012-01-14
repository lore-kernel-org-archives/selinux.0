Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0EFkwq5021296
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 10:46:58 -0500
Received: from qmta14.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0EFkv0O025313
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 15:46:57 GMT
Message-ID: <4F11A36F.1050001@gentoo.org>
Date: Sat, 14 Jan 2012 10:46:55 -0500
From: Chris PeBenito <pebenito@gentoo.org>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux with initramfs
References: <20120114142001.GA5632@siphos.be> <20120114143421.GB5632@siphos.be>
In-Reply-To: <20120114143421.GB5632@siphos.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/14/2012 9:34 AM, Sven Vermeulen wrote:
> On Sat, Jan 14, 2012 at 03:20:02PM +0100, Sven Vermeulen wrote:
>> An initramfs' /init will run in the kernel_t domain (and unconfined until
>> load_policy is called ?)
>
> Not unconfined, permissive.

It will run in the kernel initial SID ("kernel") until a policy is loaded.  Before the policy is loaded, it isn't permissive per se, as there is nothing to enforce.  SELinux is disabled in the "no policy loaded" sense (as opposed to the kernel command line selinux=0, unregistered SELinux LSM sense).  Once the policy is loaded, all of the labels will be set based on their initial SID; thus, the "kernel"-labeled processes get the kernel initial SID in the policy, kernel_t, and the initial enforcing/permissive state will be set based on the kernel command line enforcing= option, /etc/selinux/config, or kernel compiled-in default.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
