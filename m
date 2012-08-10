From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: A filename to label translation daemon
Date: Fri, 10 Aug 2012 12:28:11 +1000
Cc: Colin Walters <walters@verbum.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, lennart@poettering.net, sds@tycho.nsa.gov
References: <1344454290.25533.12.camel@localhost> <201208100037.21877.russell@coker.com.au> <5023EE1C.5060205@redhat.com>
In-Reply-To: <5023EE1C.5060205@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201208101228.11637.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Aug 2012, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On 08/09/2012 10:37 AM, Russell Coker wrote:
> > On Thu, 9 Aug 2012, Colin Walters <walters@verbum.org> wrote:
> >> Seems to make sense...though someone could also probably get fairly far
> >> by writing a regular expression optimizer.  It might not even be that
> >> hard to write a multi-regexp matching engine which took a set of regexps
> >> at once and constructed a single matching DFA for them.
> > 
> > Is this really going to help?  My slowest system is a P3-866 which takes
> > less than 30ms of user time for "restorecon /bin/bash" and takes a total
> > of 136ms of wall time if the cache is cold.  On a 1.8GHz 64bit system
> > it's only 8ms of user time.
> > 
> > What benefit are we expecting to get here?
> 
> kerberos library currently does a matchpathcon on /tmp/BLAH files and sets
> the label correctly.  With this change in the library we are seeing huge
> performance hits of apache services caused by loading the regex.

What is kerberos doing under /tmp and why is it being done repeatedly by 
different processes?

> Running make install has caused a huge hit if you are running thousands of
> install commands which caused the remove of labeling from the install
> command.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638304

I believe that is a design bug in the SE Linux code in install, I've filed the 
above Debian bug report about it.

I think that correct design of install wouldn't have a "make install" 
performed as part of a dpkg or rpm build do any SE Linux checks.  That would 
be faster than any other option.

> Systemd has been is executing the load load many many times and is showing
> up to 1 second slow down on startup.  If the startup is 10 seconds, it is
> kind of hard to justify 10% slowdown on boot.

Wow, who's got a 10 second boot?

Is systemd loading the file contexts 100 times?  If not then why is it taking 
a second?

> I believe we just add support for this service and have the labeling fall
> back to the default if the labeling socket does not exists, and then
> distributions can decide whether or not they want to use it.

I'm not opposed to making such changes and a 10% performance improvement is 
definitely worth getting.  But first I think we should consider other 
approaches to some of these issues such as changing the way install works.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
