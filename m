From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, Bill Laut <wlsel@verizon.net>
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Date: Fri, 1 Aug 2003 01:26:58 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil> <200307301803.29302.wlsel@verizon.net> <20030731044521.H13872@lemuria.org>
In-Reply-To: <20030731044521.H13872@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308010126.58444.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 31 Jul 2003 12:45, Tom wrote:
> On Wed, Jul 30, 2003 at 06:03:29PM -0400, Bill Laut wrote:
> > This leads me to the question:  While considerable work has been done to
> > protect the system from server app compromises, what about protecting the
> > system from server-based buffer overrun attacks on clients running under
> > SELinux?
>
> Some work has been done in this area. Russell wrote a policy for an irc
> client as an example. It should be easy to write one for a mailer along
> those lines.

Not that easy.

Using IRC without X access is no great hardship, while using a text based MUA 
loses significant functionality.  X is currently the main area that SE Linux 
does not address yet.

A mail client wants to access mail files under the user's home directory, this 
means that the files in question need a separate type as you don't want the 
mail client to access all the other files in the home directory.  This gives 
the usual issues of mv followed by file creation giving a different type and 
preventing things working in a way that novice users can't debug...

The mail client needs to be able to save files (easily managed) and to invoke 
the web browser and other programs (which may be more difficult).

Finally if using kmail then you have to deal with the kdeinit method of 
program launch...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
