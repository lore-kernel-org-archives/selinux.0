From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <matt@finaldraftbooks.com>, "Matthew R. Singer" <msinger@itac.com>,
   <SELinux@tycho.nsa.gov>
Subject: Re: Sendmail tcp_socket denial
Date: Fri, 14 Mar 2003 14:21:17 +0100
References: <8A61167D13CED411B3E500B0D079784703AAC4@mailserver.itac.reston>
In-Reply-To: <8A61167D13CED411B3E500B0D079784703AAC4@mailserver.itac.reston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303141421.17339.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Mar 2003 13:38, Matthew R. Singer wrote:
> Sorry to send this direct to you, but if I email to the selinux list, it
> bounces with a relaying error.

The list should be fixed now.

> Can anyone explain to me where this is coming from?
>
> avc:  denied  { recvfrom } for  saddr=127.0.0.1 source=32771
> daddr=127.0.0.1 dest=25 netif=lo scontext=system_u:system_r:sendmail_t
> tcontext=root:sysadm_r:sysadm_mail_t tclass=tcp_socket

It seems that /usr/bin/sendmail is being run by the administrator (sysadm_t) 
in a way that makes it try to connect to localhost port 25 (SMTP port).

/usr/bin/sendmail being run from sysadm_t (which is what causes a transition 
into sysadm_mail_t) is something that normally only happens from mailx or 
other mail clients using the /usr/bin/sendmail command to queue mail.

The /usr/bin/sendmail command on a system running the Sendmail mail server 
should write the message to the queue and therefore not require any such TCP 
access.

Has this just started occuring with the latest version of Sendmail?  Maybe 
they have changed the way it works (although that seems unlikely).

Are you running more than one mail server program on the same machine?  Are 
you running smail or exim or another mail program that's somewhat similar to 
sendmail with the sendmail.te policy?  If so that's a bad idea, separate 
policy is needed for each mail server.

Please tell us more about what you are doing so we can try and track it down.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
