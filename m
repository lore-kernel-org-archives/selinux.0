Date: Mon, 17 Dec 2001 16:55:57 -0500 (EST)
From: Noah silva <nsilva@atari-source.com>
To: lonnie@outstep.com
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: User Policy Setup
In-Reply-To: <1008605922.3c1e1ae244f20@mail.outstep.com>
Message-ID: <Pine.LNX.4.21.0112171655040.24001-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


If you want to keep them from accesing other directories, you just have to
do a CHROOT, but... If they can't read files outside of their home, it
could cause other problems (f.e. will StarOffice, etc. all be installed in
their home folders?)

 -- noah silva 

On Mon, 17 Dec 2001 lonnie@outstep.com wrote:

> Hello All,
> 
> I am very new to setting up and using SELinux so please forgive the dumb 
> questions, ok.
> 
> I am still trying to work out my issues with getting the network working as I 
> am getting messages like "cannot send dump request" and "Error adding address 
> 192.168.1.5 for eth0".
> 
> My question is really about setting up the user policies. I have a special 
> project in which I need to confile the users to their HOME directories so that 
> they can NEVER navigate out of them. I also need to allow them to run just a 
> single application such as StarOffice, but still not let them navigate out of 
> their HOME directories even through the application.
> 
> Could someone please help to tell me how I might be able to set up some 
> policies like this?
> 
> Any help would be greatly appreciated,
> Thanks,
> Lonnie
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
