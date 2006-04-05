Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k35F4ns4024610
	for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2006 11:04:49 -0400
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k35F31ua023409
	for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2006 15:03:01 GMT
Message-ID: <4433DC6D.9020209@tresys.com>
Date: Wed, 05 Apr 2006 11:04:13 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Erich Schubert <erich@debian.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: VPN module
References: <1144238374.19128.11.camel@wintermute.xmldesign.de> <1144248600.12875.2.camel@sgc.columbia.tresys.com>
In-Reply-To: <1144248600.12875.2.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-04-05 at 13:59 +0200, Erich Schubert wrote:
>> Hi,
>> I'll probably write a OpenVPN module sometime soon.
>> We already have a "vpn" module, but that is only for the vpnc client so
>> far.
>> Should I
>> - try to make a single module for both (I consider that a bad idea,
>> since vpnc is a client only for cisco VPNs, whereas OpenVPN can be used
>> as a full-blown VPN server and is much more flexible)
>> - rename the vpn policy to vpnc and make a new "openvpn" module?
> 
> Creating openvpn will be fine, but the vpn module has to stay as is,
> because we can't rename modules, because it causes upgrade issues.  For
> example, if you have a vpn module inserted, and you try to insert vpnc
> module, it fails because of duplicate symbols.  Perhaps we need support
> in modules for one module to deprecate another, so if you insert the
> vpnc module, libsemanage automatically removes vpn as part of the
> transaction.
> 

I think this is a package manager issue, not a module issue. Package 
managers already know how to handle complex relationships and I don't 
know why we would reproduce that in libsemanage.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
