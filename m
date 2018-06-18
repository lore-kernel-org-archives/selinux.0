To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <20180618192443.GA8162@workstation>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b0a52b4d-ff8c-8970-d738-8901ff37b12a@tycho.nsa.gov>
Date: Mon, 18 Jun 2018 16:06:11 -0400
MIME-Version: 1.0
In-Reply-To: <20180618192443.GA8162@workstation>
Content-Type: text/plain; charset=utf-8
Subject: Re: is_selinux_enabled() after chroot()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2018 03:24 PM, Petr Lautrbach wrote:
> Hello,
> 
> libselinux sets selinut_mnt and has_selinux_config only in its constructor and
> is_selinux_enabled() and others just use selinux_mnt to check if SELinux is
> enabled. But it doesn't work correctly when you use chroot() to a directory without /proc
> and /sys/fs/selinux mounted as it was discovered in
> https://bugzilla.redhat.com/show_bug.cgi?id=1321375 
> 
> In this case, is_selinux_enabled() after chroot() returns true while in a new
> program run from chrooted process it returns false. It can be demonstrated by
> the steps below.
> 
> The solution could be to check if selinux_mnt still exists whenever a function
> depending on this is called. Would this be acceptable?

You want to call stat() or access(F_OK) on selinux_mnt and/or SELINUXCONFIG in is_selinux_enabled()?
Could potentially trigger a permission check that wasn't previously required, thereby breaking existing policies.
Caller might just be checking to see if SELinux is enabled before using interfaces other than selinuxfs (e.g. setexeccon, setfilecon, etc) and therefore didn't previously need permissions to selinuxfs or /etc/selinux/config.
So, possible but you'd need to make sure you don't break anything.  Definitely don't want that changed in Android.

> 
> 
> 
> 
> $ sudo dnf --nogpg --installroot=/var/lib/machines/example  install systemd
> 
> $ cat > test_libselinux.c <<EOF
> #include <selinux/selinux.h>
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[]) {
>   pid_t pid;
>   int wstatus;
> 
>   if (argc > 1) {
>     printf("SELinux in chrooted process: %d\n", is_selinux_enabled());
>     return 0;
>   }
>   if (chroot("/var/lib/machines/example") != 0)
>     return -1;
> 
>   printf("SELinux in process after chroot(): %d\n", is_selinux_enabled());
>   printf("/sys/fs/selinux exists: %d\n", access("/sys/fs/selinux", F_OK));
>   printf("/etc/selinux/config exists: %d\n\n", access("/etc/selinux/config", F_OK));
> 
>   if ((pid = fork()) == 0 ) {
>     execv("./test_is_selinux_enabled", (char *[]){ "./test_is_selinux_enabled", "chrooted", NULL});
>   }
> 
>   wait(&wstatus);
>   return 0;
> }
> EOF
> 
> $ gcc -o test_is_selinux_enabled test_libselinux.c -lselinux
> 
> $ sudo ./test_is_selinux_enabled                            
> SELinux in process after chroot(): 1
> /sys/fs/selinux exists: -1
> /etc/selinux/config exists: -1
> 
> SELinux in chrooted process: 0
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
