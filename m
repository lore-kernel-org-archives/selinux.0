Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Date: Thu, 31 Jul 2003 12:26:14 -0400
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil> <20030731044521.H13872@lemuria.org> <200308010126.58444.russell@coker.com.au>
In-Reply-To: <200308010126.58444.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200307311226.14299.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 31 July 2003 11:26 am, Russell Coker wrote:
> On Thu, 31 Jul 2003 12:45, Tom wrote:
> > On Wed, Jul 30, 2003 at 06:03:29PM -0400, Bill Laut wrote:
> > > This leads me to the question:  While considerable work has been done
> > > to protect the system from server app compromises, what about
> > > protecting the system from server-based buffer overrun attacks on
> > > clients running under SELinux?
> >
> > Some work has been done in this area. Russell wrote a policy for an irc
> > client as an example. It should be easy to write one for a mailer along
> > those lines.
>
> Not that easy.
>
> Using IRC without X access is no great hardship, while using a text based
> MUA loses significant functionality.  X is currently the main area that SE
> Linux does not address yet.
>

And, IMO, one of the greater dangers since it is/can be installed with 
privilege, so that a latent buffer overrun exploit there could allow an 
attacker unrestrained write access to the kernel itself.

>
> A mail client wants to access mail files under the user's home directory,
> this means that the files in question need a separate type as you don't
> want the mail client to access all the other files in the home directory. 
> This gives the usual issues of mv followed by file creation giving a
> different type and preventing things working in a way that novice users
> can't debug...
>

Or, perhaps, what is needed all along is a security-aware mail client that's 
been properly designed and tested against buffer overruns, so that it can 
specify the type for the files it creates/maintains while at least attempting 
to protect itself from being compromised by an exploit, along with existing 
files being properly relabeled.

>
> The mail client needs to be able to save files (easily managed) and to
> invoke the web browser and other programs (which may be more difficult).
>

Hmm.  This one needs to be thought about...

<tom@lemuria.org> wrote:
>>
>> Finally if using kmail then you have to deal with the kdeinit method of
>> program launch...
>>
>
> I smell an SEKDE project on the horizon.
>

I'm hearing the sound of Pandora's Box opening that I just opened... :-)

>
> From what I've seen, KDE is
> way too integrated with itself to behave nicely with SE without changes 
> in the KDE code itself.
>

I've been looking for an excuse to learn the internals of KDE, so it looks 
like I've found one.  Perhaps the first thing to do is tackle X before going 
after KDE?

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
