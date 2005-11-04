Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4Fa6MA027316
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 10:36:06 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA4FU6qq016319
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 15:30:08 GMT
Message-ID: <436B8185.4050508@cornell.edu>
Date: Fri, 04 Nov 2005 10:43:01 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use	libsemanage
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu> <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-11-04 at 00:55 -0500, Ivan Gyurdiev wrote:
>   
>> - cleanup warnings exposed by -Werror in new Makefile
>>     
>
> Hmm...there was no Makefile in your patch for setsebool (previously
> covered by the generic utils Makefile in libselinux), so I adapted the
> one from semodule, and also added setsebool to the SUBDIRS list in the
> top-level policycoreutils Makefile.
>   
Allright, thank you. Yes, --exclude tends to have some undesired effects...

So, now that this is taken care of:

TODO:
- optimize commit in various ways - do not do unnecessary work, disable 
checking as you mentioned, move seuser validation inside the section 
where policydb doesn't have to be re-read back in
- more seuser validation (MLS fields not currently validated)
- fix ports, and enable those
- reduce error message verbosity (do not blindly print the call stack - 
report only info that adds value)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
