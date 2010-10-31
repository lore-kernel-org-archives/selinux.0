Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA1BErCr011131
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 07:15:02 -0400
Received: from mail119.messagelabs.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9VMb1HY002392
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2010 22:37:01 GMT
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id o9VMb0M0012541
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2010 15:37:00 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id o9VMaxYD006111
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2010 17:36:59 -0500 (CDT)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id o9VMaxEN006097
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2010 17:36:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Console Login and SSH Login  Security Contexts...
Date: Sun, 31 Oct 2010 18:36:37 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D09C2E5DC@de01exm68.ds.mot.com>
In-Reply-To: <20100314053521.GA12410@us.ibm.com>
References: <20100312205537.GA1091@us.ibm.com> <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com> <20100314053521.GA12410@us.ibm.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "SELinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I know there was a huge email thread recently regarding obtaining
correct security context after SSH-login, but I didn't really get the
answer I need from that thread. So hoping someone can help me...

I work on a 2.6.27 Linux system, where there are two partitions. A "/"
partition where all the active software runs, and an "/inactive"
partition where we download new software. 

During a software upgrade procedure, we populate the "/inactive"
partition with new software. 
We also have selinux policies loaded up on the /inactive side (so
/inactive/etc/selinux/strict/*), 
and I use the "setfiles" command to label the entire /inactive partition
correctly. 
and then we do a reboot and flip the partitions, so that the previous
/inactive side now becomes the "/" side, and the new software runs.


My SELinux user and login configuration is as below:


root@hapWibbSc2:~# semanage user -l  
                Labeling   MLS/       MLS/                          
SELinux User    Prefix     MCS Level  MCS Range
SELinux Roles

root            sysadm     s0         s0-s15:c0.c255
staff_r sysadm_r
staff_u         staff      s0         s0-s15:c0.c255
staff_r sysadm_r
sysadm_u        sysadm     s0         s0-s15:c0.c255
sysadm_r
system_u        user       s0         s0-s15:c0.c255
system_r
unconfined_u    unconfined s0         s0-s15:c0.c255
unconfined_r
user_u          user       s0         s0
user_r



root@hapWibbSc2:~# semanage login -l                           
Login Name      SELinux User		  MLS/MCS Range

root            root                  s0-s15:c0.c255                 
admin           staff_u               s0                          
system_u        system_u              s0-s15:c0.c255    
__default__     user_u                s0             
                   

What I would like to see is:

when Linux User = 'root' logs into the console or through SSH, I would
like to see context = root:sysadm_r:sysadm_t
when Linux User = 'admin' logs into the console or through SSH, I would
like to see context = staff_u:staff_r:staff_t
when Linux User = 'Test' logs into the console or through SSH, I would
like to see context = user_u:user_r:user_t


After the software_upgrade (when the filesystem has already been labeled
correctly, and after the reboot, I would expect the "login" process and
the "sshd" process to run under the correct context
(system_u:system_r:login_exec_t), (system_u:system_r:sshd_exec_t).  But
I don't  :-(  I see them both running as  system_u:system_r:kernel_t
!!!  This tells me that the domain transitions during the init sequence
perhaps didn't go smoothly ?

And as a result, when each of the users login to the console or through
SSH, they get a wrong security context like staff_u:staff_r:insmod_t
!!!

Note: If the Linux machine is reboot ONE MORE TIME, then the 'login' and
'sshd' processes run in the correct context, and from that point on,
each user does get the security context as desired !  But in my
production system, I cant afford to have a second reboot due to timing
contraints  :-(  And I honestly don't understand why another reboot
would be necessary, considering the filesystem was already labeled and
the node was already reboot once... Why the need for this extra reboot
to set things right ? Besides, this additional reboot is NOT relabeling
anything, which means the labelling during the previous bootup was
fine...


QUESTIONS
==========

1. Any pointers as to what may be happenning ? Why processes are running
in wrong context after the first reboot ?
2. What does an additional (2nd) reboot do, that gets the processes
running in the correct context ?
3. Is there something I can do (other than 2nd reboot)  perhaps through
a script that would allow the 'login' and 'sshd' processes to restart in
the correct context ? Perhaps the "run_init" command ??
4. Anyway I can force the domain transitions to occur correctly ?
5. What is a typical sequence of domain transitions anyway during a
typical Linux bootup ?


The strange thing is, the software upgrade procedure (as described
above) and login context setting used to work just fine in conjunction
with my selinux policies, and users would obtain the correct security
contexts after loggin in... And this used to work just fine in the
previous software release after just the first reboot. But in our new
software release, this behaviour seems to have changed  :-(  But there
was no real change to selinux policies, so trying to understand what
happened??  Any pointers would be greatly appreciated. Thank You  :-)


R.H.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
