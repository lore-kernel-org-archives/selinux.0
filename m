From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: More SELinux fixes.
Date: Fri, 8 Oct 2004 23:41:32 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <4165B9AA.8090803@redhat.com>
In-Reply-To: <4165B9AA.8090803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410082341.32225.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Oct 2004 07:48, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Please eliminate space before "udp" in inetd_child calls.  This will not
> work correctly with the space.

In what way doesn't it work correctly?

I just did a quick test and diff didn't report any difference in the result 
when I added a space.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
