Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OCDx9V028146
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 08:13:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2OCDwaU011690
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 12:13:58 GMT
Message-ID: <47E79AC2.8040606@manicmethod.com>
Date: Mon, 24 Mar 2008 08:12:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: cinthya aranguren <cinthya.aranguren@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Removing DAC.
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com> <200803240934.16380.russell@coker.com.au>
In-Reply-To: <200803240934.16380.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Monday 24 March 2008 02:54, "cinthya aranguren" 
> <cinthya.aranguren@gmail.com> wrote:
>   
>> Is there any way to avoid o remove DAC controls ? I'd like to have only one
>> security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
>> only MAC.
>>     
>
> Back in about 2003 as an experiment I changed the ownership of all files on a 
> SE Linux strict system to root and changed the permission to 777.  It didn't 
> work very well.  One problem was that many programs rely on the Unix 
>   

Right, that wouldn't work well because it would deteriorate, programs 
set umasks when making files, etc. Just ignoring the bits would probably 
work alot better :)

> permissions to identify the difference between a configuration file and a 
> shell script.  In directories such as /etc there is not sufficiently 
> fine-grained SE Linux labelling to replace this use of Unix permissions.
>
>   

Why does that matter? /etc is read only for the vast majority of 
processes and anything with passwords, etc in them should have their own 
labels.

> It's possible that in the last 5 years things have changed significantly, but 
> my last experiments showed enough obstacles to make me not want to bother 
> going further with it.
>
>   

we certainly have alot more types today, I'm not sure if that was the 
real obstacle though.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
