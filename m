Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m26ErU6P026503
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 09:53:30 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m26ErQwu015042
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 14:53:26 GMT
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ronald van den Blink <selinux@a61.nl>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
Message-Id: <ED83C068-55BF-4E28-A7EC-F5EFE20AA2C4@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47CFFD4F.4000706@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Unreserved portnumbers in corenetwork
Date: Thu, 6 Mar 2008 08:46:44 -0600
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>	 <1204730645.14217.39.camel@gorn>	 <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>	 <1204733123.14217.48.camel@gorn>	 <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>	 <1204735380.14217.60.camel@gorn>	 <6507AB86-A6D5-4314-BC06-86458D15C786@a61.nl> <47CF034E.2010407@redhat.com> <1204749406.1397.136.camel@moss-spartans.epoch.ncsc.mil> <47CF1616.1010201@redhat.com> <C5C7FABD-BA26-403D-82D2-8F5066620298@nall.com> <47CFFD4F.4000706@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 6, 2008, at 8:18 AM, Daniel J Walsh wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Joe Nall wrote:
>> Why not just decouple the ports from the application by giving them
>> names like port8080_t? This would allow multiple policies to be  
>> written
>> to manage that resource, only one of which should be active at a  
>> time.
>> I think the real issue is the assumption that only one application  
>> will
>> own ports like 80, 8080, 443 and 8443.
>>
>> joe
> I think the problem here is 65000 types.


I was not suggesting preassigning all 65k ports by number, although  
the auto decl trick used to generate the mls sensitivities could do it  
in a few lines, but just to those ports which have many uses in the  
real world.

In the current fedora policy, the http related ports are all enumerated

find . -name \*.te -exec grep portcon {} /dev/null \; | grep http
./modules/kernel/corenetwork.te:portcon tcp 3128  
gen_context(system_u:object_r:http_cache_port_t,s0)
./modules/kernel/corenetwork.te:portcon udp 3130  
gen_context(system_u:object_r:http_cache_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 8080  
gen_context(system_u:object_r:http_cache_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 8118  
gen_context(system_u:object_r:http_cache_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 80  
gen_context(system_u:object_r:http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 443  
gen_context(system_u:object_r:http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 488  
gen_context(system_u:object_r:http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 8008  
gen_context(system_u:object_r:http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 8009  
gen_context(system_u:object_r:http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 8443  
gen_context(system_u:object_r:http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 5988  
gen_context(system_u:object_r:pegasus_http_port_t,s0)
./modules/kernel/corenetwork.te:portcon tcp 5989  
gen_context(system_u:object_r:pegasus_https_port_t,s0)

The problem with 443 and 8443 being the same type is that they are  
often used by different applications on the same machine (httpd,  
tomcat) with different security requirements. 8080 and 8443 are very  
often the same application(JBoss, tomcat), but have different port  
types.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
