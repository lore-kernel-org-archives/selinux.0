Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p158WwHY030747
	for <selinux@tycho.nsa.gov>; Sat, 5 Feb 2011 03:32:58 -0500
Received: from mail.eurojobs.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p158WvSW021564
	for <selinux@tycho.nsa.gov>; Sat, 5 Feb 2011 08:32:57 GMT
Received: from localhost (IS-5354 [127.0.0.1])
	by mail.eurojobs.com (Postfix) with ESMTP id 486D7110024
	for <selinux@tycho.nsa.gov>; Sat,  5 Feb 2011 08:32:56 +0000 (GMT)
Received: from mail.eurojobs.com ([127.0.0.1])
	by localhost (mail.eurojobs.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsfhHRXGxUNB for <selinux@tycho.nsa.gov>;
	Sat,  5 Feb 2011 08:32:55 +0000 (GMT)
Received: from [192.168.1.14] (host179-1-dynamic.50-79-r.retail.telecomitalia.it [79.50.1.179])
	by mail.eurojobs.com (Postfix) with ESMTPSA id 10062110023
	for <selinux@tycho.nsa.gov>; Sat,  5 Feb 2011 08:32:54 +0000 (GMT)
Message-ID: <4D4D0B63.8070509@mintsource.org>
Date: Sat, 05 Feb 2011 09:33:39 +0100
From: Simon Peter Nicholls <simon@mintsource.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Trouble logging in through SSH
References: <4D4C8A4C.1070101@mintsource.org>
In-Reply-To: <4D4C8A4C.1070101@mintsource.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/02/11 00:22, Simon Peter Nicholls wrote:
> Hi All,
>
> I'm having some trouble setting up SELinux using refpolicy, and am 
> unable to login my test user through ssh when in enforcing mode. Could 
> someone help me work out where the problem lies? I have some basic 
> experience with SELinux, but based on working Fedora systems that have 
> gone slightly awry.
>
> Similar denial messages to the ssh one are seen when trying to run 
> software like Emacs in permissive mode. In each case it feels like I 
> am restricted by the consoletype_t, whilst I was expecting to gain an 
> unconfined_t type for my user (to match unconfined_u & unconfined_r).
>
> I also expected to see the sshd_t type for the sshd process, but it is 
> using init_t. Are transitions failing for my startup services?

Typical. The act of writing this gave substance to my suspicions. I 
checked the type for the the SSH init script and it was incorrectly set 
to etc_t, the underlying reason being that Arch Linux uses the 
non-standard /etc/rc.d directory for it's startup scripts.

As a quick test to confirm, I used chcon to set the sshd script to 
initrc_exec_t, rebooted, and I find I can login under enforcing mode. 
The sshd process now has the sshd_t type, and my user also has the 
unconfined_u:unconfined_r:unconfined_t context, as I previously 
expected. The subsequent running of programs like Emacs are now no problem.

I have some log related denials however, which I'll look into. Any 
pointers would be appreciated.

Feb  5 09:13:41 mailer kernel: type=1400 audit(1296893621.240:3): avc:  
denied \
  { write } for  pid=945 comm="sshd" name="log" dev=devtmpfs ino=4929 
scontext=s\
ystem_u:system_r:sshd_t tcontext=system_u:object_r:device_t 
tclass=sock_file
Feb  5 09:13:41 mailer kernel: type=1400 audit(1296893621.240:4): avc:  
denied \
  { connectto } for  pid=945 comm="sshd" path="/dev/log" 
scontext=system_u:syste\
m_r:sshd_t tcontext=system_u:system_r:init_t tclass=unix_stream_socket


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
