Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RGbUNs026406
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:37:30 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RGW9cJ021293
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 16:32:09 GMT
Message-ID: <4339760A.9080300@cornell.edu>
Date: Tue, 27 Sep 2005 12:40:42 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: selinux@tycho.nsa.gov, dwalsh@redhat.com, jbrindle@tresys.com
Subject: Re: [ SEMANAGE ] dbase initialization/semanage_handle stub/fixes
References: <200509271224.j8RCOaYs025773@gotham.columbia.tresys.com>
In-Reply-To: <200509271224.j8RCOaYs025773@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>The patches that I sent out yesterday were not on top of these patches. I
>would be happy to either rebase your patches or give you a hand rebasing
>them. 
>
I will take care of that..

>It looks, however, that you can probably just drop handle.[c,h] in
>favor of semanage.[c,h] and things should work. Let me know.
>  
>
Or...you could drop semanage.[c,h]'s handle functionality in favor of 
handle.[c,h]. I personally like smaller headers, intended to contain one 
thing. Then you can still write the big  umbrella header by including 
others.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
