Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: fegler@bigfoot.com, SELinux@tycho.nsa.gov
Subject: Re: kde rules
Date: Mon, 4 Nov 2002 19:21:55 +0100
References: <200210181642.34552.fegler@bigfoot.com> <200210190114.47251.russell@coker.com.au>
In-Reply-To: <200210190114.47251.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200211041921.55071.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am being forced to look further into this matter.

One issue I have with my games domain is that it is denied access to ~/.qt and 
~/.kde for KDE games.

So now I am thinking of labelling those directories (and all subdirectories 
and files) with a type that allows full access by user_t, and read-only 
access by user_games_t.

However this raises one problem.  In a typical /etc/skel we don't have any .qt 
and .kde directories, so at the time SE Linux is installed there's a good 
chance that many users will not have those directories (and therefore they 
won't be labelled).  If the directories get created with user_home_t then the 
games won't work properly.

So I think that we need some sort of relablling program.  Firstly we need to 
have setfiles use the correct identity for the files, for this I was thinking 
of using regular expression substitution to map the identity in (which needs 
to have some fallback code for the case of a user who's identity isn't 
compiled into the policy and therefore gets user_u and therefore system_u for 
the files).  Then once we have ensured that all files and directories will 
have the correct identity we can have a tool to allow the user to check the 
types of the files under their home directory against a setfiles type config 
file and then be offered the opportunity to relabel files to match (if they 
can).

What do you think?

On Sat, 19 Oct 2002 01:14, Russell Coker wrote:
> On Sat, 19 Oct 2002 00:42, Brian Fegler wrote:
> > I am working on locking down kde. I would like to have a rule set that
> > would not allow any user initiated kde related processes to write or read
> > from the user's directory.
>
> If you want to try such things then look at my games domain and the
> netscape domain in the current CVS policy tree.  They have most of what you
> need.
>
> Now one thing you haven't explained is why you want to do this.
>
> We have a separate domain for Netscape because of it's significant network
> actions (which are a risk) and because it has had a history of security
> problems.  I have recently created a separate domain for games because
> games don't need any access to important files, and are generally written
> by people who aren't too bothered by security issues.
>
> Why make separate domains for KDE?  KDE by it's nature is dealing with your
> files and processes.  If you want to have full KDE functionality then it
> probably all needs to be in the main domain.
>
> I've been thinking of making a separate domain for kmail because kmail has
> sharply defined tasks and is easy to limit (it will require some hacking of
> KDE code and then some negotiation to try and get the changes into the KDE
> source tree).  But for the rest I've given up.
>
> Konqueror is one program that you would like to have running in a different
> domain, but there are two problems.  One problem is that it's used as a
> local file browser (which requires full read and write access to all your
> files) as well as a web browser (when you would like to restrict the
> access).  Now it's quite common to have Konq being used to browse files, to
> read a local .html file, and then to click on a link on a web page.  So you
> have it going from a local file manager to the web browser use.
>
> When you want to have a terminal process KDE will run a konsole for you
> which runs bash.  So if you have a domain for the main KDE programs then it
> would have to have an auto-trans rule to transition to user_t when running
> either the konsole program or the shell_exec_t.  In either case it would be
> possible for /bin/bash to be executed in such a way that it performs some
> action on files that you are trying to deny from kde.
>
> Due to the way it works I think that KDE has to be "trusted".  I've read
> the source and having KDE be trusted doesn't exactly thrill me, so if you
> can solve these problems then I'll be happy to help you implement the
> solution.
>
> > Some exceptions would be:
> > kde_kmail_t => full permissions on user_mailbox_t
>
> We don't have a user_mailbox_t yet, it has to be done though.
>
> > xauth, dcop*, iceauth and kdeinit all write, read, create and delete from
> > the home directory extensively.
> >
> > I had wanted to have different types for .qt*, .DCOP*, .Xauthority, ...,
>
> I've already created a type for .Xauthority and it's in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
