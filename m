From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Subject: Re: Of applications and separating configuration systems
Date: Mon, 16 Feb 2004 11:45:42 +1100
Cc: SELinux@tycho.nsa.gov
References: <20040214000922.GA1083@gallifrey> <200402141521.49027.russell@coker.com.au> <20040215202727.GG1083@gallifrey>
In-Reply-To: <20040215202727.GG1083@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402161145.42664.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Feb 2004 07:27, "Dr. David Alan Gilbert" <gilbertd@treblig.org> 
wrote:
> > For POP and SSL I think that we want to have a proxy that runs in a
> > different domain so it can access the config files, the proxy will start
> > the connection to the server.  In the case of POP a file handle could be
> > passed back to the calling application, in the case of SSL all data would
> > have to be proxied.
>
> The problem with proxy's is ensuring that only the right clients access
> them - how can that be checked?

That depends on the application.  For Apache we can have something like the 
following:
domain_auto_trans(httpd_t, ssl_proxy_exec_t, httpd_ssl_t)
allow httpd_ssl_t httpd_private_key_t:file { getattr read };

For user-space proxies it gets more difficult.  For a proxy for POP 
connections we could have the MUA running in it's own domain.  Or we could 
just accept that some programs could make unauthorised POP connections but 
that as they can't steal the password it's less of a concern.

> > Work is being done on Security Enhanced X.  This will make it possible to
> > give different X clients different levels of access to the display (a
> > pre-requisite for any serious control of graphical programs).  I'm not
> > sure whether SE-X will support distinguishing between multiple copies of
> > an application that have different contexts.  Even when those problems
> > are solved we are still left with the situation that Mozilla checks for
> > other copies of itself and aborts if it finds any.
>
> Thats quite interesting; because I do worry about apps stealing selected
> text or producing fake dialogs.  Another example (easier to deal with
> using less exotic tools) is stopping accidental pasting of confidential
> info into some windows (e.g. many people worry about accidentally
> pasting things into irc or chat windows).

Many people do accidentally paste passwords in IRC, you see it happen all the 
time.

I believe that SE-X will also control the clipboard and stop accidental 
pasting into the wrong window.

> > The problem for KDE is that programs are not exec'd, they are mmap'd into
> > a running process, so domain_auto_trans() does not work for Konqueror!
>
> Sigh - that really isn't going to make it easy to control; a pity really
> because bits of KDE are quite nice - but if it can't be made secure then
> its future will be limited.

It wouldn't be THAT difficult to change the code in question and spend a few 
hours recompiling it...

> > > Is it easy to set such a system up?  What about allowing normal users
> > > to see the policy violations that are causing their individual programs
> > > are making?
> >
> > This is not really possible at the moment.  Allowing all users to see all
> > messages is easy but usually not desirable.  Writing a program to sort
> > through the syslogd output and make some of the messages involving a
> > user's account available to them would be possible, but no-one has worked
> > on it AFAIK.
>
> Hmm doesn't sound that hard to do.
>
> Well I've created a new issue in the OpenOffice database
> (http://qa.openoffice.org/issues/show_bug.cgi?id=25503)
> suggesting splitting the config/options out into a separate binary.

Great!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
