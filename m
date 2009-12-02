Subject: Re: [PATCH] Dynamic port labeling V2
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>,
        russell@coker.com.au, selinux@tycho.nsa.gov,
        LSM <linux-security-module@vger.kernel.org>
In-Reply-To: <4B15FE89.5000208@schaufler-ca.com>
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4B14A111.2000703@schaufler-ca.com>
	 <1259679974.2365.29.camel@moss-terrapins.epoch.ncsc.mil>
	 <200912020450.28965.russell@coker.com.au>
	 <1259694891.2277.4.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4B159C82.6090408@redhat.com>
	 <1259708829.8497.22.camel@moss-terrapins.epoch.ncsc.mil>
	 <4B15FE89.5000208@schaufler-ca.com>
Content-Type: text/plain
Date: Wed, 02 Dec 2009 16:52:21 -0500
Message-Id: <1259790741.8497.53.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-12-01 at 21:43 -0800, Casey Schaufler wrote:
> >
> > also what happens when other transport protocols come around like sctp
> > for instance. now we need another 65k files for this as well.
> >
> >   
> 
> Ok, so it would appear that the notion of a fully populated
> portfs has sufficient stumbling blocks to make it a non-starter.
> 
> A dynamically maintained version, with default values for unallocated
> ports and memory based xattrs stored on request would still be viable.
> 
> Yes, it's more work. I'd rather see a generally useful scheme than an
> SELinux specific one, if for no other reason than it makes the general
> case harder to sell later on.
> 
> > Dave
> >
> >
> > --

You still need to address my issue with port ranges. Also I don't find
this interface generically useful when you have to have intimate
knowledge of the LSM to know what the correct xattrs to set are. You
pointed it out yourself that Smack handles port labeling differently
than SELinux so to try to shoe horn every LSM that labels ports into a
filesystem interface where the user has to know LSM specific xattrs to
set doesn't seem generic to me.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
