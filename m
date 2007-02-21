Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1L0SPoj020234
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 19:28:25 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1L0TfFm013808
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 00:29:42 GMT
Date: Tue, 20 Feb 2007 18:27:27 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
Message-ID: <20070221002727.GB9827@w-m-p.com>
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com> <20070219031951.GA9827@w-m-p.com> <45DB4F07.9040607@trustedcs.com> <45DB79DB.3080209@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45DB79DB.3080209@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 20, 2007 at 04:44:43PM -0600, Darrel Goeddel wrote:
> Darrel Goeddel wrote:
> >Klaus Weidner wrote:
> >+	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
> 
> First a question about something that is already upstream - the
> mlsrangedobject portion of the constraint?  Should that line read: 
>
> "( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( l1 domby h2 )) or"?
>
> Currently a process operating at SECRET, but with a clearance of
> SYSTEMHIGH could not write to a "mlsrangedobject" ranged from
> UNCLASSIFIED to TOP SECRET because the ( h1 domby h2 ) check would
> fail.  Since the process is operating at SECRET, shouldn't the access
> be granted?

Yes you are right, that was a mistake and is unnecessarily restrictive.
The check should be as you suggest (using "l1 domby h2"). Sorry about
that, and thank you for reviewing the changes. Do you want to merge that
change or do you want me to send a patch? 

> >+# Directory "write" ops
> > mlsconstrain dir { add_name remove_name reparent rmdir }
> >-	((( l1 dom l2 ) and ( l1 domby h2 )) or
> >+	(( l1 eq l2 ) or
> >+	 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 
> >)) or
> > 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) 
> > 	 or
> > 	 ( t1 == mlsfilewrite ) or
> > 	 ( t2 == mlstrustedobject ));
> 
> The mlsrangedobject and mlswfilewriteinrange seem to be providing about
> the same functionality (unless I'm missing something regarding the
> comment above).  Why have a subject based override a few dir ops and an
> object based override for most other file (in the general sense) ops?
> I would think that these two constraint block should be identical, as
> they used to be.  The only reason they were ever separated is due to
> the fact that directories had operations other file classes did not
> have.  Maybe have both overrides (subject and object) available and
> make these two block match up?

The first patch I had sent renamed the existing "mlsfilewriteinrange"
object based override to "mlsrangedobject" to match the naming
conventions used for other object overrides, they are supposed to be the
same thing. Apparently that patch was rejected upstream, which
contributed to the confusion. They are supposed to be the same thing.

> Like this (ignoring my first question about the h1 in the mlsrangedobject 
> line):
> 	(( l1 eq l2 ) or
> 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) 
> 	 or
> 	 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 
> 	 )) or
> 	 ( t1 == mlsfilewrite ) or
> 	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
> 	 ( t2 == mlstrustedobject ));

I'm not aware that mlsfilewriteinrange is used for both subject and
object properties - this is confusing. I don't have a strong opinion
about what the attribute is named and how it is used as long as the
permission check doesn't allow ranged writes without an override.

> >+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket 
> >packet_socket key_socket unix_stream_socket unix_dgram_socket 
> >netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket 
> >netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket 
> >netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { accept 
> >connect }
> >+	(( l1 eq l2 ) or
> >+	 (((( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> >+	   ( t1 == mlsnetread )) and
> >+	  ((( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 
> >)) or
> >+	   (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 
> >)) or
> >+	   ( t1 == mlsnetwrite ))));
> 
> The above can be accomplished by placing both accept and connect in the
> read and write constraints below.  That way things wouldn't get out of
> sync if the definition of the read or write constraint changes.

Sure, that is fine with me if the resulting policy is equivalent, and
sounds cleaner.

> >@@ -274,7 +289,8 @@
> > 
> > # the netif/node "write" ops (implicit single level socket doing the 
> > write)
> > mlsconstrain { netif node } { tcp_send udp_send rawip_send }
> >-	(( l1 dom l2 ) and ( l1 domby h2 ));
> >+	(( l1 eq l2 ) or
> >+	(( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));
> 
> We may like a mlsnetwrite override here as well.  I'll have to dig into it 
> a bit more (or pick other brains :)) to figure out if we need it given the
> state of the networking code.  Someone will follow up when after further
> investigation.

In general adding additional overrides is fine, the point of the changes
was to make sure that users who don't have additional privileges get
the expected results.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
