Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAHNZOIi010644
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 18:35:24 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAHNXukh007735
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 23:33:57 GMT
Received: by wproxy.gmail.com with SMTP id 71so438338wra
        for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 15:35:27 -0800 (PST)
Message-ID: <fa8ec5d8041117153578db68e9@mail.gmail.com>
Date: Wed, 17 Nov 2004 18:35:27 -0500
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patches without the can_network patch.
Cc: jwcart2@epoch.ncsc.mil, Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4192A029.5050909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

           is there any selinux play machine that I can login and is
currently up. Mr.Russel Cockers machine seems not up and running. I
tried other debian and gentoo machines as well but unable to login.
also I have a fedora core 3 machine and in the policy sources I dont
have the tunables.te file. I dont know why this is missing as I had
that in the core 2. I wanted to tune some macros. thanx..

Ram


On Wed, 10 Nov 2004 18:11:37 -0500, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Removal of alot of kerberos and can_ypbind calls.  (Centralized under
> the auth call).
> 
> Several apache fixes to make squirrelmail work as well as mod_perl and
> mod_python.
> 
> Fixes to dovecot to get it to work with squirrelmail
> 
> Fixes to hal to allow it to create a chr_file device for pcmcia card
> communication.
> 
> Added lockdev policy
> 
> Fixes for mailman policy
> 
> A few more nscd_client_domains
> 
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
