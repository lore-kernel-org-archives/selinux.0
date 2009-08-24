Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7OD4r54003562
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 09:04:53 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7OD4Ikb002814
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 13:04:19 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7OD4p0p017754
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 09:04:51 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7OD4pKX032243
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 09:04:51 -0400
Message-ID: <4A928FF2.7000101@redhat.com>
Date: Mon, 24 Aug 2009 09:04:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Semodule syntax is broken.
References: <4A8EC2F9.3040707@redhat.com>	<87eir5rv3e.fsf@anzu.internal.golden-gryphon.com>	<4A8EDE77.3050003@redhat.com> <87ocq834vt.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87ocq834vt.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/21/2009 11:27 PM, Manoj Srivastava wrote:
> On Fri, Aug 21 2009, Daniel J Walsh wrote:
> 
> 
>> So proposal
>>
>> semodule -r : No Change in default behaviour
>> 	 -F : Permanantly removes policy package, leaving POLICY.exclude
>> 	      flag in module store 
>>
>> semodule -u : Install if package not installed, upgrade otherwise)
>> semodule -f : Only upgrade modules that are currently installed)
>> semodule -i : No change.
>> 	All will get a warning message if a module they are trying to
>> 	install has a POLICY.exclude flag 
>>          -q : Shut up Warning messages
>>          -F : Remove POLICY.exclude flag and install the package
> 
>         Sounds good to me.
> 
>         manoj
After talking to Chris P, on IRC, I have rethought these changes.   He mentioned that they are looking into "disabling" modules.  So I think we should follow that line of thinking.

semodule -r (--remove) : No Change in default behaviour
semodule -u (--upgrade): Install if package not installed, upgrade otherwise)
semodule -f (--freshen): Only upgrade modules that are currently installed)
semodule -i (--install): No change.
semodule -q (--quier): Shut up Warning messages
semodule -d (--disable) : Disable policy module, Store policy module as POLICY.pp.disabled in /etc/selinux/TYPE/modules/active/modules
semodule -e (--enable) : Rename POLICY.pp.disabled to POLICY.pp and rebuild

libsemanage would then not build policy modules that were disabled.  It would look for POLICY.pp.disabled when installing or upgrading modules and maintain the name.  --remove would remove both disabled, and enabled modules.  List would now list the disabled modules with a flag indicating they are disabled. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
