Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Fri, 20 Dec 2002 19:40:31 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <200212192333.12008.russell@coker.com.au> <200212201025.34107.pollard@admin.navo.hpc.mil>
In-Reply-To: <200212201025.34107.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <200212201940.32007.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Dec 2002 17:25, Jesse Pollard wrote:
> > I guess you could have different roles, and have sshd only allow
> > transitioning to a low security role which is prohibited from running ssh
> > or gpg.  I wonder whether a domain that only has full access to
> > user_home_dir_t and user_home_t can misdirect the actions of ssh or gpg..
>
> Only if ssh/gpg doesn't have the ability to distinguish between secure data
> and insecure data. It would seem reasonable (for some level of reasonable)
> that gpg should be able to sign less secure data using a normally
> inaccessable secret key, IF it can recognize that changing/generating keys
> is not allowed (or perhaps it should, provided the keys are also marked at
> the lower level - multilevel filesystems are a bitch to debug)

It seems reasonable to me that the main part of the ssh and gpg programs 
should be devoted to operating on behalf of the user rather than trying to 
enforce system policies.

If the sshd and gpg programs have to know about system security policies then 
I think that indicates that a bad approach is being taken to security.

The gpg people seem to like my idea of having a separate process that just 
reads the gpg secret key and pipes it back to the main application.  That 
allows me as a SE Linux policy author and every SE Linux administrator to 
have choices about how the security policy works that don't affect gpg 
compilation.  I don't think that the authors of such programs want to be 
worried about the issues we are discussing, and in the case of ssh I don't 
want to trust the authors for this.

> If it is at a lower level, then yes, some functionality should be lost -
> though that should not be significant, PROVIDED the X server and KDE know
> how to compartmentalize the facilities communicating with that less trusted
> service.

They don't.  This is something I would like to do.  I thought about giving a 
paper on this for OLS 2003, but at this stage I doubt I'll get it done in 
time.

Some of this coding is going to get really ugly.

> I realize that this is NOT a simple thing to do. It does require full
> compartemented workstation support.

To do it properly it does require CW support.  To do a half-job that will stop 
the majority of potential exploits SE Linux will do OK right now I think.

> > The problem is that if you can run GPG currently you can encrypt the
> > secret key to yourself with a password (IE not encrypting to a public
> > key) and then decrypt the result to get the key.  A future version of GPG
> > will address this.  I don't know how PGP performs in this regard.
>
> Yup. That is one of the things the application must be able to evaluate.
> The output media/medium is the determining factor here. To do this requires
> reading data with a high level label by a trusted process which must NOT
> write that data to a media/medum with a low level label. That trusted
> process SHOULD be able to read low labeled data, munch it using high labled
> data, and write it to a low labeled media/medum since this is WHY it is a
> trusted process.

Are you sure that it's a good idea to make gpg a trusted program that can 
over-ride MLS boundaries rather than have it merely be trusted to perform the 
actions that the user requests of it?

Currently we only have to trust that gpg will do what we tell it to.  The GPG 
developers plan to make some small changes to make it easier for me to ensure 
that gpg isn't executed in the wrong way by the wrong program.

If gpg has to become a trusted part of system security (as it is on default 
Linux systems due to being SUID root) then the requirements on gpg are much 
greater.  The counter arguement of course is that this level of trust in gpg 
apparently works OK on default Linux setups...

> Personally, I dislike the idea of privileged applications. For a secure
> environment, I would prever all secret keys to be maintained by a security
> server process, and all queries/updates for access to this data to be
> carried out by that security server. This would turn at least half of
> GPG/Kerberos functions over to the security server (which should pass the
> actions on the keys to sub processes. That includes encryption/decryption
> services, though the security server may just pass a socket connection back
> to the requesting application to allow that application to push data into
> the encryption engine and either recieve the results, or the output could
> already be connected to another socket for outgoing data.
>
> Complicated perhaps, but no trusted application need exist other than the
> security server. And the users would have no need to access the secret keys
> directly.

Interesting idea.  Sounds like kerberos on steroids.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
