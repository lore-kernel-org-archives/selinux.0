Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Thu, 19 Dec 2002 23:33:12 +0100
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <200212191051.19213.russell@coker.com.au> <200212190802.33560.pollard@admin.navo.hpc.mil>
In-Reply-To: <200212190802.33560.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <200212192333.12008.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Dec 2002 15:02, Jesse Pollard wrote:
> > It's the same thing.  If I can trick you into running some arbitary
> > commands with your main role then I can get your ssh identity key and
> > your gpg secret key.  These crypto keys are often worth more than the
> > hardware that they are stored on...
>
> Only if access is permitted to be over an unsecured channel.
>
> The differentation between a local user and a remote user has to be
> provided.

The "if I can trick you" part means that the distinction between local and 
remote logins is probably not relevant.  Consider that you meet someone in 
Starbucks and say "there's this really cool program at www.foo.com" which 
they then download and run...

Of course we could deny execute access to user_home_t but variations on the 
same theme can always be used while there are users who can be tricked and 
net access for easy back-channels.

> Access to the secret key(s) probably should not be permitted from an
> unsecured location/connection. This does require network labels to work.

I guess you could have different roles, and have sshd only allow transitioning 
to a low security role which is prohibited from running ssh or gpg.  I wonder 
whether a domain that only has full access to user_home_dir_t and user_home_t 
can misdirect the actions of ssh or gpg...

I don't think that network labels allow us to do anything productive in this 
regard as network operations are so abstracted.  When a KDE ioslave can talk 
to a http proxy to get access to the outside network then making real use of 
network labels without seriously reducing functionality is almost impossible.

For my aims a significant reduction in functionality is unacceptable.

> It does mean that the plugin for checking PGP signatures (at a minimum the
> one for generating signatures) would have to be sufficiently separate from
> the netscape process to be labeled separately. It could not use loadable
> modules, for  instance. It also means any scripts started should not have
> access either.

The problem is that if you can run GPG currently you can encrypt the secret 
key to yourself with a password (IE not encrypting to a public key) and then 
decrypt the result to get the key.  A future version of GPG will address 
this.  I don't know how PGP performs in this regard.

> This is not a 100% solution - If netscape is used to download an
> application, then the user proceeds to configure/compile/run then all bets
> are off since the users actions are overriding the labels. It should/could
> prevent a trojan from passing the files out though - it would not be
> authorized access to the secret key(s) or the Kerberos ticket cache. Only
> trusted utilities would have that capability.

However if the ticket can't be used on other machines then the concern is not 
that it will be passed out, but that a process holding the ticked will be 
controlled by a program that is a proxy running on behalf of a program 
outside.

One of my friends wrote a nifty set of CGI scripts to run a terminal session 
through a web page using standard web forms functionality.  It wouldn't be 
THAT much more difficult to do it the other way around and have machine 
running bash be the HTTP client and the HTTP server have the client side of 
the shell session.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
