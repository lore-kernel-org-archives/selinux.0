From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Rene Cunningham <rene@dclabs.com.au>
Subject: Re: login as sysadm_r remotely
Date: Wed, 27 Oct 2004 02:03:25 +1000
Cc: SELinux@tycho.nsa.gov
References: <20041023112327.GW8603@eden.office.dclabs.com.au>
In-Reply-To: <20041023112327.GW8603@eden.office.dclabs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410270203.25440.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Oct 2004 21:23, Rene Cunningham <rene@dclabs.com.au> wrote:
> Im trying to allow remote logins via ssh as root to use the sysadm_r role
> by default. At the moment root logs in using staff_r and newrole -r needs
> to be executed. I do want to force logins via tty's to default to
> staff_r though.

The new policy I have just uploaded to Debian and put on my site permits this.  
But note that you also need the new checkpolicy to match.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
