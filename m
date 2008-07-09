Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m69IOkBp010659
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 14:24:46 -0400
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m69IOj8w000874
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 18:24:46 GMT
Received: by el-out-1112.google.com with SMTP id y26so504435ele.21
        for <selinux@tycho.nsa.gov>; Wed, 09 Jul 2008 11:24:45 -0700 (PDT)
Message-ID: <4875026A.3040104@gmail.com>
Date: Wed, 09 Jul 2008 13:24:42 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Subject: Re: newrole assertion - should be gnome-terminal assertion
References: <cadfc0e40807081202l7badbcb8h84ee373161fd6fd2@mail.gmail.com> <1215617024.24864.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1215617024.24864.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-07-08 at 14:02 -0500, Xavier Toth wrote:
>   
>> Using MLS enforcing in a gnome-terminal with context
>> user_u:user_r:user_t:s0-s15:c0.c1023 I run newrole and get these
>> results
>>
>> newrole -l s1-s1 -- -c "gnome-terminal --disable-factory"
>> Password:
>> **
>> ** ERROR:(terminal.c:1016):new_terminal_with_options: assertion
>> failed: (profile)
>>
>>
>> I think Joe straced this and has a little more info if he'd like to chime in.
>>     
>
> So, I assume that this does not happen if in permissive mode?
> What AVC denials occur?  Run semodule -DB and retry if there are no AVCs
> by default.
>
> What is the application trying to do at that point (look at the source
> code and/or ask on the gnome lists)?  What are the possible failure
> conditions there?  What external dependencies does it have?  
>
> strace output might help if you have it.
>
>   
Sorry to have bothered you. Looks like it has something to do with 
polyinstantiation of ~/.gnome or ~/.gnome2. We haven't seen this with 
previous versions even when polyinstantiating :(


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
