Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7OKJL2F022927
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 16:19:21 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7OKIlkS010090
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 20:18:47 GMT
Date: Mon, 24 Aug 2009 16:19:20 -0400
Subject: Re: Semodule syntax is broken.
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Message-ID: <C6B86E08.AA01D%csellers@tresys.com>
In-Reply-To: <4A928FF2.7000101@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/24/09 9:04 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 08/21/2009 11:27 PM, Manoj Srivastava wrote:
>> On Fri, Aug 21 2009, Daniel J Walsh wrote:
>> 
>> 
>>> So proposal
>>> 
>>> semodule -r : No Change in default behaviour
>>> -F : Permanantly removes policy package, leaving POLICY.exclude
>>>      flag in module store
>>> 
>>> semodule -u : Install if package not installed, upgrade otherwise)
>>> semodule -f : Only upgrade modules that are currently installed)
>>> semodule -i : No change.
>>> All will get a warning message if a module they are trying to
>>> install has a POLICY.exclude flag
>>>          -q : Shut up Warning messages
>>>          -F : Remove POLICY.exclude flag and install the package
>> 
>>         Sounds good to me.
>> 
>>         manoj
> After talking to Chris P, on IRC, I have rethought these changes.   He
> mentioned that they are looking into "disabling" modules.  So I think we
> should follow that line of thinking.
> 
> semodule -r (--remove) : No Change in default behaviour
> semodule -u (--upgrade): Install if package not installed, upgrade otherwise)
> semodule -f (--freshen): Only upgrade modules that are currently installed)
> semodule -i (--install): No change.
> semodule -q (--quier): Shut up Warning messages
> semodule -d (--disable) : Disable policy module, Store policy module as
> POLICY.pp.disabled in /etc/selinux/TYPE/modules/active/modules
> semodule -e (--enable) : Rename POLICY.pp.disabled to POLICY.pp and rebuild
> 
> libsemanage would then not build policy modules that were disabled.  It would
> look for POLICY.pp.disabled when installing or upgrading modules and maintain
> the name.  --remove would remove both disabled, and enabled modules.  List
> would now list the disabled modules with a flag indicating they are disabled.
> 
I like this idea very much, as -u has always bothered me. So, this looks
good to me, though it's a bit odd to add features to semodule while at the
same time working to deprecate it in favor of everything going through
semanage.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
