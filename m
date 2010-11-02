Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA2Db2aX006037
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 09:37:02 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oA2Db176028434
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 13:37:01 GMT
Message-ID: <4CD013EC.60804@tresys.com>
Date: Tue, 02 Nov 2010 09:36:44 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
        Lin Xuejun-XLIN1 <XLIN1@motorola.com>
Subject: Re: Console Login and SSH Login  Security Contexts...
References: <20100312205537.GA1091@us.ibm.com> <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com> <20100314053521.GA12410@us.ibm.com> <D06FE0A2807BC145B0D38744789D4F5D09C2E5DC@de01exm68.ds.mot.com> <4CCEE3F5.1040802@tresys.com> <D06FE0A2807BC145B0D38744789D4F5D09C2EAFC@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D09C2EAFC@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/01/10 17:11, Hasan Rezaul-CHR010 wrote:
> 
> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com] 
> Sent: Monday, November 01, 2010 11:00 AM
> To: Hasan Rezaul-CHR010
> Cc: Stephen Smalley; SELinux
> Subject: Re: Console Login and SSH Login Security Contexts...
> 
> On 10/31/10 18:36, Hasan Rezaul-CHR010 wrote:
>> Hi All,
>>
>> I know there was a huge email thread recently regarding obtaining 
>> correct security context after SSH-login, but I didn't really get the 
>> answer I need from that thread. So hoping someone can help me...
> [...]
>> After the software_upgrade (when the filesystem has already been 
>> labeled correctly, and after the reboot, I would expect the "login" 
>> process and the "sshd" process to run under the correct context 
>> (system_u:system_r:login_exec_t), (system_u:system_r:sshd_exec_t).  
>> But I don't  :-(  I see them both running as  
>> system_u:system_r:kernel_t !!!  This tells me that the domain 
>> transitions during the init sequence perhaps didn't go smoothly ?
> 
> This is the first problem.  It sounds like your init program (typically
> /sbin/init) is not labeled correctly, which means you don't transition
> out of kernel_t when init runs, meaning anything that starts up from
> init/init scripts will almost certainly have the wrong context.  The
> init program should be init_exec_t.  I would expect sshd to have the
> sshd_t domain and local login would be local_login_t (getty processes
> getty_t).
> 

> Thanks Chris,
> 
> It seems that my  /sbin/init  program  is infact labeled correctly as
> (system_u:object_r:init_exec_t).
> 
> But the sshd and login processes are still running in the  kernel_t
> domain  :-(
> 
> As I mentioned, doing a second reboot, does make everything run as its
> supposed to ?!? Like I said, I cant really afford this extra reboot due
> to timing constraints.
> - Is there anything I can do via script to set things right ?
> - Can I force the domain of the sshd and login processes to change to
> sshd_t and local_login_t.
> - I am guessing there are other init processes that are also running in
> the wrong domain! Is there anything I can do to fix all such processes
> in one shot without requiring a reboot ?
> 
> Also, in my previous software releases (where we had older Linux 2.6.21,
> and older selinux packages with Fedora base policy), we never had this
> problem.
> But in my new software release (with Linux 2.6.27, and with refpolicy as
> a starting base), we are seeing this weird problem.
> 
> Any other suggestions ? Anything else we can do to ensure that the
> domain transitions happen properly after the first reboot ?
> What about using the "run_init" command ? Is that advisable ?  What
> other init processes should we check to verify their running domain ?

Is there a .autorelabel or something similar happening during the first
boot?  If the upgrade is not writing files with the correct label, then
the first boot would not have correct transitions, but the second would
have the right transitions because the labels on disk were fixed by the
autorelabel.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
