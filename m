Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA27mlsk013186
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 03:48:47 -0400
Received: from snt0-omc4-s17.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oA27mjJm027801
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2010 07:48:46 GMT
Message-ID: <SNT139-w56DA8D85AB1F6881F504D8AB490@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e5a80fce-cbb3-49e4-8e2a-2d93613a3d73_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <chr010@motorola.com>, "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: <sds@epoch.ncsc.mil>, selinux-mailing-list <selinux@tycho.nsa.gov>,
        <xlin1@motorola.com>
Subject: RE: Console Login and SSH Login  Security Contexts...
Date: Tue, 2 Nov 2010 07:48:45 +0000
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D09C2EAFC@de01exm68.ds.mot.com>
References: <20100312205537.GA1091@us.ibm.com>
 <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com>
 <20100314053521.GA12410@us.ibm.com>
 <D06FE0A2807BC145B0D38744789D4F5D09C2E5DC@de01exm68.ds.mot.com>
 <4CCEE3F5.1040802@tresys.com>,<D06FE0A2807BC145B0D38744789D4F5D09C2EAFC@de01exm68.ds.mot.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_e5a80fce-cbb3-49e4-8e2a-2d93613a3d73_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi R. H.

Please see my embedded answers.

> Subject: RE: Console Login and SSH Login  Security Contexts...
> Date: Mon, 1 Nov 2010 17:11:35 -0400
> From: CHR010@motorola.com
> To: cpebenito@tresys.com
> CC: sds@epoch.ncsc.mil; selinux@tycho.nsa.gov; XLIN1@motorola.com
> 
> 
> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com] 
> Sent: Monday, November 01, 2010 11:00 AM
> To: Hasan Rezaul-CHR010
> Cc: Stephen Smalley; SELinux
> Subject: Re: Console Login and SSH Login Security Contexts...
> 
> On 10/31/10 18:36, Hasan Rezaul-CHR010 wrote:
> > Hi All,
> > 
> > I know there was a huge email thread recently regarding obtaining 
> > correct security context after SSH-login, but I didn't really get the 
> > answer I need from that thread. So hoping someone can help me...
> [...]
> > After the software_upgrade (when the filesystem has already been 
> > labeled correctly, and after the reboot, I would expect the "login" 
> > process and the "sshd" process to run under the correct context 
> > (system_u:system_r:login_exec_t), (system_u:system_r:sshd_exec_t).  
> > But I don't  :-(  I see them both running as  
> > system_u:system_r:kernel_t !!!  This tells me that the domain 
> > transitions during the init sequence perhaps didn't go smoothly ?
> 
> This is the first problem.  It sounds like your init program (typically
> /sbin/init) is not labeled correctly, which means you don't transition
> out of kernel_t when init runs, meaning anything that starts up from
> init/init scripts will almost certainly have the wrong context.  The
> init program should be init_exec_t.  I would expect sshd to have the
> sshd_t domain and local login would be local_login_t (getty processes
> getty_t).
> 
> 
> --
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
> 
> 
> Thanks Chris,
> 
> It seems that my  /sbin/init  program  is infact labeled correctly as
> (system_u:object_r:init_exec_t).
> 
> But the sshd and login processes are still running in the  kernel_t
> domain  :-(
> 

If everything is fine, the init program should run in the init_t domain, and its previous domain is kernel_t, which we could observe from /proc/1/attr/*:

root@qemu-host:/root> cat /proc/1/attr/current 
system_u:system_r:init_t:s0-s15:c0.c1023
root@qemu-host:/root> 
root@qemu-host:/root> cat /proc/1/attr/prev    
system_u:system_r:kernel_t:s15:c0.c1023
root@qemu-host:/root> 

If the init on your system remains in the kernel_t, nearly no process on your system would ever run in the correct domain...

> As I mentioned, doing a second reboot, does make everything run as its
> supposed to ?!? 


Well, I am wondering what package your init program comes from, if it is sysvinit, then I guess we would have to enable the WITH_SELINUX compile option, so that the init program could detect if SELinux is ever supported by kernel. If yes, it would try to mount selinuxfs and then load the SELinux policy through /selinux/load and then reload itself to ensure it is running in the correct domain.

I am not sure, but for me now all I can guess is that a second reboot sounds well like the init program would get a chance to reload itself as described above. See if the updated init program has the same behavior as it used to have.

I could be wrong :-P

Hope everything works out for you!

Cheers,
Harry


> Like I said, I cant really afford this extra reboot due
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
> 
> Thanks as always,
> 
> R.H.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_e5a80fce-cbb3-49e4-8e2a-2d93613a3d73_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Hi R. H.<br><br>Please see my embedded answers.<br><br>&gt; Subject: RE: Console Login and SSH Login  Security Contexts...<br>&gt; Date: Mon, 1 Nov 2010 17:11:35 -0400<br>&gt; From: CHR010@motorola.com<br>&gt; To: cpebenito@tresys.com<br>&gt; CC: sds@epoch.ncsc.mil; selinux@tycho.nsa.gov; XLIN1@motorola.com<br>&gt; <br>&gt; <br>&gt; -----Original Message-----<br>&gt; From: Christopher J. PeBenito [mailto:cpebenito@tresys.com] <br>&gt; Sent: Monday, November 01, 2010 11:00 AM<br>&gt; To: Hasan Rezaul-CHR010<br>&gt; Cc: Stephen Smalley; SELinux<br>&gt; Subject: Re: Console Login and SSH Login Security Contexts...<br>&gt; <br>&gt; On 10/31/10 18:36, Hasan Rezaul-CHR010 wrote:<br>&gt; &gt; Hi All,<br>&gt; &gt; <br>&gt; &gt; I know there was a huge email thread recently regarding obtaining <br>&gt; &gt; correct security context after SSH-login, but I didn't really get the <br>&gt; &gt; answer I need from that thread. So hoping someone can help me...<br>&gt; [...]<br>&gt; &gt; Aft!
 er the software_upgrade (when the filesystem has already been <br>&gt; &gt; labeled correctly, and after the reboot, I would expect the "login" <br>&gt; &gt; process and the "sshd" process to run under the correct context <br>&gt; &gt; (system_u:system_r:login_exec_t), (system_u:system_r:sshd_exec_t).  <br>&gt; &gt; But I don't  :-(  I see them both running as  <br>&gt; &gt; system_u:system_r:kernel_t !!!  This tells me that the domain <br>&gt; &gt; transitions during the init sequence perhaps didn't go smoothly ?<br>&gt; <br>&gt; This is the first problem.  It sounds like your init program (typically<br>&gt; /sbin/init) is not labeled correctly, which means you don't transition<br>&gt; out of kernel_t when init runs, meaning anything that starts up from<br>&gt; init/init scripts will almost certainly have the wrong context.  The<br>&gt; init program should be init_exec_t.  I would expect sshd to have the<br>&gt; sshd_t domain and local login would be local_login_t (getty p!
 rocesses<br>&gt; getty_t).<br>&gt; <br>&gt; <br>&gt; --<br>&gt; Chris 
PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br>&gt; <br>&gt; <br>&gt; Thanks Chris,<br>&gt; <br>&gt; It seems that my  /sbin/init  program  is infact labeled correctly as<br>&gt; (system_u:object_r:init_exec_t).<br>&gt; <br>&gt; But the sshd and login processes are still running in the  kernel_t<br>&gt; domain  :-(<br>&gt; <br><br>If everything is fine, the init program should run in the init_t domain, and its previous domain is kernel_t, which we could observe from /proc/1/attr/*:<br><br>root@qemu-host:/root&gt; cat /proc/1/attr/current <br>system_u:system_r:init_t:s0-s15:c0.c1023<br>root@qemu-host:/root&gt; <br>root@qemu-host:/root&gt; cat /proc/1/attr/prev&nbsp;&nbsp;&nbsp; <br>system_u:system_r:kernel_t:s15:c0.c1023<br>root@qemu-host:/root&gt; <br><br>If the init on your system remains in the kernel_t, nearly no process on your system would ever run in the correct domain...<br><br>&gt; As I mentioned, doing a second reboot, does make e!
 verything run as its<br>&gt; supposed to ?!? <br><br><br>Well, I am wondering what package your init program comes from, if it is sysvinit, then I guess we would have to enable the WITH_SELINUX compile option, so that the init program could detect if SELinux is ever supported by kernel. If yes, it would try to mount selinuxfs and then load the SELinux policy through /selinux/load and then reload itself to ensure it is running in the correct domain.<br><br>I am not sure, but for me now all I can guess is that a second reboot sounds well like the init program would get a chance to reload itself as described above. See if the updated init program has the same behavior as it used to have.<br><br>I could be wrong :-P<br><br>Hope everything works out for you!<br><br>Cheers,<br>Harry<br><br><br>&gt; Like I said, I cant really afford this extra reboot due<br>&gt; to timing constraints.<br>&gt; - Is there anything I can do via script to set things right ?<br>&gt; - Can I force the d!
 omain of the sshd and login processes to change to<br>&gt; sshd_t and 
local_login_t.<br>&gt; - I am guessing there are other init processes that are also running in<br>&gt; the wrong domain! Is there anything I can do to fix all such processes<br>&gt; in one shot without requiring a reboot ?<br>&gt; <br>&gt; Also, in my previous software releases (where we had older Linux 2.6.21,<br>&gt; and older selinux packages with Fedora base policy), we never had this<br>&gt; problem.<br>&gt; But in my new software release (with Linux 2.6.27, and with refpolicy as<br>&gt; a starting base), we are seeing this weird problem.<br>&gt; <br>&gt; Any other suggestions ? Anything else we can do to ensure that the<br>&gt; domain transitions happen properly after the first reboot ?<br>&gt; What about using the "run_init" command ? Is that advisable ?  What<br>&gt; other init processes should we check to verify their running domain ?<br>&gt; <br>&gt; Thanks as always,<br>&gt; <br>&gt; R.H.<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscri!
 bers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_e5a80fce-cbb3-49e4-8e2a-2d93613a3d73_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
