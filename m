From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, Hojat Vaheb <hojatvaheb@yahoo.com>
Subject: Re: [Fwd: load_policy problem]
Date: Wed, 18 May 2005 23:52:54 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <428B2C7A.1050207@redhat.com>
In-Reply-To: <428B2C7A.1050207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505182352.58502.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I did all above parts successfully except loading policy.18 because every
> time I ran load_policy command my computer hanged and I had to restart my
> computer.  
>
> what's wrong?

How exactly did the computer hang?  Can you try this when logged in at a 
virtual console (IE a non-graphical login) so that you can see kernel 
messages.  If a SE Linux policy error causes the system to stop operating 
then there should be many messages displayed on the console about it.

If messages display to fast to read then enable a serial console and log them 
to disk.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
