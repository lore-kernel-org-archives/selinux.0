Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6M2Aj3Y003972
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 22:10:45 -0400
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6M2AiOg029352
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 02:10:44 GMT
Received: by yw-out-1718.google.com with SMTP id 6so620524ywa.84
        for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 19:10:45 -0700 (PDT)
Subject: Re: Setting login context for multiple Linux users using single
	semanage command...
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D04BF2AB9@de01exm68.ds.mot.com>
References: <487F93C3.1040701@redhat.com>  <4880B872.20202@manicmethod.com>
	 <1216402217.17602.324.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D04BF2AB9@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 22:08:55 -0400
Message-Id: <1216692539.17786.28.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-07-21 at 13:41 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> If I wanted to map multiple Linux users (Test1, Test2, and Test3), to a
> single SELinux user (staff_u),
> 
> Can I use a single semanage command to do this, instead of executing
> multiple semanage commands?
> 
> In other words,instead of executing:  
> semanage login -a -s staff_u Test1
> semanage login -a -s staff_u Test2
> semanage login -a -s staff_u Test3
> 
> Can I do something like:   semanage login -a -s staff_u 'Test1 Test2
> Test3'
> 
> Thanks as always for your help,

Abstractly, that would be possible to do, but I doubt the semanage
command today supports that syntax.  The underpinnings of it
(libsemanage) certainly would support applying several changes in the
same transaction, just as you can install multiple policy modules on the
same transaction using semodule.  So I'd call this a deficiency of the
semanage UI and patches of course are always welcome.  I think we'd want
something clearer though than just the quoted list.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
