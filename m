Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4LDZRI4015503
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 09:35:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4LDZ2Qj008322
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 13:35:03 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4LDYJxS008267
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 13:35:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: grin@tolna.net
Subject: Re: Policy for exim and/ or tiger?
Date: Wed, 21 May 2003 23:32:30 +1000
Cc: selinux@tycho.nsa.gov
References: <200305152349.28038.tk-selinux@datas-world.de> <200305202049.40285.russell@coker.com.au> <20030521101944.GG32563@narya.grin.hu>
In-Reply-To: <20030521101944.GG32563@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305212332.30805.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 May 2003 20:19, Peter Gervai wrote:
> > > allow exim_t exim_var_run_t:dir rw_dir_perms;
> > > allow exim_t exim_var_run_t:file rw_file_perms;
> >
> > The above should be taken care of by daemon_domain().
>
> Weird. I started inserting policy lines at the end when getting deny
> entries in the syslog. I'll check this, but I can't tell why were they
> required (I don't recall inserting the daemon_domain later...)

I've made some changes to the policy regarding /var/run recently.  Probably 
you created the exim policy with an older version.

> > What is the aim of the pine policy anyway?  To grant pine some access
> > that user_t is not given?  Or to lock down pine because it's got a bad
> > history?
>
> One reason is its bad history, other is the amount of weird permissions it

The problem with pine is that you almost certainly want it to run gpg for 
signing and decrypting mail.  If you give a program access to your mail spool 
and your gpg secret key then you have little possibility of preventing it 
from doing damage.

However the gpg thing could probably be solved by having an external program 
prompt for the passphrase and call gpg so that pine never gets the 
pass-phrase.

> requires, I do not know any other way to make it work. Is there any other
> way to make it fully functioning? It wants to rw ~mail, send mail by smtp
> and connect to local mail daemons, and some stuff I can't even tell the
> reason of.

I think that the best thing to do is store mail under the home directory and 
then just have pine run in user_t at the moment.

For sending mail by smtp, postfix allows any domain, the Qmail policy is setup 
for running the smtpd from inetd (which allows userdomain), and the sendmail 
policy does not appear to allow anyone to connect.

I will change the postfix policy to allow only userdomain.

> Could it work without any special policy, is this what you mean?

It should.  I always use user_t for reading mail.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
