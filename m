From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?iso-8859-2?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: FS crash
Date: Wed, 14 Jan 2004 23:17:18 +1100
References: <1074008995.7158.18.camel@kusturica>
In-Reply-To: <1074008995.7158.18.camel@kusturica>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200401142317.18958.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Jan 2004 02:49, Magosányi Árpád <mag@bunuel.tii.matav.hu> wrote:
> Pass 1: Checking inodes, blocks, and sizes
> Extended attribute block 246069 has reference count 1020, should be
> 1018.  Fix<y>? yes

I've seen this many times on i386 machines.  So far no problems have occurred, 
so I conclude that it's moderately harmless.

The other errors seem more serious, and a SEGV is a very serious problem.  Are 
you in a position to build a e2fsck with debugging code and get a stack 
trace?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
