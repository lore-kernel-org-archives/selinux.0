Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4GBfMA028221
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 11:11:41 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA4G5aqq022476
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 16:05:42 GMT
Message-ID: <436B86DE.4090207@redhat.com>
Date: Fri, 04 Nov 2005 11:05:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use	libsemanage
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu> <1131118753.23420.270.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131118753.23420.270.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-11-04 at 00:55 -0500, Ivan Gyurdiev wrote:
>   
>> - always return -1 on failure. I highly dislike any creativity with the 
>> return value.
>>     
>
> Hmmm...so the 'ret' value is now unused, but those error codes were
> being propagated all the way up to the exit status of the program.  So
> this constitutes an "interface change".  Question is whether any caller
> was using those individual ret values for any purpose - Dan?  Does
> system-config-securitylevel distinguish error codes from setsebool?
>
>   
Nope it is ignored.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
