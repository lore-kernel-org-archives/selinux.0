Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6LHu9vT010522
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 13:56:09 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6LHtkQq007695
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 17:55:46 GMT
Message-ID: <4A66012E.60801@manicmethod.com>
Date: Tue, 21 Jul 2009 13:55:58 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Christopher Pardy <cpardy@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: adding human understandable, and translatable description support
 to selinux
References: <4A648075.3090402@redhat.com> <1248110839.23783.721.camel@gorn>	 <4A64ADA3.6020105@redhat.com> <1248114027.23783.725.camel@gorn> <4A64B6D4.6070205@redhat.com>
In-Reply-To: <4A64B6D4.6070205@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher Pardy wrote:
>> Did you forget to do reply to all?
>>
>
> yes!
>
> If that's the best way to go fine, however the xml file is only
> generated when I acutually compile the modules if I install a module
> through semanage any data that module adds will be left out. I
> certainly wouldn't be opposed to extending policy.xml as part of this
> but there needs to be a way for installed modules to work too.
> Additionally if we're going to continue the trend of using policy.xml
> for management rather than development we really should move it.
>

One of the things that we want CIL to do is have the ability to embed 
documentation for purposes such as debugging into the language. This would allow 
the documentation to make it all the way into the module store and would be 
retrievable by tools.

For reference we started talking about CIL here:
http://marc.info/?l=selinux&m=124784581623125&w=2

though we haven't gotten very far in the discussion.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
