Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Sat, 21 Dec 2002 23:34:19 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <200212201940.32007.russell@coker.com.au> <200212201407.42467.pollard@admin.navo.hpc.mil>
In-Reply-To: <200212201407.42467.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <200212212334.19069.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Dec 2002 21:07, Jesse Pollard wrote:
> > Are you sure that it's a good idea to make gpg a trusted program that can
> > over-ride MLS boundaries rather than have it merely be trusted to perform
> > the actions that the user requests of it?
>
> Not all boundaries - only the one protecting the gpg secret key. You have
> to trust some program somewhere, and this one would seem to be the minimum.

I probably should try out MLS.

> The only modifications I can think of are that it would NOT allow the key
> to be extracted IF it is providing output for a lower security level. I
> think it would be desirable to allow it to USE the key (for encryption,
> decrypton, and signing), but not allow the key itself to get out of the
> application, nor allow the key to be replaced.

OK.  This all sounds reasonable.  Are you planning to do some coding on it?

I have no plans to ever do any gpg coding...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
