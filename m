Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59H4WDM015677
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 13:04:33 -0400
Received: from ppsw-5.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59H4Viw005256
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 17:04:31 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:37399)
	by ppsw-5.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.135]:25)
	with esmtp id 1K5knD-0000Jo-Ip (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Mon, 09 Jun 2008 18:04:27 +0100
Message-ID: <484D6297.1030702@martinorr.name>
Date: Mon, 09 Jun 2008 18:04:23 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] /usr/lib32 type
References: <484A8A15.9000507@martinorr.name> <1213016083.28428.9.camel@gorn>
In-Reply-To: <1213016083.28428.9.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/06/08 13:54, Christopher J. PeBenito wrote:
> On Sat, 2008-06-07 at 14:16 +0100, Martin Orr wrote:
>> On a 64-bit Debian system, /usr/lib32 is a symlink to
>> /emul/ia32-linux/usr/lib.  It should be labelled as lib_t.
>>
>> I don't know if the distro_debian is necessary - take it out if you want.
> 
> Actually what seems excessive is the (.*/)? in the middle.  Is it really
> needed?  Its very broad, and doesn't sound like its needed.

I probably copied it from the lines above.  And in fact given the -l, there
is not much point in the (/.*)? at the end either.

Best wishes,
Martin

>> plain text document attachment (116_usr_lib32)
>> Written by: Martin Orr
>>
>> Mark /usr/lib32 as type lib_t
>>
>> Index: policy/modules/system/libraries.fc
>> ===================================================================
>> --- policy/modules/system/libraries.fc.orig
>> +++ policy/modules/system/libraries.fc
>> @@ -110,6 +110,9 @@
>>  
>>  /usr/(.*/)?lib(/.*)?				gen_context(system_u:object_r:lib_t,s0)
>>  /usr/(.*/)?lib64(/.*)?				gen_context(system_u:object_r:lib_t,s0)
>> +ifdef(`distro_debian',`
>> +	/usr/(.*/)?lib32(/.*)?		-l	gen_context(system_u:object_r:lib_t,s0)
>> +')
>>  
>>  /usr/(.*/)?lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:object_r:ld_so_t,s0)
>>  


-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
