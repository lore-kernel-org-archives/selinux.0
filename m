Date: Sun, 15 Feb 2004 20:27:27 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Of applications and separating configuration systems
Message-ID: <20040215202727.GG1083@gallifrey>
References: <20040214000922.GA1083@gallifrey> <200402141521.49027.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402141521.49027.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Russell Coker (russell@coker.com.au) wrote:

  (In reply to my comments about separating config/preference editing
  out of apps)

> I agree.  However there is the issue of maintaining correct labeling.
> 
> We don't necessarily want a regular shell session for the user to be able to 
> edit some of the config files, but they have to be able to get access to them 
> when necessary.  Also we don't want to accidentally lose the correct types on 
> such files either through system relabeling or through user error.

True - that could be a pain to maintain.

> For POP and SSL I think that we want to have a proxy that runs in a different 
> domain so it can access the config files, the proxy will start the connection 
> to the server.  In the case of POP a file handle could be passed back to the 
> calling application, in the case of SSL all data would have to be proxied.

The problem with proxy's is ensuring that only the right clients access
them - how can that be checked?

> 
> > It strikes me that normal users of a system might want to have multiple
> > contexts to them within a windowing system; for example with seperate
> > permissions for normal stuff, a web browser, the web browser they use
> > for confidential stuff, and building things they downloaded.
> 
> There are some difficulties with this.  Mozilla 1.6 seems to want to access 
> files all over the user's home directory.  Lots of gconf sub-dirs etc.  
> Getting the labelling on all those sub-directories and files correct is 
> difficult, and any mistakes will result in Mozilla aborting without 
> displaying an error!

Sigh yes - although there is no excuse for applications not displaying
decent errors.

> Work is being done on Security Enhanced X.  This will make it possible to give 
> different X clients different levels of access to the display (a 
> pre-requisite for any serious control of graphical programs).  I'm not sure 
> whether SE-X will support distinguishing between multiple copies of an 
> application that have different contexts.  Even when those problems are 
> solved we are still left with the situation that Mozilla checks for other 
> copies of itself and aborts if it finds any.

Thats quite interesting; because I do worry about apps stealing selected
text or producing fake dialogs.  Another example (easier to deal with
using less exotic tools) is stopping accidental pasting of confidential
info into some windows (e.g. many people worry about accidentally
pasting things into irc or chat windows).

> The problem for KDE is that programs are not exec'd, they are mmap'd into a 
> running process, so domain_auto_trans() does not work for Konqueror!

Sigh - that really isn't going to make it easy to control; a pity really
because bits of KDE are quite nice - but if it can't be made secure then
its future will be limited.

> > Is it easy to set such a system up?  What about allowing normal users
> > to see the policy violations that are causing their individual programs
> > are making?
> 
> This is not really possible at the moment.  Allowing all users to see all 
> messages is easy but usually not desirable.  Writing a program to sort 
> through the syslogd output and make some of the messages involving a user's 
> account available to them would be possible, but no-one has worked on it 
> AFAIK.

Hmm doesn't sound that hard to do.

Well I've created a new issue in the OpenOffice database
(http://qa.openoffice.org/issues/show_bug.cgi?id=25503)
suggesting splitting the config/options out into a separate binary.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
