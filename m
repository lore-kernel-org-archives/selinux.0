Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3CMpRb020769
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 07:22:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB3CMCp5016503
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 12:22:12 GMT
Received: from sornico.zurich.ibm.com (pat.zurich.ibm.com [195.176.20.45])
	by jazzswing.ncsc.mil  with ESMTP id hB3CMCt0016500
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 12:22:12 GMT
Received: from [127.0.0.1] (helo=zurich.ibm.com)
	by sornico.zurich.ibm.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ARW1p-0000XI-00
	for <selinux@tycho.nsa.gov>; Wed, 03 Dec 2003 13:22:49 +0100
Message-ID: <3FCDD599.4090402@zurich.ibm.com>
Date: Wed, 03 Dec 2003 13:22:49 +0100
From: Chris Vanden Berghe <vbc@zurich.ibm.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: selinux-policy-default
References: <3FCC831A.1070002@zurich.ibm.com> <200312030159.41676.russell@coker.com.au> <3FCCAEA2.2040703@zurich.ibm.com> <200312030537.34475.russell@coker.com.au>
In-Reply-To: <200312030537.34475.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>>I don't have '/usr/share/selinux/policy/current/' either, but I do have
>>'/usr/share/selinux/policy/default/'.  Should I link /etc/selinux to
>>this '.../default/' dir?
>>    
>>
>
>No.  Copy what you want from the default directory to the current directory 
>then make a symlink.  Having the symlink point to the default directory won't 
>do any good.
>
Tnx, this worked.

I'd be happy to do some testing if you have a new version of the 
selinux-policy-default package available that addresses this issue.

Cheers,
Chris.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
