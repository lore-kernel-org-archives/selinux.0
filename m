Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OI8epD031250
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 14:08:40 -0400
Received: from web36614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2OI8WQR005116
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 18:08:32 GMT
Date: Mon, 24 Mar 2008 11:01:49 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Removing DAC.
To: cinthya aranguren <cinthya.aranguren@gmail.com>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <50771f160803241020q829f988s2c1441ca3fde5032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <170177.38060.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:

> On Sun, Mar 23, 2008 at 2:25 PM, Casey Schaufler <casey@schaufler-ca.com>
> wrote:
> >
> >
> > --- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:
> >
> > > Hi,
> > >
> > > Is there any way to avoid o remove DAC controls ? I'd like to have only
> one
> > > security scheme in my system. I mean a pure SElinux system. not DAC +
> MAC.
> > > only MAC.
> >
> > No.
> >
> > Well, not today.
> >
> > The LSM, which is the interface that SELinux uses to plug into
> > the rest of the kernel is explicity designed to allow additional
> > restrictions but not replacement or override of existing
> > restrictions. In the early days of LSM both restrictive models,
> > like what we have today, and authoritiative models, which would
> > allow replacement of traditional DAC where considered. The
> > authoritative model was rejected based on how easy it would be
> > for proprietary modules that had nothing to do with security to
> > exploit the interface.
> >
> > I am currently putting some work into separating the LSM into
> > a pair of interface sets, one for the privilege model and one
> > for the additional restrictions. Once in place it could be
> > possible to create a privilege scheme that reports to the
> > traditional DAC that everyone has DAC override, and leave it
> > to SELinux (or whatever restrictive model you might prefer)
> > to make the only decision.
> >
> > That work is not done, nor is there any assurance that it
> > might be accepted when it is. Since it would result in a
> > system where the privilege module and the access restriction
> > module could team up to provide an authoritative model
> > it is within reason that the arguments that blocked an
> > authoritative LSM could be raised again with the same result.
> >
> 
> 
> Thanks for the reply...
> 
> Thats means it's imposible to separate DAC from MAC. There is no way
> to have only one security scheme.

That's not quite correct. The problem is that DAC and MAC are separate
and the DAC is not optional, while MAC is optional. You can have only
one security scheme, so long as it is the traditional Linux DAC. You
can impose additional restrictions, such as SELinux or Smack, but you
cannot disregard the mode bits.

> > Now I'll ask the 37 cent question:
> >
> > Why would you want to do that?
> >
> 
> Just because i'm trying to simplify the security management of a linux
> instalation. I'd like to use MAC security,

What are you looking to accomplish by implementing MAC in your
environment? Personally, I don't think you are going to simplify
your security management with SELinux. If you want to simplify
you might think about Smack, which provides a MAC environment
that does not have the overhead of SELinux.

> but i realize  this means still have DAC. I can't get rid of this.

What aspects of the DAC configuration are a problem for you?
You may be able to set up a MAC configuration with Smack or
SELinux that meets your needs.

> I have to admin the DAC burden plus MAC.

Well, again that may depend on how it is that DAC is a burden in
the environment you've created.

> May be I'm thinking in a oversimplified reality.

One of the biggest problems with new security schemes has always
been dealing with programs and people that understand how to
deal with the old schemes and don't want to change. If you're
willing to share a little more about what would make your
set-up easier on you we (the Smack and SELinux teams) may be
able to make seriously helpfull suggestions.

Thank you


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
