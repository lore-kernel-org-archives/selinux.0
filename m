Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4RDi5jt010825
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 09:44:05 -0400
Message-ID: <538496E6.2080707@tresys.com>
Date: Tue, 27 May 2014 09:45:10 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: <kim.lawson-jenkins@nrl.navy.mil>, <selinux@tycho.nsa.gov>
Subject: Re: AVCs errors generated when CLI comands executed
References: <001c01cf79a6$3ba6e880$b2f4b980$@nrl.navy.mil>
In-Reply-To: <001c01cf79a6$3ba6e880$b2f4b980$@nrl.navy.mil>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/2014 08:21 AM, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> We’re running SELinux on an embedded system using a reference policy from the Yocto project.   RAM, which is used instead of flash, is mounted after SELinux relabeling completes and the files have default labels after a reboot.  I’ve added restorecon -R /dev to a rc.init  to set the contexts correctly but the files on RAM still have the default label.  After logging in, I’m able to execute SELinux commands to modify the policy and fix the labels, but avcs are generated for every command.  Here are some examples –
> 
>  
> 
> May 20 20:04:16 guard kernel: type=1400 audit(1400616256.808:53): avc:  denied  { relabelto } for  pid=1536 comm="restorecon" name="sipc_mq1 " dev="ram1" ino=14341 scontext=root:sysadm_r:setfiles_t:s0-s15:c0.c1023 tcontext=system_u:object_r:ioi_orch_cq_t:s0 tclass=file
> 
> May 20 20:04:16 guard kernel: type=1400 audit(1400616256.839:54): avc:  denied  { associate } for  pid=1536 comm="restorecon" name="sipc_mq2 " dev="ram1" ino=14341 scontext=system_u:object_r:ioi_orch_cq_t:s0 tcontext=system_u:object_r:fs_t:s0 tclass=filesystem
> 
> May 20 20:04:16 guard kernel: type=1400 audit(1400616256.864:55): avc:  denied  { relabelto } for  pid=1536 comm="restorecon" name="sipc_mq3 " dev="ram1" ino=14342 scontext=root:sysadm_r:setfiles_t:s0-s15:c0.c1023 tcontext=system_u:object_r:orch_ioi_cq_t:s0 tclass=file
> 
> May 20 20:04:16 guard kernel: type=1400 audit(1400616256.888:56): avc:  denied  { associate } for  pid=1536 comm="restorecon" name="sipc_mq4" dev="ram1" ino=14342 scontext=system_u:object_r:orch_ioi_cq_t:s0 tcontext=system_u:object_r:fs_t:s0 tclass=filesystem
> 
> May 20 20:04:16 guard kernel: type=1400 audit(1400616256.907:57): avc:  denied  { relabelto } for  pid=1536 comm="restorecon" name="sipc_mq5" dev="ram1" ino=14343 scontext=root:sysadm_r:setfiles_t:s0-s15:c0.c1023 tcontext=system_u:object_r:ioi_orch_dq_t:s0 tclass=file
> 
>  
> 
> I don’t understand why the restorecon does not apply the correct labels when the init script is executed but it does when I execute the command as admin.  Also, I don’t know why the AVC errors are generated when I execute the commands as admin.  Any feedback would be greatly appreciated.

It doesn't look like the ioi_orch_dq_t is marked as a files_type().  Because of the filesystem associate denial, it doesn't seem like it should work in any case.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
