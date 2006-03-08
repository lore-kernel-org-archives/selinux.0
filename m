Message-ID: <440EEEBA.20809@tresys.com>
Date: Wed, 08 Mar 2006 09:48:26 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, "Serge E. Hallyn" <serue@us.ibm.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol/src/link.c:copy_avrule_list( )
References: <20060306214139.GA7960@sergelap.austin.ibm.com>	 <440CE892.2060601@cornell.edu>	 <1141826701.6157.51.camel@moss-spartans.epoch.ncsc.mil>	 <440EE4A8.2070700@cornell.edu> <1141828815.6157.68.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141828815.6157.68.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-03-08 at 09:05 -0500, Ivan Gyurdiev wrote:
>>> What is your test case (i.e. what policy)?
>>>   
>> Fedora strict. I don't remember this happening under targeted.
> 
> Ok, reproduced it, and it seems to be resolved by the patch I posted.
> Joshua, do you concur with the patch?
> 

Yes, that does look right. I hadn't had time to look at that bug but it 
looks pretty straightforward.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
