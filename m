Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA17002
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 12:53:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0NHrqI12824
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 17:53:52 GMT
Received: from hellcat.admin.navo.hpc.mil (hellcat.admin.navo.hpc.mil [204.222.179.34])
        by jazzband.ncsc.mil  with ESMTP id h0NHrpf12820 for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 17:53:51 GMT
Content-Type: text/plain;
  charset="windows-1252"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Rashmi Agrawal" <rashmi.agrawal@wipro.com>, <selinux@tycho.nsa.gov>
Subject: Re: Information required
Date: Thu, 23 Jan 2003 11:53:17 -0600
Cc: "Rashmi Agrawal" <rashmi.agrawal@wipro.com>
References: <52C85426D39B314381D76DDD480EEE0C66D189@blr-m3-msg.wipro.com>
In-Reply-To: <52C85426D39B314381D76DDD480EEE0C66D189@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Message-Id: <200301231153.17608.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 23 January 2003 08:06 am, Rashmi Agrawal wrote:
> Hi All,
>
> I am developing a software which require very high performance for data
> store/retrieval. Taking that into consideration, I decided to go for kernel
> space system calls for read/write, open/close etc.

most likely a real time application? However, there are no system calls
within the kernel. Only between user mode and kernel mode.

> I directly calls the file operation from within the kernel. Since kernel
> has access to all system resources and low level hardware, could somebody
> point out if it is secure enough to read/write in kernel space.

No.

> If it is not advisable directly to use system calls in kernel, can we do
> something to make it secure?? or do we already have something which
> provides us security even if I do kernel space system call implementation.

Can't be done. You already acknowleged that the kernel has access to all 
system resources and low level hardware, you should realize that any 
protection put in place is already bypassed by the application.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
