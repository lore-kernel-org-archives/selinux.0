From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: ipsec and getpeercon()
Date: Mon, 4 Sep 2006 23:50:04 -0400
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov
References: <36282A1733C57546BE392885C061859201512D0F@chaos.tcs.tcs-sec.com> <44F85481.80203@hp.com> <1157374764.6716.14.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157374764.6716.14.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200609042350.05828.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 04 September 2006 8:59 am, Joshua Brindle wrote:
> On Fri, 2006-09-01 at 11:40 -0400, Paul Moore wrote:
> > Joshua Brindle wrote:
> > > Hrm, am I right in understanding that the selinux context from one
> > > machine is never sent over ipsec to the destination?
> > >
> > > What you talk about above (using static SA's which refer to different
> > > contexts on each side) is doable but seems inconvenient and fragile
> > > (multiple client domains talking to the same destination daemon using
> > > lots of SA's that have to be managed).
> > >
> > > One option (maybe) is to get racoon to send the context of the
> > > connecting domain as part of the negotiation, this still requires lots
> > > of SA's.
> > >
> > > Another way is if I could have a local proxy that has a single SA to
> > > the destination machine and can send an appropriate context in the AH
> > > or ESP header (in the authentication data field? I don't now the ipsec
> > > spec at all so I'm not sure if any of this is possible, please let me
> > > know if not so I can start looking elsewhere).
> > >
> > > Note that we may be sending contexts that aren't even valid on the
> > > local machine, but would be valid on the destination machine.
> > >
> > > is any of this possible?
> >
> > WARNING: *shameless* plug ahead, read at your own risk :)
> >
> > NetLabel takes it's security context directly from the socket which is
> > writing the data to the network, not from a separate source.  This
> > allows for the dynamic context packet labeling I think you are looking
> > for ... yes?
> >
> > However, in the interest of full disclosure I should point out that
> > currently NetLabel only supports the MLS label portion of the context
> > but I plan on extending that in the future.  Also, NetLabel only offers
> > packet labeling, not packet autentication or encryption like IPsec.
> > However, NetLabel could be used in conjunction with regular IPsec
> > without problems.  This would allow you a dynamically labeled, secure
> > connection between two parties with as few SAs as you desire.
>
> Yes, I have considered NetLabel, contingent on it getting merged into
> mainline and supporting full contexts. I've been looking in to the specs
> and it looks like you are going to have to make an entirely new tag for
> full contexts. This will eliminate its ability to communicate with tsol,
> et al right? (unless you change the netlabel policy obviously, I mean by
> default).

The good news it that the NetLabel patches have been picked up by David Miller 
in his net-2.6.19 git tree.  Baring any major problems I think this means 
it's stands a good chance for 2.6.19.

You are correct that the CIPSO spec only defines tags which are useful for 
sending MLS labels but as James Morris' selopt implementation demonstrated it 
is possibile to extend CIPSO using the FIPS 188 freefrom (#7) tag.  There may 
also be other options to labeling packets with a full SELinux context but I 
haven't had much time to look into them yet.  Regardless, it's important to 
note the adding this functionality would not in any way eliminate the ability 
to communicate with other MLS implementations through CIPSO (or other 
explicit labeling protocols supported by NetLabel).  NetLabel supports the 
ability to specify labeling protocols per-domain; meaning each LSM/SELinux 
domain could be configured to either send traditional MLS CIPSO labels, new 
full SELinux context labels, or plain 'ole unlabeled traffic.

Look at the "map" commands for netlabelctl for more details on how to do this.

> It also looks like the tags currently use bitmaps (which is fair since
> levels are better represented that way) but for full contexts we'd want
> just a u32 right? (u32 is used in the sidtab so a machine can't have
> more contexts than that active).

Using the existing MLS tags defined in the CIPSO draft the (I'm going from 
memory here, I don't have a copy of the draft in front of me) MLS sensitivity 
level is an 8 bit value while the categories can be defined in a variety of 
ways including a 240 bit bitmap (all Linux supports right now) and a 16 bit 
value.

In order to get around these limitations the Linux CIPSO implementation 
supports multiple CIPSO Domains Of Interpretations (DOI) which can be 
configured on a per-domain basis, each DOI having the ability to "translate" 
MLS values between local and remote hosts.  Please see the NetLabel kernel 
documentation and the netlabel_tools documentation for more details.

 * kernel-*/Documentation/netlabel
 * http://netlabel.sf.net

> I'm just thinking out loud here.. are there plans at HP to support full
> contexts or is this more of a 'someone might do this in the future and
> it should work' thing?

There are several things I would like to add to NetLabel, full SELinux 
contexts are very close to the top of the list.  However, right now my focus 
is getting the NetLabel patch into a mainline kernel with enough support so 
that we can interoperate with other MLS operating systems.  Without 
CIPSO/NetLabel we don't have any sort of interoperable labeled networking so 
this seemed to be the most significant task.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
