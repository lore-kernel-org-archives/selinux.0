From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "S. Patel" <spatel@elp.rr.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Errors While Installing On Redhat 8.0
Date: Mon, 24 Feb 2003 18:51:50 +0100
References: <004601c2daca$dc53e5d0$6400a8c0@Comp1>
In-Reply-To: <004601c2daca$dc53e5d0$6400a8c0@Comp1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302241851.50717.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 23 Feb 2003 00:33, S. Patel wrote:
> make[1]: Entering directory `/home/Devesh/Programs/SELinux/selinux/policy'
> rm -rf /etc/security/selinux/src/policy.old
> mv /etc/security/selinux/src/policy /etc/security/selinux/src/policy.old
> mv: cannot stat `/etc/security/selinux/src/policy': No such file or
> directory make[1]: *** [install-src] Error 1
> make[1]: Leaving directory `/home/Devesh/Programs/SELinux/selinux/policy'
> make: *** [quickinstall] Error 2

That looks like a bug in policy/Makefile in selinux-small.  The mv line in 
question should probably be prefixed with '-' to tell make to ignore such 
errors.

BTW In such situations it's usually best to just send the relevant messages 
and some context, the previous pages of successful operations is not needed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
