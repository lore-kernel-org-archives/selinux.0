Message-ID: <1494251588.4621.7.camel@tycho.nsa.gov>
Subject: Re: Does recvfrom(2) imply { getattr }?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ian Pilcher <arequipeno@gmail.com>, selinux <selinux@tycho.nsa.gov>
Date: Mon, 08 May 2017 09:53:08 -0400
In-Reply-To: <f08e1e6f-81be-1255-ca80-2ee9594b5739@gmail.com>
References: <f08e1e6f-81be-1255-ca80-2ee9594b5739@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-05-06 at 18:45 -0500, Ian Pilcher wrote:
> I'm getting a non-fatal { getattr } denial on a UDP socket (talking
> to a
> DNS server).  strace doesn't show any fstat calls on the socket, but
> it
> does show that recvfrom is being called.
> 
> Does recvfrom want getattr permission in order to retrieve the
> message
> source?  (The other potential system calls are poll and
> ioctl(FIONREAD).)

ioctl(FIONREAD) triggers a getattr permission check because it can be
used to get the file size.
