From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>, SELinux@tycho.nsa.gov
Subject: Re: Of applications and separating configuration systems
Date: Sat, 14 Feb 2004 15:21:49 +1100
References: <20040214000922.GA1083@gallifrey>
In-Reply-To: <20040214000922.GA1083@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402141521.49027.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Feb 2004 11:09, "Dr. David Alan Gilbert" <gilbertd@treblig.org> 
wrote:
>   Having started looking at SELinux a thought struck me.
> As a general matter of practice wouldn't it be better for desktop
> like applications to have the preference editing done by a separate
> program (binary) whose only job is to edit those preferences and
> configurations.

I agree.  However there is the issue of maintaining correct labeling.

We don't necessarily want a regular shell session for the user to be able to 
edit some of the config files, but they have to be able to get access to them 
when necessary.  Also we don't want to accidentally lose the correct types on 
such files either through system relabeling or through user error.

> The thought is bought about by hearing of some of the viruses/worms that
> have happened where a virus has disabled some of the other security
> features in an app.    If the main app that was exposed to user
> data couldn't alter its own preferences file then this risk
> would be greatly reduced.

True.  Also we want to protect files that contain private keys for SSL and 
other encryption systems, and public keys for remote servers as used for 
verifying SSL connections etc.  Then there are files containing passwords 
such as the config of every MUA which uses POP.

For POP and SSL I think that we want to have a proxy that runs in a different 
domain so it can access the config files, the proxy will start the connection 
to the server.  In the case of POP a file handle could be passed back to the 
calling application, in the case of SSL all data would have to be proxied.

> It strikes me that normal users of a system might want to have multiple
> contexts to them within a windowing system; for example with seperate
> permissions for normal stuff, a web browser, the web browser they use
> for confidential stuff, and building things they downloaded.

There are some difficulties with this.  Mozilla 1.6 seems to want to access 
files all over the user's home directory.  Lots of gconf sub-dirs etc.  
Getting the labelling on all those sub-directories and files correct is 
difficult, and any mistakes will result in Mozilla aborting without 
displaying an error!

Work is being done on Security Enhanced X.  This will make it possible to give 
different X clients different levels of access to the display (a 
pre-requisite for any serious control of graphical programs).  I'm not sure 
whether SE-X will support distinguishing between multiple copies of an 
application that have different contexts.  Even when those problems are 
solved we are still left with the situation that Mozilla checks for other 
copies of itself and aborts if it finds any.

The problem for KDE is that programs are not exec'd, they are mmap'd into a 
running process, so domain_auto_trans() does not work for Konqueror!

> Is it easy to set such a system up?  What about allowing normal users
> to see the policy violations that are causing their individual programs
> are making?

This is not really possible at the moment.  Allowing all users to see all 
messages is easy but usually not desirable.  Writing a program to sort 
through the syslogd output and make some of the messages involving a user's 
account available to them would be possible, but no-one has worked on it 
AFAIK.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
