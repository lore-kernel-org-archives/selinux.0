Message-ID: <515EFB64.1070202@tycho.nsa.gov>
Date: Fri, 05 Apr 2013 12:27:16 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: newrole and tmux
References: <20130404171045.GB12515@siphos.be>
In-Reply-To: <20130404171045.GB12515@siphos.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/04/2013 01:10 PM, Sven Vermeulen wrote:
> Hi all,
>
> I'm running with policycoreutils-2.1.13 and am noticing that tmux does not
> display its terminal output when I have switched roles with newrole. tmux is
> not SELinux-aware (not linked with libselinux) and this behavior is also
> apparent when I run in permissive mode, so I'm guessing this has to do with
> what newrole does rather then SELinux policy itself.
>
> During a strace, I notice that what I believe is the file descriptor
> representing the standard output of the tmux application is readonly,
> whereas when I have not switched roles, this is read-write.
>
> Non-working:
> #v+
> 10905 recvmsg(8, {msg_name(0)=NULL, msg_iov(1)=[{"31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:"..., 65071}], msg_controllen=24, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=SCM_RIGHTS, {10}}, msg_flags=0}, 0) = 10036
> 10905 fcntl(9, F_GETFL)                 = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> 10905 fcntl(9, F_SETFL, O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 0
> #v-
>
> Working:
> #v+
> 10905 recvmsg(8, {msg_name(0)=NULL, msg_iov(1)=[{"31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:"..., 65071}], msg_controllen=24, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=SCM_RIGHTS, {10}}, msg_flags=0}, 0) = 12116
> 10905 fcntl(9, F_GETFL)                 = 0x8002 (flags O_RDWR|O_LARGEFILE)
> 10905 fcntl(9, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) = 0
> #v-
>
> When the output isn't displayed, tmux does still work: I can run commands
> (as if it is a shell) and can even see the output when I'm also attached
> elsewhere - as long as I haven't switched roles. I can also send tmux
> commands (like detach) which succeed.
>
> Screen does not have this problem - even after switching roles, I can
> succesfully attach/detach screens. Even more, I can launch a screen session
> *after* switching role, and then I *can* use tmux (so tmux within screen)
> and get its output.
>
> Is there anything I can do to debug this further? newrole doesn't contain
> much. Also, if some of you could see if they have the same problem or not
> (tmux 1.6 and tmux 1.8 both have this behavior).

newrole closes and re-opens stdin, stdout, and stderr so that the open 
file descriptions are in its security context rather than that of the 
caller.  It re-opens stdin with O_RDONLY and stdout / stderr with O_RDWR.

You could trivially patch newrole to open stdin with O_RDWR and see if 
that helps.  If so, then tmux is using stdin as both input and output, 
which seems like a bug in it, but would work in the absence of newrole.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
