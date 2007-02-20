Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KMiBfc017145
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:44:11 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KMjSFm028545
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 22:45:28 GMT
Message-ID: <45DB79DB.3080209@trustedcs.com>
Date: Tue, 20 Feb 2007 16:44:43 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: Klaus Weidner <klaus@atsec.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com> <20070219031951.GA9827@w-m-p.com> <45DB4F07.9040607@trustedcs.com>
In-Reply-To: <45DB4F07.9040607@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Klaus Weidner wrote:
>> On Fri, Feb 16, 2007 at 04:58:21PM -0500, Christopher J. PeBenito wrote:
>>> On Thu, 2007-01-25 at 08:12 -0500, Daniel J Walsh wrote:
>>>> The MLS constraints are really screwed up.  Need to come to some 
>>>> kind of
>>>> agreement between you, klaus and tcs.
>>> I'm not familiar with the LSPP requirements, so its mainly up to Klaus
>>> and the TCS guys to iron out what makes sense.
>>
>> I haven't heard back from TCS about their opinion on this. I would
>> suggest using the constraints as in Dan's policy (and as used in the
>> RHEL5 rc) since those are designed to meet LSPP requirements.
> 
> We (TCS) are checking out the changes now.
> 

> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/mls serefpolicy-2.5.1/policy/mls
> --- nsaserefpolicy/policy/mls	2006-11-16 17:15:26.000000000 -0500
> +++ serefpolicy-2.5.1/policy/mls	2007-01-17 13:32:47.000000000 -0500
> @@ -89,12 +89,14 @@
>  mlsconstrain { file lnk_file fifo_file dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
>  	(( l1 eq l2 ) or
>  	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> -	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
>  	 ( t1 == mlsfilewrite ) or
> +	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
>  	 ( t2 == mlstrustedobject ));
>  
> +# Directory "write" ops
>  mlsconstrain dir { add_name remove_name reparent rmdir }
> -	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
>  	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
>  	 ( t1 == mlsfilewrite ) or
>  	 ( t2 == mlstrustedobject ));

First a question about something that is already upstream - the mlsrangedobject
portion of the constraint?  Should that line read: 
 "( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( l1 domby h2 )) or"?
Currently a process operating at SECRET, but with a clearance of SYSTEMHIGH could
not write to a "mlsrangedobject" ranged from UNCLASSIFIED to TOP SECRET because the
( h1 domby h2 ) check would fail.  Since the process is operating at SECRET,
shouldn't the access be granted?

The mlsrangedobject and mlswfilewriteinrange seem to be providing about the same
functionality (unless I'm missing something regarding the comment above).  Why have
a subject based override a few dir ops and an object based override for most other
file (in the general sense) ops?  I would think that these two constraint block should
be identical, as they used to be.  The only reason they were ever separated is due to
the fact that directories had operations other file classes did not have.  Maybe have
both overrides (subject and object) available and make these two block match up?

Like this (ignoring my first question about the h1 in the mlsrangedobject line):
	(( l1 eq l2 ) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
	 ( t1 == mlsfilewrite ) or
	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
	 ( t2 == mlstrustedobject ));

> @@ -165,8 +167,20 @@
>  mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } relabelto
>  	( h1 dom h2 );
>  
> +# the socket "read+write" ops
> +# (Socket FDs are generally bidirectional, equivalent to open(..., O_RDWR),
> +# require equal levels for unprivileged subjects, or read *and* write overrides)
> +mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { accept connect }
> +	(( l1 eq l2 ) or
> +	 (((( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> +	   ( t1 == mlsnetread )) and
> +	  ((( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
> +	   (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> +	   ( t1 == mlsnetwrite ))));
> +
> +

The above can be accomplished by placing both accept and connect in the read
and write constraints below.  That way things wouldn't get out of sync if the
definition of the read or write constraint changes.

> @@ -274,7 +289,8 @@
>  
>  # the netif/node "write" ops (implicit single level socket doing the write)
>  mlsconstrain { netif node } { tcp_send udp_send rawip_send }
> -	(( l1 dom l2 ) and ( l1 domby h2 ));
> +	(( l1 eq l2 ) or
> +	(( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));

We may like a mlsnetwrite override here as well.  I'll have to dig into it a 
bit more (or pick other brains :)) to figure out if we need it given the
state of the networking code.  Someone will follow up when after further
investigation.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
