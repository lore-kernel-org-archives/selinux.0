From: Paul Moore <paul@paul-moore.com>
To: vlad halilov <vlad.halilov@gmail.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: network, deep drive
Date: Tue, 21 May 2013 17:50:18 -0400
Message-ID: <1900232.vJ9DK3UHW4@sifl>
In-Reply-To: <CAHw9pMXbShFc9SPf-gD9baPn3Bq98_jfMyVS3B1WijcOyF5nyg@mail.gmail.com>
References: <CAHw9pMUEcHa_HExVs+yyJOVk8oVEkQ84o4aywemZ+ZvMYT0=LA@mail.gmail.com> <2466345.2mjuuyBiSJ@sifl> <CAHw9pMXbShFc9SPf-gD9baPn3Bq98_jfMyVS3B1WijcOyF5nyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 21, 2013 11:26:55 PM vlad halilov wrote:
> > A few comments on your configuration below ...
> > 
> > > netlabelctl unlbl add interface:eth0 address:0.0.0.0/0
> > > 
> > >       label:system_u:object_r:node_t:s1
> > > 
> > > netlabelctl unlbl add interface:eth0
> > > 
> > >       address:192.168.1.196/0 label:system_u:object_r:node_t:s4
> > 
> > Generally node_t is used for network nodes while netif_t is used for
> > interfaces.  I would recommend changing from "node_t:s1" to "netif_t:s1"
> > and "node_t:s4" to "netif_t:s4".
> 
> Ok, i note that. Btw, is this reference is actual
> http://marc.info/?l=selinux&m=119991234501200&w=2 ?

Yes, that information should still be correct.

> Selinux extremaly need faq/best practice network guide. It's absence cause a
> basic error in network configuration like mine . Just audit2allow recommend
> to allow that, that that and that - so we just do it, don't think what and
> for what...

Yes, we do need better/proper documentation, there have been some efforts but 
they could use some additional information/help.  This has been on my todo 
list for some time, but sadly other things keep stealing priority.
 
> > > 3) telnet from external network (system_u:object_r:node_t:s1)
> > > established, but only one way (s1 -> s4). On trying to send string back
> > > from nc to telnet and got connection closed... that's right from one
> > > side of view but no deny avc in audit. Dontaudit rules disabled. One
> > > strange.
> > 
> > I assume that the external network/host is unlabeled and you are using the
> > static/fallback labeling to label the incoming traffic?  If so, could you
> > first correct your static/fallback configuration (see above) and try
> > again?
> 
> I changed type to netif_t and that avc found in audit:
> 
> type=AVC msg=audit(1369158708.220:821): avc:  denied  { write } for 
> pid=2440 comm="nc" path="socket:[19743]" dev=sockfs ino=19743
> scontext=user_u:user_r:user_t:s4 tcontext=user_u:user_r:user_t:s1
> tclass=tcp_socket
> 
> You right, i connected from unlabeled network from address with :s4 label,
> and used only static/fallback. So, now that look right. :s4 can not write
> to socket that connected to :s1 endpoint and avc present. Reverse channel
> s1->s4 is allowed.

Looking at the AVC denial messages is always the best way to understand the 
problem; there is a lot of good information in those denial messages.

> > > 4) telnet from same host but user context is ' user_u:user_r:user_t:s1'
> > > to 127.0.0.1 or 192.168.1.96 - timed out... hmm.. that's strange. All
> > > needed selinux context is allowed (or we got deny on step 1, but why we
> > > got different result withing step 3? So, second issue.
> > 
> > Any AVC denials?
> 
> Yeah, that it:
> 
> type=AVC msg=audit(1369160107.877:926): avc:  denied  { recv } for 
> saddr=127.0.0.1 src=5000 daddr=127.0.0.1 dest=39019 netif=lo
> scontext=user_u:user_r:user_t:s1
> tcontext=system_u:object_r:netlabel_peer_t:s4 tclass=peer
> 
> audit2allow make a rule:
> ------------------------------------------------------------------
> module netlabpeer 1.0;
> 
> require {
>         type netlabel_peer_t;
>         type user_t;
>         class peer recv;
> }
> 
> #============= user_t ==============
> #!!!! This avc is a constraint violation.  You will need to add an attribute
> to either the source or target type to make it work. #Contraint rule:
> allow user_t netlabel_peer_t:peer recv;
> ------------------------------------------------------------------
> 
> That look right (i see  warning of course, but not sure what it sign) but
> selinux have own point of view, and deny avc repeated in audit.. Early, i
> think that deny caused by 's1->s4' connection, but i have established
> channel with permissive mode, after that switch selinux to enforcing and
> got result like (3 - one way channel). So, this rule is realy constraint
> violation and telnet can't establish connection by disallowed context
> access, not a label ...

The problem is that a user_t:s1 process/socket can not receive 
netlabel_peer_t:s4 network traffic; since the problem is a constraint 
violation we know it is not a type enforcement problem, e.g. user_t not being 
able to receive netlabel_peer_t traffic, but rather a MLS problem, e.g. s1 not 
being able to receive s4 traffic.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
