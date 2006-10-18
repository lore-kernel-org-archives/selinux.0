Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9IE8etP002329
	for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2006 10:08:40 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9IE7HcJ001808
	for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2006 14:07:17 GMT
In-Reply-To: <1161177780.30986.32.camel@twoface.columbia.tresys.com>
References: <000301c6f12f$c4958cd0$cc0a010a@tcssec.com> <1161177780.30986.32.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17C4F745-4DDF-435A-A4DC-6EE5D8F310B1@nall.com>
Cc: vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: SELinux Networking Enhancements
Date: Wed, 18 Oct 2006 09:08:07 -0500
To: Joshua Brindle <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 18, 2006, at 8:23 AM, Joshua Brindle wrote:

> On Mon, 2006-10-16 at 09:31 -0500, Venkat Yekkirala wrote:
>> Agreed. But I fail to see where having a "default" peer on a  
>> netfilter
>> rule/secpoint
>> would hurt. FYI- this is how MLS implementations work. You have an  
>> interface
>> that you would label everything coming thru by default with "Secret".
>>
>
> first, getpeercon() returning something that isn't an external  
> label is
> not good, how are applications to cope with this behavior?
>
> Second, MLS implementations work this way because they are hard coded
> to. We aren't hard coded to do anything, there is no "default" in this
> case, you'd have to specify defaults with iptables and I question how
> scalable that is anyway. You either have really course grained  
> secmarks
> (one per interface with 1 type and an MLS range) or if you start
> breaking it down into protocol, port, etc you have a full set for  
> every
> interface with a different type and the mls range. There doesn't  
> seem to
> be alot of flexibility here.

When we hook up to a WAN in a data center that connects to an allied
network full of Windows boxes, the whole WAN has a sensitivity label,
regardless of the port/protocol. Setting the interface to a particular
SL is a simple way to ensure that we don't make the mistake of
sending inappropriate data to that interface.

It also matches the 'real world' in that the installation guidance is
'the cables with the read/black stripes on the connector are S/REL XXX.'

That said, given the limited number of ports/protocols allowed in these
cases, writing a script to generate policy/iptables setups on a per
interface basis should not be too difficult.

I'm much more concerned about not having the capability at all right  
now :(

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
