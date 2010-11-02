Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA2ID1Ms029410
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 14:13:01 -0400
Received: from mail119.messagelabs.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oA2ID0c7019823
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 18:13:00 GMT
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id oA2ICwdu029294
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 11:12:58 -0700 (MST)
Received: from il06vts01.mot.com (il06vts01.mot.com [129.188.137.141])
	by il06exr03.mot.com (8.13.1/Vontu) with SMTP id oA2ICwFg029717
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 13:12:58 -0500 (CDT)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id oA2ICvS3029713
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 13:12:57 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Console Login and SSH Login  Security Contexts...
Date: Tue, 2 Nov 2010 14:12:35 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D09C2EF85@de01exm68.ds.mot.com>
In-Reply-To: <4CD013EC.60804@tresys.com>
References: <20100312205537.GA1091@us.ibm.com> <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com> <20100314053521.GA12410@us.ibm.com> <D06FE0A2807BC145B0D38744789D4F5D09C2E5DC@de01exm68.ds.mot.com> <4CCEE3F5.1040802@tresys.com> <D06FE0A2807BC145B0D38744789D4F5D09C2EAFC@de01exm68.ds.mot.com> <4CD013EC.60804@tresys.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>, "SELinux" <selinux@tycho.nsa.gov>,
        "Lin Xuejun-XLIN1" <XLIN1@motorola.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 

-----Original Message-----
From: Christopher J. PeBenito [mailto:cpebenito@tresys.com] 
Sent: Tuesday, November 02, 2010 8:37 AM
To: Hasan Rezaul-CHR010
Cc: Stephen Smalley; SELinux; Lin Xuejun-XLIN1
Subject: Re: Console Login and SSH Login Security Contexts...

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
> This is the first problem.  It sounds like your init program 
> (typically
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

> supposed to ?!? Like I said, I cant really afford this extra reboot 
> due to timing constraints.
> - Is there anything I can do via script to set things right ?
> - Can I force the domain of the sshd and login processes to change to 
> sshd_t and local_login_t.
> - I am guessing there are other init processes that are also running 
> in the wrong domain! Is there anything I can do to fix all such 
> processes in one shot without requiring a reboot ?
> 
> Also, in my previous software releases (where we had older Linux 
> 2.6.21, and older selinux packages with Fedora base policy), we never 
> had this problem.
> But in my new software release (with Linux 2.6.27, and with refpolicy 
> as a starting base), we are seeing this weird problem.
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



Thanks Again Chris,

There is no  .autorelabel being used, (because I didn't want an
additional reboot after the autorelabel). What I did was, after the
/inactive  side was populated with software, and the selinux policies
were in place, I used the  "setfiles" command to label the  /inactive
side. The exact command I used is:

  /sbin/setfiles -r /inactive
/inactive/etc/selinux/strict/contexts/files/file_contexts /inactive

After this I expect the  /inactive  side to be labeled appropriately.

After this command, I then do a reboot (which makes the /inactive side
the new "/" side), and I expect all the services and processes to start
up in the correct context... 

This procedure used to work fine in my older software releases. In the
newer software release, not sure why its not working as before. In the
new software release, when I do an additional 2nd reboot, then only
things start up correctly  :-( 

This is why I am wondering if there are any commands I can run after the
1st reboot, that will correct any context problems ? 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
