Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <Pine.LNX.4.64.0609270853420.12766@d.namei>
References: <36282A1733C57546BE392885C061859201573917@chaos.tcs.tcs-sec.com>
	 <Pine.LNX.4.64.0609261835060.5342@d.namei>
	 <1159357078.32075.20.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0609270853420.12766@d.namei>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 09:29:21 -0400
Message-Id: <1159363761.32075.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-27 at 08:59 -0400, James Morris wrote:
> Certainly, changing the iptables target names would be highly intrusive.  
> 
> And for internal labeling only, it still seems correct to me that packets 
> are being labeled.

Yes, I don't see any real reason to rename them.

> > > > On the http clients and the postgres server, you would define the
> > > > httpd server peer and the postges client peer respectively, if they
> > > > are SELinux machines that is.
> > > > 
> > > > On the http server, you would additionally have rules to allow other
> > > > client labels such as:
> > > > 
> > > > allow firefox_t http_client_t:peer { equiv/from/flow_in }
> > > > allow rss_aggregator_t http_client_t:peer { equiv/from/flow_in }
> > > 
> > > I don't think this is helping with usability.  I'm not even sure what the 
> > > above means.
> 
> The above still hasn't been addressed.  I understood the earlier flow 
> permissions, but what is equiv and from?

My impression was that he was just offering up alternative names for the
flow_in permission.  Which likewise doesn't really need to be renamed.

In short, nothing really changes from the earlier secid reconciliation
patches except for dealing with your earlier comments.  And then we also
need the other patches mentioned in that thread, like labeling the SAs
from the socket rather than the spd so that we no longer need per-domain
spd rules, and setting the peer sid on TCP sockets to the reconciled
secmark.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
