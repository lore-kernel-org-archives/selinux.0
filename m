From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
Date: Thu, 10 Jun 2004 16:26:54 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20040601090345.GM8312@lkcl.net> <200406042132.40136.russell@coker.com.au> <40C7472E.80607@redhat.com>
In-Reply-To: <40C7472E.80607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406101626.54807.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 03:21, Daniel J Walsh <dwalsh@redhat.com> wrote:
> openssh has been repatched with the old patch.  Basically openssh 3.8
> has this kind of pseudo code.
>
> Authenticate
> If UID != 0
>        pam_open_session
>        Drop Creds
> Alloc TTY
> IF UID == 0
>        pam_open_session
> Exec shell
>
> After investigating how we could get this behavior changed we decided to
> just patch openssh with the setexec and tty relabel, and drop
> pam_selinux from /etc/pam.d/sshd

OK.

Another thing, I think it would be good if we could have sshd drop creds for 
uid == 0 as well.  On a SE Linux system there is no guarantee that uid 0 has 
administrative privs, and having multiple code paths does not seem to be a 
benefit for security.  When I was last maintaining a patched sshd I did that, 
it was a couple of extra lines of code that seemed to be useful.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
