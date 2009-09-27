Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8RFEFL9000378
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 11:14:15 -0400
Received: from mail-yw0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8RFFjgg004112
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 15:15:45 GMT
Received: by ywh40 with SMTP id 40so4016309ywh.32
        for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 08:14:14 -0700 (PDT)
Message-ID: <4ABF8148.4010108@gmail.com>
Date: Sun, 27 Sep 2009 08:14:16 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: pam_namespace context inside of name.inst
References: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com> <20090927131307.GA4502@notebook2.grift.internal>
In-Reply-To: <20090927131307.GA4502@notebook2.grift.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Sat, Sep 26, 2009 at 11:12:20PM -0700, Justin Mattock wrote:
>    
>> I'm going crazy over here trying to figure
>> out how one system created a context inside
>> name.inst one way and another for the other system:
>>
>> the first system has inside of
>> name.inst:
>> system_u:object_r:file_t_name
>>      
>
> This is wrong because the fs wasnt labelled properly
>    
That's what I figured,(this is the system that I did not label
before turning on namespace).
>> and on the other system I have:
>>
>> name:object_r:user_home_dir_t_name
>>      
>
> This is right
>    
This is from the system that was labeled before turning on namespace.
>    
>> the only difference with the machines is one machine
>> had not been labeled yet, before turning on namespace.
>>
>> what should be the right context directory inside of
>> name.inst?
>>      
>
> Depends, i think theres 3 different possibilities (not sure)
>
> first theres only name (no selinux) which create a dir with the user name
> second is context which create a dir with the context of the usre home dir (user_home_dir_t and appends the user name
> third is level , which creates a dir with the context of the user home dir and appends the username and also appends the level of the dir.
>
>    
>> -- 
>> Justin P. Mattock
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>      
So either you can use(name,context,level) or (meth=1,2,3)?
(I'm wondering if this is all I need to configure)

Anyways what's getting me is after the initial loading
of namespace, the directory is created with the context
(namespace.conf is set to it's default).
Then after wards I haven't found a way to change that directory
(besides using mv, or cp)from what it is(*file_t) to
the correct context(*home_dir_t)

if I delete that directory, then logout/in namespace does not
create another. Is there a way to reset namespace and start fresh
since I messed up and turned on namespace before labeling my filesystem,
causing it to somehow be stuck with the wrong labeled context?

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
