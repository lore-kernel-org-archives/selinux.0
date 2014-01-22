Message-ID: <52E03267.7040501@tycho.nsa.gov>
Date: Wed, 22 Jan 2014 16:04:39 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: runcon and setsid()
References: <3472773.GEUBITOd3I@russell.coker.com.au>
In-Reply-To: <3472773.GEUBITOd3I@russell.coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/22/2014 01:55 AM, Russell Coker wrote:
> https://lists.debian.org/debian-devel/2014/01/msg00164.html
> 
> Above is the URL for a post to debian-devel about su and exploits involving 
> TIOCSTI ioctl.  They mention runcon, should we be calling setsid() in there?
> 
> I haven't inspected the runcon source recently, but a quick strace run on 
> Debian/Unstable shows that setsid() isn't being called.

SELinux revalidates access to the controlling tty on a context
transition and will drop the controlling tty if it is not allowed.  So
at present that is controlled by policy.
