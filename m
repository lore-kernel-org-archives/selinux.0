Date: Thu, 22 Dec 2005 15:38:27 -0500
Message-Id: <200512221538.AA402391350@maxinter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
From: "abreeves" <abreeves@maxinter.net>
Reply-To: <abreeves@maxinter.net>
To: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>,
   Lorenzo Hern=?ISO-8859-1?Q?=E1ndez__Garc=ED?=a-Hierro <lorenzo@gnu.org>
CC: <abreeves@maxinter.net>
Subject: Re: [RFC] SELinux file_ioctl hook permission checks changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Alles,
     I am a bit new to these selinux links since having just joined a few months ago.  So I am just getting my feet wet.  However, with that said, I have often wondered if we in teh Linux/Unix community have not been going about all of this security protection business all wrong and that just maybe we have not investigated the full history of distinguished op. systems of the past as to what they could tell us.
One operating system (somewhat little known because it was only offered on the DEC 10/20 line of 36-bit computers) was called the TOPS-20 operating system.  This system went Unix/Linux one better on the system,  group, file protection system structure in that it had four levels of protection instead of the 3 like we have in Linux/Unix.  The four levels were wheel, system, group, file, with read, write, execute, delete as the three flags setable for control of protection at the detail level. I wonder if any of you gurus had ever tho't about this or wondered if we could not improve upon the whole Linux (whatever) kernel design by having four such levels to the security infrastructure of the system rather than the present limited three levels.  I can go into much more discussion of this, however, it would do no good if some of us are not aware of this history and the potential improvement it could offer even tho' at this juncture such a scheme might be too much for the community to tolerate.   Think about it.
Allen B. Reeves, former NSAer.
"The diffusion of knowledge is the only guardian of true liberty." James Madison, 1825.
--------- Original Message ----------------------------------
From: Lorenzo Hern�ndez  Garc�a-Hierro <lorenzo@gnu.org>
Date:  Wed, 21 Dec 2005 19:43:15 +0100

>We've been considering the implementation of certain changes to the permission checks applied
>to ioctl(2) calls via the selinux_file_ioctl hook.
>
>The objective is to remove hard coded ioctl commands inside the mentioned hook and use
>"generalized" checks instead.
>
>Previous work has been done in order to implement this. The patch at [1] implements general
>ioctl permissions defined by LSM that can be mapped by individual security modules like SELinux
>to their own module-specific permission checks. Filesystem-specific ioctl commands are
>mapped to generic ioctl permissions through a table defined in each driver or proper fs code
>(ie. fs/ext2/ioctl.c for ext2) as well as capability that can be checked within the selinux_file_ioctl
>when the ioctl command is issued. The patch was sent to the linux-security-module mailing list for
>review [2] and Chris Wright replied suggesting a completely different (and much more simple)
>approach based on IOC_DIR checks for read/write operations distinction.
>
>This approach was also much less intrusive as in maintenance terms as it didn't require changes
>within drivers or fs-specific code, nor the implementation of any mapping tables.
>
>A patch based upon Chris' comments was developed ([3]). It basically performs a check for distinction
>of a read/write ioctl command and constructs an access vector with the getattr/setattr permissions.
>Although, this approach has a potential concern. setattr permission also covers chown/chmod and other
>cases. This is the desired behavior for certain ioctl commands (ie. EXT3_IOC_SETFLAGS) but other
>ones that perform data write (write permission) may not be suitable for setattr permission
>(set attributes). One example of conflict is ssh performing an ioctl on /dev/ptmx to allocate the
>pty, triggering a setattr denial since it gets _IOC_WRITE back from the _IOC_DIR checks in
>selinux_file_ioctl hook.
>
>The dilemma is that we could map _IOC_READ/WRITE to read/write permissions respectively, solving the
>ssh case but we would have still no distinction between EXT3_IOC_SETFLAGS/SETVERSION ioctl commands
>and a data write to the file.
>
>Feedback will be appreciated, regarding this issue as well as suggestions, comments and possible
>solutions regarding it's implementation and impact on the policy.
>
>
>	[1]: http://pearls.tuxedo-es.org/selinux/patches/lsm-checkioctl-hook.patch
>	[2]: http://marc.theaimsgroup.com/?l=linux-security-module&m=113155354300994&w=2
>	[3]: http://pearls.tuxedo-es.org/selinux/patches/selinux-file_ioctl-iocdir-checks.patch
>
>
>Signed-off-by: <Lorenzo Hernández García-Hierro <lorenzo@gnu.org>>
>---
>
> security/selinux/hooks.c |   48 ++++++-----------------------------------------
> 1 files changed, 7 insertions(+), 41 deletions(-)
>
>diff -puN security/selinux/hooks.c~selinux-file_ioctl-iocdir-checks security/selinux/hooks.c
>--- linux-2.6.14-mm2/security/selinux/hooks.c~selinux-file_ioctl-iocdir-checks	2005-12-20 20:23:07.000000000 +0100
>+++ linux-2.6.14-mm2-lorenzo/security/selinux/hooks.c	2005-12-20 20:23:07.000000000 +0100
>@@ -40,9 +40,7 @@
> #include <linux/file.h>
> #include <linux/namei.h>
> #include <linux/mount.h>
>-#include <linux/ext2_fs.h>
> #include <linux/proc_fs.h>
>-#include <linux/kd.h>
> #include <linux/netfilter_ipv4.h>
> #include <linux/netfilter_ipv6.h>
> #include <linux/tty.h>
>@@ -2349,47 +2347,15 @@ static void selinux_file_free_security(s
> static int selinux_file_ioctl(struct file *file, unsigned int cmd,
> 			      unsigned long arg)
> {
>-	int error = 0;
>-
>-	switch (cmd) {
>-		case FIONREAD:
>-		/* fall through */
>-		case FIBMAP:
>-		/* fall through */
>-		case FIGETBSZ:
>-		/* fall through */
>-		case EXT2_IOC_GETFLAGS:
>-		/* fall through */
>-		case EXT2_IOC_GETVERSION:
>-			error = file_has_perm(current, file, FILE__GETATTR);
>-			break;
>-
>-		case EXT2_IOC_SETFLAGS:
>-		/* fall through */
>-		case EXT2_IOC_SETVERSION:
>-			error = file_has_perm(current, file, FILE__SETATTR);
>-			break;
>-
>-		/* sys_ioctl() checks */
>-		case FIONBIO:
>-		/* fall through */
>-		case FIOASYNC:
>-			error = file_has_perm(current, file, 0);
>-			break;
>+       u32 av = 0;
>+       int dir = _IOC_DIR(cmd);
> 
>-	        case KDSKBENT:
>-	        case KDSKBSENT:
>-			error = task_has_capability(current,CAP_SYS_TTY_CONFIG);
>-			break;
>+       if (dir & _IOC_READ || cmd == FIONREAD || cmd == FIBMAP || cmd == FIGETBSZ)
>+               av |= FILE__GETATTR;
>+       if (dir & _IOC_WRITE)
>+               av |= FILE__SETATTR;
> 
>-		/* default case assumes that the command will go
>-		 * to the file's ioctl() function.
>-		 */
>-		default:
>-			error = file_has_perm(current, file, FILE__IOCTL);
>-
>-	}
>-	return error;
>+       return file_has_perm(current, file, av);
> }
> 
> static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
>_
>
>Cheers.
>-- 
>Lorenzo Hernández García-Hierro <lorenzo@gnu.org> 
>[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
