From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: general security lib (was: 2.6.0-test3)
Date: Wed, 27 Aug 2003 13:30:51 +1000
Cc: =?iso-8859-1?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <200308230009.19552.russell@coker.com.au> <1061908814.23880.113.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1061908814.23880.113.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308271330.51452.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Aug 2003 00:40, Stephen Smalley wrote:
> On second thought, I'm not sure that the above is correct.  The existing
> SELinux patch parallels the existing code in login and sshd; it invokes
> setexeccon() to set the exec security context just as the existing code
> invokes setuid() to set the user identity, and it invokes setfilecon()
> to set the tty/pty security context just as the existing code invokes
> chown() and chmod() to set the tty/pty ownership and mode.  Why would
> the SELinux patch be migrated into PAM when the setuid(), chown(), and
> chmod() is not?

The idea is that the setuid/chown/etc code would be put in the module too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
