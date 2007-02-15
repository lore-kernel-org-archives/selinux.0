From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: su and context
Date: Thu, 15 Feb 2007 18:43:48 +1100
Cc: Ronan Waide <waider@amazon.com>, selinux@tycho.nsa.gov
References: <45CDEDEE.4050205@gmail.com> <1171301899.20328.29.camel@waider.desktop.amazon.com> <1171303155.24318.12.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1171303155.24318.12.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702151843.50749.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 13 February 2007 04:59, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On the subject of interaction between "old" and "new" security, I was
> > briefly stumped in my quest to create a bind role account by the fact
> > that the rndc binary (on FC6) is not actually executable by anyone other
> > than root, so granting rndc_exec_t doesn't help unless you also change
> > the binary's permissions. Is this intentional? I had hoped that SELinux
> > rather than the filesystem would be taken as authoritative on who gets
> > access, but I can see reasons why this maybe shouldn't be the case, and
> > perhaps the 'bug' is with the installed permissions?
>
> It is intentional; we didn't want SELinux to expose the system to
> greater risk, so it only further restricts access (and that is

As a tangent to this, you should be able to just use chown and chmod to make 
rndc usable by non-root.  rndc in recent versions of bind just seems to need 
to read the key file - which could be made readable by non-root.

Also with the strict policy you can have root as a non-privileged account 
(although this is not recommended in most situations).

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
