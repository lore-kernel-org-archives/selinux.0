From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Matthew R. Singer" <msinger@itac.com>, <SELinux@tycho.nsa.gov>
Subject: Re: spassword
Date: Sat, 5 Apr 2003 13:29:34 +1000
References: <8A61167D13CED411B3E500B0D079784703AAEE@mailserver.itac.reston>
In-Reply-To: <8A61167D13CED411B3E500B0D079784703AAEE@mailserver.itac.reston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304051329.34297.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 5 Apr 2003 06:50, Matthew R. Singer wrote:
> Running spasswd fails with:
>
> /usr/local/selinux/bin/spasswd:  Unix identity root does not match Flask
> identity system_u

In a correctly configured system you can not login with identity system_u.  
The fact that you have done so indicates that the login program (/bin/login, 
sshd, xdm, etc) that you used to start the session in question is not a SE 
Linux patched version but is instead the default version from your OS.

If you install the modified login program then all should be fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
