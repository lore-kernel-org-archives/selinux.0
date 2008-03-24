Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OLtVmE023169
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 17:55:31 -0400
Received: from web36614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m2OLtU6X016102
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 21:55:30 GMT
Date: Mon, 24 Mar 2008 13:55:27 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [Fwd: Re: Removing DAC.]
To: rmeijer@xs4all.nl, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <19871.82.95.100.23.1206384558.squirrel@webmail.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <978172.60552.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Rob Meijer <capibara@xs4all.nl> wrote:

> ---------------------------- Original Message ----------------------------
> Subject: Re: Removing DAC.
> From:    "Rob Meijer" <capibara@xs4all.nl>
> Date:    Mon, March 24, 2008 19:48
> To:      casey@schaufler-ca.com
> --------------------------------------------------------------------------
> 
> On Sun, March 23, 2008 18:25, Casey Schaufler wrote:
> >
> > --- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:
> >
> >> Hi,
> >>
> >> Is there any way to avoid o remove DAC controls ? I'd like to have only
> >> one
> >> security scheme in my system. I mean a pure SElinux system. not DAC +
> >> MAC.
> >> only MAC.
> >
> > No.
> >
> > Well, not today.
> 
> If performance isn't a main issue, the loopback userspace filesystem
> approach may be appropriate. I use this approach to implement a crude
> object capability like DAC implementation replacing 'normal' DAC in my
> MinorFs project.
> 
> This same approach should work even simpler for MAC, just create a simple
> loopback filesystem that simply ignores all DAC.

Simple for you or me, but creating a new filesystem is a bit much
for the common programmer.

> > The LSM, which is the interface that SELinux uses to plug into
> > the rest of the kernel is explicity designed to allow additional
> > restrictions but not replacement or override of existing
> > restrictions. In the early days of LSM both restrictive models,
> > like what we have today, and authoritiative models, which would
> > allow replacement of traditional DAC where considered. The
> > authoritative model was rejected based on how easy it would be
> > for proprietary modules that had nothing to do with security to
> > exploit the interface.
> 
> If permissive (ocap) model would have been used, this would not need to be
> a valid assumption. It seems to me that layering traditional DAC or a
> restrictive model on top of an ocap model would be very much possible,
> while layering a permissive (either the normal DAC or ocap based DAC) on
> top of a restrictive model would not at all seem possible. IMHO a very bad
> choice has been made and it is apparently way to late now to ever dream of
> turning it back, so both people wanting to use MAC and people who rather
> use the ocap version of DAC are at best stuck with either using two
> partially conflicting models, or with using performance poor hacks like
> the loopback fs I described above.

Yes, I still cling to my convictions that an authoritative model
is better, but as I'm reminded on a regular basis, it's still got
to play in Peoria. I think that there is some improvement to be
had by separating the privilege and access control vectors, but
that's going to take a little time to get right, and may run up
against the same objections as an authoritative LSM did all those
years ago.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
