Message-ID: <551964B5.4040400@tycho.nsa.gov>
Date: Mon, 30 Mar 2015 10:59:01 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov, bigon@bigon.be
Subject: Re: [PATCH v2] run_init: Use a ring buffer in open_init_pty
References: <1427184929-31114-1-git-send-email-jason@perfinion.com>
In-Reply-To: <1427184929-31114-1-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/24/2015 04:15 AM, Jason Zaman wrote:
> open_init_pty uses select() to handle all the file descriptors. There is
> a very high CPU usage due to select() always returning immediately with
> the fd is available for write. This uses a ring buffer and only calls
> select on the read/write fds that have data that needs to be
> read/written which eliminates the high CPU usage.
> 
> This also correctly returns the exit code from the child process.
> 
> This was originally from debian where they have been carrying it as a
> patch for a long time. Then we got a bug report in gentoo which this
> also happens to fix. The original debian patch had the ring buffer
> written in C++ so I modified the class into a struct and some static
> methods so it is C-only at the request of Steve Lawrence.
> 
> Debian bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956
> Gentoo bug: https://bugs.gentoo.org/show_bug.cgi?id=532616
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> Tested-by: Laurent Bigonville <bigon@bigon.be>

Thanks, applied.
