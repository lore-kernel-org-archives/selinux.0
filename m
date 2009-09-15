Subject: Re: [PATCH] libsepol/checkpolicy: Add support for multiple target
 OSes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: pjnuzzi <pjnuzzi@tycho.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <1252956835.13634.1048.camel@moss-pluto.epoch.ncsc.mil>
References: <1252934558.2379.14.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4AAE945B.2020009@manicmethod.com>
	 <1252956835.13634.1048.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 09:07:40 -0400
Message-Id: <1253020060.13634.1080.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-14 at 15:33 -0400, Stephen Smalley wrote:
> On Mon, 2009-09-14 at 15:07 -0400, Joshua Brindle wrote:
> > On 09/14/2009 09:22 AM, pjnuzzi wrote:
> > > Add support for multiple target OSes to libsepol and checkpolicy, where
> > >    
> > 
> > what about checkmodule?
> 
> At present, the patch only deals with monolithic policy. To update for
> modular policy, we'd need to introduce multiple string identifiers in
> the modular format as well.  Which could be done, but I'm not sure it is
> worthwhile given plans for replacing the module format.  The other
> option is to select the output target platform in libsemanage via
> semanage.conf configuration rather than embedding the target in the
> modules.
> 
> > > the particular target OS is selected using a new -t target option to
> > > checkpolicy.  The default target remains SELinux.  A new target and
> > > support is introduced for Xen.  The target OS is identified in the
> > > policy image by using different policy string identifiers in the header.
> > > At present, policy string identifiers are required to have the same
> > > length for ease of parsing the header and to preserve file(1) parsing of
> > >    
> > 
> > That is not the case today. Does file really not have the ability to 
> > read a length and then a string of that length?
> 
> I'm not sure what you mean by "not the case today".  The current
> libsepol code does require a specific length and won't even try to read
> the string if the length does not match the expected value, and the
> existing /usr/share/magic definition for file(1) parsing expects fixed
> offsets for the fields after the string identifier.  We could certainly
> relax that requirement, but then we'd have to update /usr/share/magic
> everywhere.  That seemed unnecessary - a string of 8 characters is
> sufficient to identify the full range of possible target OSes.

Ah, actually, I see that the patch doesn't handle the modular policy
case correctly there.  So we'll re-spin the patch and loosen the fixed
length restriction in our code, even though I expect we'll keep it in
practice due to existing /usr/share/magic definitions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
