From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Rafal Wojtczuk <rafal@intruvert.com>, SELinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux (fwd)
Date: Sat, 7 Jun 2003 04:30:15 +1000
References: <20030606170611.GA701@emperor.intruvert.com>
In-Reply-To: <20030606170611.GA701@emperor.intruvert.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200306070430.15501.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 7 Jun 2003 03:06, Rafal Wojtczuk wrote:
> Russel> Over the last few days on the #selinux list there has been
> Russel> discussion of these things.  The easiest implementation of such an
> Russel> attack (which was successfully used in practise) was to create a
> Russel> shell function named newrole() which gets
> You mean, alter ~someuser/.bashrc ? At least in my setup (default policy),
> root:user_r:user_t has no access to ~root.

If root has dac_override capability then it can over-write the .bashrc.

If you crack sshd then you can login with whichever UID you choose and the 
ability to write the files in that user's home directory (with the current 
default policy).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
