Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4FSWMA027192
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 10:28:32 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA4FMXqo015273
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 15:22:33 GMT
Message-ID: <436B7FB5.3060800@cornell.edu>
Date: Fri, 04 Nov 2005 10:35:17 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use	libsemanage
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu> <1131116232.23420.245.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131116232.23420.245.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-11-04 at 00:55 -0500, Ivan Gyurdiev wrote:
>   
>> - separate code paths for error and success (don't like fallthrough - 
>> error-prone)
>>     
>
> On this point, please see "Chapter 6:  Centralized exiting of functions"
> in Documentation/CodingStyle in the kernel tree. 
I think it's cleaner when the recovery section is small...
>  Note that in splitting
> the code paths, it looks like you have introduced a memory leak, as you
> no longer free the vallist on the success path?
>
>   
Yes I did :) ...but see - I also got rid of logging code from the error 
path, which didn't belong there - I think this makes the code simpler. 
The common path should not contain large sections of code that are not 
shared with the success path.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
