Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k78IwWw1009769
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 14:58:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k78IwNvS025997
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 18:58:24 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k78IwVlG025181
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 14:58:31 -0400
Message-ID: <44D8DED5.4040304@redhat.com>
Date: Tue, 08 Aug 2006 14:58:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Meyering <meyering@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: re: id -Z subsumed by secon?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>
> James Antill <james.antill@redhat.com> wrote:
>   
>> >  No, what Steven was saying is that the label for execcon will be reset
>> > on exec (after doing it's thing). To see this visually use "secon
>> > --self-exec" instead of id.
>> >
>> > % secon
>> > user: user_u
>>     
> ...
>
> Thanks for the example.
>
> By the way, doesn't secon make id's -Z option unnecessary?
> I'm planning not to include the 'id -Z' patches upstream,
> Instead, runcon (with neither CONTEXT nor COMMAND) will
> print the current security context -- to be analogous to how nice(1)
> works if you don't give it a command.
>
> Any objection?
>
>
>   
Yes I would like to maintain the idea of "-Z" being the way to view 
contexts.  This makes it easy for
a user to figure out how to see what context is being used.  ls -Z, ps 
-Z, netstat -Z ...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
