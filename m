Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8RCxWT8016603
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 08:59:32 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8RCwxFc005897
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 12:59:00 GMT
Date: Wed, 27 Sep 2006 08:59:29 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
In-Reply-To: <1159357078.32075.20.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0609270853420.12766@d.namei>
References: <36282A1733C57546BE392885C061859201573917@chaos.tcs.tcs-sec.com>
  <Pine.LNX.4.64.0609261835060.5342@d.namei> <1159357078.32075.20.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Sep 2006, Stephen Smalley wrote:

> > This just seems the same as SECMARK and CONNSECMARK but with different 
> > naming.  What problem is this solving?
> 
> The name isn't important (Venkat just views the "secpoint" and "peer"
> names as more intuitive).  The issue is how we label the packets -
> Venkat is assigning labels that correspond to domains (potentially
> generic placeholder domains when we don't actually know a specific one),
> like http_client_t (or mozilla_t) and httpd_t versus object types like
> http_client_packet_t and http_server_packet_t.
> 
> We could leave the secmark and packet names alone.

Certainly, changing the iptables target names would be highly intrusive.  

And for internal labeling only, it still seems correct to me that packets 
are being labeled.

> > > On the http clients and the postgres server, you would define the
> > > httpd server peer and the postges client peer respectively, if they
> > > are SELinux machines that is.
> > > 
> > > On the http server, you would additionally have rules to allow other
> > > client labels such as:
> > > 
> > > allow firefox_t http_client_t:peer { equiv/from/flow_in }
> > > allow rss_aggregator_t http_client_t:peer { equiv/from/flow_in }
> > 
> > I don't think this is helping with usability.  I'm not even sure what the 
> > above means.

The above still hasn't been addressed.  I understood the earlier flow 
permissions, but what is equiv and from?

Please translate the rules into English.

> > > Turns out the "object Type" nature of a packet label doesn't jive
> > > well with the "domain Type" nature of the external labeling mechanisms
> > > that are of interest to us here, apart from the shortcoming of not
> > > being able to handle transient traffic in the forwarding case.
> > 
> > I don't see why the packet can't be thought of as carrying the label of 
> > the originating process.




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
