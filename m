Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: fegler@bigfoot.com, SELinux@tycho.nsa.gov
Subject: Re: kde rules
Date: Mon, 4 Nov 2002 19:31:12 +0100
References: <200210181642.34552.fegler@bigfoot.com> <200210190114.47251.russell@coker.com.au> <200211041921.55071.russell@coker.com.au>
In-Reply-To: <200211041921.55071.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200211041931.12062.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 4 Nov 2002 19:21, Russell Coker wrote:
> I am being forced to look further into this matter.
>
> One issue I have with my games domain is that it is denied access to ~/.qt
> and ~/.kde for KDE games.
>
> So now I am thinking of labelling those directories (and all subdirectories
> and files) with a type that allows full access by user_t, and read-only
> access by user_games_t.

Damn, that doesn't work either.  KDE is a mess.  It requires access to 
sym-links and files that are created in the user home directory and in /tmp 
at login time.

Looks like we can't do much with it unless we get some code changes in KDE.

I wonder if GNOME is any better...  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
