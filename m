Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OKK1Fm009927
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 16:20:01 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OKK0SG016809
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 20:20:00 GMT
Received: by wr-out-0506.google.com with SMTP id q50so2035872wrq
        for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 13:20:00 -0700 (PDT)
Message-ID: <462E666D.30303@gmail.com>
Date: Tue, 24 Apr 2007 15:19:57 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
Subject: Re: directory polyinstantiation failure
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com> <46252BB5.1070407@us.ibm.com> <cadfc0e40704180959i4aad6211r6b66d1433c69a1ee@mail.gmail.com> <200704241906.55645.russell@coker.com.au>
In-Reply-To: <200704241906.55645.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Thursday 19 April 2007 02:59, "Xavier Toth" <txtoth@gmail.com> wrote:
>   
>> Why if getexeccon fails doesn't it make sense to polyinstantiate based
>> on context/level? Why not call getcon lf getexeccon fails and use that
>> context instead of switching the method?
>>     
>
> That depends on the aim of the PI.
>
> If the aim is merely to isolate the session from other sessions then it's 
> probably OK to skip the things that don't change (although this optimisation 
> doesn't seem to give any benefit).
>
> If the aim is to give each session a PI directory that matches it's context 
> such that any other session which is established with the same context will 
> have the same directory then all items have to be used.
>
> Also while on the topic, we need an option to do PI based on the GID as well 
> (this was requested on a few occasions when I gave talks about it).  So we 
> could have configuration options to specify a list of items to use, the full 
> SE Linux context, the MLS/MCS level, the role, the Linux UID, and the Linux 
> GID.
>
>   
One of the enhancements I've thinking about would be to allow for a user 
defined method for naming instead of the fixed naming of the current 
implementation. There could be expandable terms like USER, CONTEXT, 
LEVEL, UID, GID, HASH, ROLE which could be used to format the name to be 
generated. For example :
/tmp/foo    /tmp/foo.inst     $LEVEL_$USER   root


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
