Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28467
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 10:18:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA14081
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:17:31 GMT
Received: from mail.ispko.com ([210.16.10.89])
	by jazzswing.ncsc.mil  with ESMTP id OAA14077
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:17:29 GMT
Message-ID: <3D2AF096.6090702@evoworks.evoserve.com>
Date: Tue, 09 Jul 2002 22:17:58 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: automatic type transitions for pts in devfs
References: <Pine.GSO.4.33.0207091003250.27193-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 9 Jul 2002, Debian User wrote:
>
>  
>
>>Are all the stuff involved in this restricted to hooks.c?
>>    
>>
>
>You can implement a quick-and-dirty solution entirely by modifying
>hooks.c.  A more general solution will require changes to the security
>server and the policy configuration to support such hybrid schemes.
>  
>
I will try the quick and dirty solution. I have an idea where to look. I 
just read some papers and its very enlightening. It looks  like i need 
to wrap the present set of nested ifs with another that tests some 
variables to get inode properly labeled.

>  
>
>>Im afraid im not familiar with lsm. I have
>>to look for an introduction somewhere.
>>    
>>
>
>lsm.immunix.org has some documentation about LSM.  The NSA SELinux site
>has a technical report describing the implementation of the LSM-based
>SELinux module, although it is not entirely up-to-date.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>  
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
