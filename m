From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Problem with SELinux and Squid+Winbind+Samba
Date: Fri, 7 Jan 2005 02:06:00 +1100
Cc: "Luis Fernando C. Talora" <luis.talora@iesa.com.br>,
   " (SELinux@tycho.nsa.gov)" <SELinux@tycho.nsa.gov>
References: <5D201EB6E3041946BC4F8F6A14296132607EE3@svnt4-5.inepar.com.br> <20041207204111.GC5153@lkcl.net>
In-Reply-To: <20041207204111.GC5153@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501070206.03854.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 08 December 2004 07:41, Luke Kenneth Casson Leighton 
<lkcl@lkcl.net> wrote:
>   the first thing is, ideally, to write a separate policy for winbindd,
>   esp. making /var/run/winbindd have its own file context.

Dan has just done so.

>   then you can grant wb_ntlmmauth (or squid_t) the right to access
>   /var/run/winbindd/pipe.
>
>  ... anyone got any opinions as to whether winbind should be creating a
>  socket in /var/run?  is that FHS compliant?

grep var_run.*sock_file policy.conf

Sockets in /var/run are quite common as the above grep command will 
illustrate.  Either the FHS is fine with that or there are many buggy 
programs.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
