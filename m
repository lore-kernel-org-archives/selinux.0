From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: netlabel: UNLABELED ath9k not denying unlabeled traffic
Date: Wed, 14 Jan 2009 12:43:32 -0500
Cc: "Justin P. Mattock" <justinmattock@gmail.com>,
        "SE-Linux" <selinux@tycho.nsa.gov>
References: <496D759A.7010401@gmail.com> <200901141205.26904.paul.moore@hp.com> <1231953881.31192.43.camel@localhost.localdomain>
In-Reply-To: <1231953881.31192.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901141243.32962.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 14 January 2009 12:24:41 pm Stephen Smalley wrote:
> On Wed, 2009-01-14 at 12:05 -0500, Paul Moore wrote:
> > On Wednesday 14 January 2009 11:15:46 am Justin P. Mattock wrote:
> > > Paul Moore wrote:
> > > > On Wednesday 14 January 2009 12:18:18 am Justin P. Mattock 
wrote:
> > > >> When using netlabelctl on a dell laptop
> > > >> I'm able to define the addresses that I want:
> > > >>
> > > >> netlabelctl unlbl add interface:wlan0 address:<radiostation>
> > > >> label:system_u:object_r:netlabel_peer_t:s0
> > > >> netlabelctl unlbl add interface:wlan0 address:<myaddress>
> > > >> label:system_u:object_r:netlabel_peer_t:s0
> > > >> netlabelctl  -p unlbl accept off
> > > >>
> > > >> {the above was from http://paulmoore.livejournal.com/1758.html
> > > >> };
> >
> > ...
> >
> > > >> (I'm able to listen to the radio station allowed, then if I
> > > >> choose another station; if I haven't defined an address like
> > > >> the above, mplayer just sits there.denying the unlabeled
> > > >> packet. that is until I allow the address);
> > > >> The problem I have is when I do the same on my macbook pro ati
> > > >> chipset. with the ath9k module, I'm able to listen to any
> > > >> station, search the web etc..
> > > >> it seems netlabelctl  -p unlbl accept off makes no difference
> > > >> if it's on or off.
> > > >>
> > > >> Is this built into ath9k yet, or is there something I'm
> > > >> missing?
> > > >
> > > > That is just plain odd, there isn't really anything that is
> > > > driver specific.  Can you share any more details like kernel
> > > > version, netlabel_tools verion, distro, etc?  I don't have any
> > > > ath9k hardware lying around to test so I would appreciate
> > > > whatever additional information you can provide.
> > >
> > > Hey alright.(I finally got around to  trying netlabelctl out!).
> >
> > It's pretty cool.  In newer versions of netlabelctl I added an
> > undocumented option to actually allow it to fix a sandwhich and do
> > the dishes afterwards.  The exact command line option needed is
> > left as an exercise for the reader :)
>
> I hope it doesn't run afoul of this patent:
> http://www.wipo.int/pctdb/en/wo.jsp?IA=US2005044838&WO=2006068865&DIS
>PLAY=STATUS

Sigh.  I fear that it may, guess I'll have to pull feature from the next 
release :(  What am I going to do for lunch now! 

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
