Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3REpx1v012229
	for <selinux@tycho.nsa.gov>; Thu, 27 Apr 2006 10:51:59 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3REpwKk008079
	for <selinux@tycho.nsa.gov>; Thu, 27 Apr 2006 14:51:58 GMT
Message-ID: <4450DAAB.3030507@redhat.com>
Date: Thu, 27 Apr 2006 10:52:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Dinardo, Michael \(Xetron\)" <Michael.Dinardo@ngc.com>
CC: Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov
Subject: Re: login error with strict modular ref pol in RHEL4
References: <85A664F2F3F2D1409EE003C7D3D52EE4038A0201@xcgoh901.northgrum.com>
In-Reply-To: <85A664F2F3F2D1409EE003C7D3D52EE4038A0201@xcgoh901.northgrum.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dinardo, Michael (Xetron) wrote:
>   
>> -----Original Message-----
>> From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu] 
>> Sent: Wednesday, April 26, 2006 4:19 PM
>> To: Dinardo, Michael (Xetron)
>> Cc: Daniel J Walsh; selinux@tycho.nsa.gov
>> Subject: Re: login error with strict modular ref pol in RHEL4 
>>
>> On Wed, 26 Apr 2006 15:58:55 EDT, "Dinardo, Michael (Xetron)" said:
>>
>>     
>>> 1. Installed the following (along with all other tools at
>>> ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR/i386/):
>>> 	selinux-policy-2.2.28-1.rhel4.src.rpm
>>> 	selinux-policy-2.2.28-1.rhel4.noarch.rpm
>>> 	selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm
>>> 2. Installed the source from /usr/src/redhat:
>>> 	rpmbuild -bp /usr/src/redhat/SPECS/selinux-policy.spec
>>> 	cd /usr/src/redhat/BUILD/serefpolicy-2.2.23
>>> 	make install-src
>>>       
>> Umm.. why are you installing a 2.2.23 policy like this, when 
>> you just downloaded 2.2.28?  Why isn't the 2.2.28-1 RPM 
>> installable as is, and what problems are you setting yourself 
>> up for by doing this behind RPM's back?
>>     
>
> Nice catch.  My mistake.  I reinstalled using 2.2.28.  However, I can no
> longer log in at all again. 
>
>   
>>> 4. Renamed /etc/selinux/targeted to /etc/selinux/strict
>>>       
>> No good can come from this.  Especially since rpm thinks the 
>> 2.2.28.1 strict policy is installed....
>>     
>
> I have to agree.  However, when I install 2.2.28-1 source it gets
> installed in /etc/selinux/refpolicy/src.  Nothing else is installed in
> this directory.  In /etc/selinux/targeted there are subdirectories for
> contexts, modules, policy, etc.  Since I don't have a strict policy I am
> using targeted directory to get these other components.  I would
> definitely prefer to have a strict policy directory to put the source
> into as I believe this may be related to my current trouble.  Is there
> an appropriate strict reference policy that I could install first?
>
>    
>
>   
I am confused.  What are you trying to do?  Please join me on the 
#selinux chat room and maybe we can work through this.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
