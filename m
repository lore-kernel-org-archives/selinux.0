Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Thu, 19 Dec 2002 10:51:19 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <200212180845.22750.russell@coker.com.au> <20021218222704.GH10185@snoopy.apana.org.au>
In-Reply-To: <20021218222704.GH10185@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212191051.19213.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Dec 2002 23:27, Brian May wrote:
> On Wed, Dec 18, 2002 at 08:45:22AM +0100, Russell Coker wrote:
> > Which is something you could easily achieve through PAM configuration if
> > that is what you desire, without any kerberos issues etc.
>
> How would you do it with PAM?

Put the following in /etc/pam.d/newrole:
auth    required        pam_permit.so

NB I'm not advocating doing this, just letting you know it's possible.

> What security issues would this raise?

It largely removes the point of having newrole.  In that case you should 
probably just permit each user exactly one role and give the default domain 
for that role the permissions required to do everything that they need to do.

One significant disadvantage is that a hacked sshd could run "newrole -r 
sysadm_r" and get that access (and this can be extended to other programs 
with a similar situation).

Of course if you allow someone the ability to transition to a role with less 
capabilities than their default role, and then denied them the ability to run 
the newrole program while in that role it might have some potential.

> > Also I think that in most situations where a user could be tricked into
> > running newrole then it's game-over anyway.
>
> OK. I was thinking more of scripts, etc.

It's the same thing.  If I can trick you into running some arbitary commands 
with your main role then I can get your ssh identity key and your gpg secret 
key.  These crypto keys are often worth more than the hardware that they are 
stored on...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
