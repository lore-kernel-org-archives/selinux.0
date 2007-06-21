Subject: Re: RHEL5 console login problem - pam_selinux cannot determine new
	context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kearney <lukek@amazon.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <467A8A93.20807@amazon.com>
References: <467A8A93.20807@amazon.com>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 11:01:34 -0400
Message-Id: <1182438094.15064.293.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 15:26 +0100, Luke Kearney wrote:
> Hi there,
>                                                                                                                                                        
>  
> I'm getting a problem when logging in on a console on a RHEL5 box, I am 
> suspecting that the problem is somewhere in pam_selinux.so

I saw the same bug in Fedora a while ago, and it was a bug in
pam_selinux.  Dan, is there an update for RHEL5?

>                                                                                                                                                        
>  
> I'm not sure if it's a misconfiguration of mine, or a bug...
>                                                                                                                                                        
>  
> I'm using:
> RHEL5, with
> pam-0.99.6.2-3.14.el5
> libselinux-1.33.4-2.el5
> selinux-policy-2.4.6-67.el5
>                                                                                                                                                        
>  
> With the default pam options, pam_selinux is unable to get the user 
> context, and so there is no transition when a user logs in on the 
> console, and they end up in the "system_u:system_r:local_login_t" context
>                                                                                                                                                        
>  
> Relevant line in /etc/pam.d/login:
> session    required     pam_selinux.so open verbose debug
>                                                                                                                                                        
>  
> The console login with default pam options:
>                                                                                                                                                        
>  
> ...
> testhost login: root
> Password:
> Security Context (null) Assigned
> Last login: Thu Jun 21 07:04:28 on tty1
> [root@testhost ~]# id -Z
> system_u:system_r:local_login_t:SystemLow-SystemHigh
>                                                                                                                                                        
>  
> And here is the syslogged debug info:
>                                                                                                                                                        
>  
> Jun 21 05:27:28 testhost login: pam_unix(login:session): session opened 
> for user root by LOGIN(uid=0)
> Jun 21 05:27:28 testhost login: pam_selinux(login:session): Open Session
> Jun 21 05:27:28 testhost login: pam_selinux(login:session): Username= 
> root SELinux User = root Level= s0-s0:c0.c1023
> Jun 21 05:27:28 testhost login: pam_selinux(login:session): Warning!  
> Could not get new context for /dev/tty1, not relabeling: Invalid argument
> Jun 21 05:27:28 testhost login: pam_selinux(login:session): 
> usercon=(null), prev_context=system_u:object_r:tty_device_t
> Jun 21 05:27:28 testhost login: pam_selinux(login:session): Security 
> Context (null) Assigned
> Jun 21 05:27:28 testhost login: pam_selinux(login:session): set root 
> security context to (null)
> Jun 21 05:27:28 testhost login: ROOT LOGIN ON tty1
>                                                                                                                                                        
>  
>                                                                                                                                                         
> 
> However if I change pam_selinux to use the select_context option, then 
> it *does* correctly determine the default context:
>                                                                                                                                                         
> 
> So changing /etc/pam.d/login:
> session    required     pam_selinux.so open verbose select_context debug
>                                                                                                                                                         
> 
> And now the console login:
>                                                                                                                                                         
> 
> testhost login: root
> Password:
> Default Security Context root:sysadm_r:sysadm_t:SystemLow-SystemHigh
>                                                                                                                                                         
> 
> Would you like to enter a different role or level? [n]
> Security Context root:sysadm_r:sysadm_t:SystemLow-SystemHigh Assigned
> Last login: Thu Jun 21 07:06:21 on tty1
> [root@testhost ~]# id -Z
> root:sysadm_r:sysadm_t:SystemLow-SystemHigh
> 
> And here is the strace of the pam_selinux failure (stracing mingetty on 
> tty1):
>                                                                                                                                                         
> 
> send(3, "<87>Jun 21 05:27:28 login: pam_selinux(login:session): 
> Username= root SELinux User = root Level= s0-s0:c0.c1023", 111, 
> MSG_NOSIGNAL) = 111
> gettid()                                = 3376
> open("/proc/self/task/3376/attr/exec", O_RDONLY|O_LARGEFILE) = 4
> read(4, "", 4095)                       = 0
> close(4)                                = 0
> getxattr("/dev/tty1", "security.selinux", 
> "system_u:object_r:tty_device_t:s0", 255) = 34
> socket(PF_FILE, SOCK_STREAM, 0)         = 4
> connect(4, {sa_family=AF_FILE, path="/var/run/setrans/.setrans-unix"}, 
> 110) = 0
> sendmsg(4, {msg_name(0)=NULL, msg_iov(5)=[{"\2\0\0\0", 4}, {"\"\0\0\0", 
> 4}, {"\1\0\0\0", 4}, {"system_u:object_r:tty_device_t:s0\0", 34}, {"\0", 
> 1}], msg_controllen=0, msg_flags=0}, MSG_NOSIGNAL) = 47
> readv(4, [{"\2\0\0\0", 4}, {"\37\0\0\0", 4}, {"\0\0\0\0", 4}], 3) = 12
> readv(4, [{"system_u:object_r:tty_device_t\0", 31}], 1) = 31
> close(4)                                = 0
> socket(PF_FILE, SOCK_STREAM, 0)         = 4
> connect(4, {sa_family=AF_FILE, path="/var/run/setrans/.setrans-unix"}, 
> 110) = 0
> sendmsg(4, {msg_name(0)=NULL, msg_iov(5)=[{"\3\0\0\0", 4}, {"\37\0\0\0", 
> 4}, {"\1\0\0\0", 4}, {"system_u:object_r:tty_device_t\0", 31}, {"\0", 
> 1}], msg_controllen=0, msg_flags=0}, MSG_NOSIGNAL) = 44
> readv(4, [{"\3\0\0\0", 4}, {"\"\0\0\0", 4}, {"\0\0\0\0", 4}], 3) = 12
> readv(4, [{"system_u:object_r:tty_device_t:s0\0", 34}], 1) = 34
> close(4)                                = 0
> open("/selinux/relabel", O_RDWR|O_LARGEFILE) = 4
> write(4, "(null) system_u:object_r:tty_device_t:s0 10", 43) = -1 EINVAL 
> (Invalid argument)
> close(4)                                = 0
> time(NULL)                              = 1182428848
> stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=1037, ...}) = 0
> stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=1037, ...}) = 0
> stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=1037, ...}) = 0
> send(3, "<85>Jun 21 05:27:28 login: pam_selinux(login:session): 
> Warning!  Could not get new context for /dev/tty1, not relabeling: 
> Invalid argument", 138, MSG_NOSIGNAL) = 138
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
