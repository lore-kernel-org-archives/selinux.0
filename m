Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LHvUmK020334
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 12:57:30 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1LHwkMh022230
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 17:58:47 GMT
Message-ID: <45DC8833.50503@trustedcs.com>
Date: Wed, 21 Feb 2007 11:58:11 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com> <20070219031951.GA9827@w-m-p.com> <45DB4F07.9040607@trustedcs.com> <45DB79DB.3080209@trustedcs.com> <20070221002727.GB9827@w-m-p.com>
In-Reply-To: <20070221002727.GB9827@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Tue, Feb 20, 2007 at 04:44:43PM -0600, Darrel Goeddel wrote:
>> Darrel Goeddel wrote:
>>> Klaus Weidner wrote:
>>> +# Directory "write" ops
>>> mlsconstrain dir { add_name remove_name reparent rmdir }
>>> -	((( l1 dom l2 ) and ( l1 domby h2 )) or
>>> +	(( l1 eq l2 ) or
>>> +	 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 
>>> )) or
>>> 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) 
>>> 	 or
>>> 	 ( t1 == mlsfilewrite ) or
>>> 	 ( t2 == mlstrustedobject ));
>> The mlsrangedobject and mlswfilewriteinrange seem to be providing about
>> the same functionality (unless I'm missing something regarding the
>> comment above).  Why have a subject based override a few dir ops and an
>> object based override for most other file (in the general sense) ops?
>> I would think that these two constraint block should be identical, as
>> they used to be.  The only reason they were ever separated is due to
>> the fact that directories had operations other file classes did not
>> have.  Maybe have both overrides (subject and object) available and
>> make these two block match up?
> 
> The first patch I had sent renamed the existing "mlsfilewriteinrange"
> object based override to "mlsrangedobject" to match the naming
> conventions used for other object overrides, they are supposed to be the
> same thing. Apparently that patch was rejected upstream, which
> contributed to the confusion. They are supposed to be the same thing.
> 
>> Like this (ignoring my first question about the h1 in the mlsrangedobject 
>> line):
>> 	(( l1 eq l2 ) or
>> 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) 
>> 	 or
>> 	 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 
>> 	 )) or
>> 	 ( t1 == mlsfilewrite ) or
>> 	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
>> 	 ( t2 == mlstrustedobject ));
> 
> I'm not aware that mlsfilewriteinrange is used for both subject and
> object properties - this is confusing. I don't have a strong opinion
> about what the attribute is named and how it is used as long as the
> permission check doesn't allow ranged writes without an override.

The subject based override should be mlsfilewriteinrange and the object based
override should be mlsrangedobject, as they are.  I was just wondering if there
was a need for both.  I'm fine with having the extra flexibility of both the
subject based override and the object based override.

So... Do we agree that the block of constraints in question (the "big" file
write block and the extra directory operation block) should read should be:

(( l1 eq l2 ) or
 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 ( t1 == mlsfilewrite ) or
 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 ( t2 == mlstrustedobject ));

>>> @@ -274,7 +289,8 @@
>>>
>>> # the netif/node "write" ops (implicit single level socket doing the 
>>> write)
>>> mlsconstrain { netif node } { tcp_send udp_send rawip_send }
>>> -	(( l1 dom l2 ) and ( l1 domby h2 ));
>>> +	(( l1 eq l2 ) or
>>> +	(( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));
>> We may like a mlsnetwrite override here as well.  I'll have to dig into it 
>> a bit more (or pick other brains :)) to figure out if we need it given the
>> state of the networking code.  Someone will follow up when after further
>> investigation.
> 
> In general adding additional overrides is fine, the point of the changes
> was to make sure that users who don't have additional privileges get
> the expected results.

I'll let you know what we come up with on the possibility of the extra
override on the netif/node constraint.

I stuck what I think the mls file should look like here:

http://home.insightbb.com/~dgoeddel/policy/mls

I can give patches against svn or the rhel policy if you need.  Just let
me know.  It would probably be easiest if you could roll this into the big
patch for upstream (assuming everyone approves).  Otherwise I could make a
follow-on patch after the currently proposed changed are handled by Chris.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
