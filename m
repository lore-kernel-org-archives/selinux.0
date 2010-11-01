Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA1Fxooc019510
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 11:59:50 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oA1Fxnqf022223
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 15:59:50 GMT
Message-ID: <4CCEE3F5.1040802@tresys.com>
Date: Mon, 01 Nov 2010 11:59:49 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Console Login and SSH Login  Security Contexts...
References: <20100312205537.GA1091@us.ibm.com> <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com> <20100314053521.GA12410@us.ibm.com> <D06FE0A2807BC145B0D38744789D4F5D09C2E5DC@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D09C2E5DC@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/31/10 18:36, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I know there was a huge email thread recently regarding obtaining
> correct security context after SSH-login, but I didn't really get the
> answer I need from that thread. So hoping someone can help me...
[...]
> After the software_upgrade (when the filesystem has already been labeled
> correctly, and after the reboot, I would expect the "login" process and
> the "sshd" process to run under the correct context
> (system_u:system_r:login_exec_t), (system_u:system_r:sshd_exec_t).  But
> I don't  :-(  I see them both running as  system_u:system_r:kernel_t
> !!!  This tells me that the domain transitions during the init sequence
> perhaps didn't go smoothly ?

This is the first problem.  It sounds like your init program (typically
/sbin/init) is not labeled correctly, which means you don't transition
out of kernel_t when init runs, meaning anything that starts up from
init/init scripts will almost certainly have the wrong context.  The
init program should be init_exec_t.  I would expect sshd to have the
sshd_t domain and local login would be local_login_t (getty processes
getty_t).


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
