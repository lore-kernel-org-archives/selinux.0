From: lonnie@outstep.com
To: Noah silva <nsilva@atari-source.com>
Subject: Re: User Policy Setup
Message-ID: <1008625616.3c1e67d056094@mail.outstep.com>
Date: Mon, 17 Dec 2001 16:46:56 -0500 (EST)
Cc: SELinux Mailing <SELinux@tycho.nsa.gov>
References: <Pine.LNX.4.21.0112171655040.24001-100000@sparcy.internal.lan>
In-Reply-To: <Pine.LNX.4.21.0112171655040.24001-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually it is ok if they can read the OpenOffice files from some other 
directory, but just not other directories. For example I might place the 
OpenOffice files in a /programs/OpenOffice directory and when I have a new 
application then put it in the /programs directory as well into its own sub-
directory as well.

Outside of reading the programs directory, I do not want then to leave their 
HOME locations if that is possible.

I have been told that what I am trying to di is complete doable with SELinux so 
now I am looking to find the details of implementing it.

Thanks,
Lonnie

Quoting Noah silva <nsilva@atari-source.com>:

> 
> If you want to keep them from accesing other directories, you just have
> to
> do a CHROOT, but... If they can't read files outside of their home, it
> could cause other problems (f.e. will StarOffice, etc. all be installed
> in
> their home folders?)
> 
>  -- noah silva 
> 
> On Mon, 17 Dec 2001 lonnie@outstep.com wrote:
> 
> > Hello All,
> > 
> > I am very new to setting up and using SELinux so please forgive the
> dumb 
> > questions, ok.
> > 
> > I am still trying to work out my issues with getting the network
> working as I 
> > am getting messages like "cannot send dump request" and "Error adding
> address 
> > 192.168.1.5 for eth0".
> > 
> > My question is really about setting up the user policies. I have a
> special 
> > project in which I need to confile the users to their HOME directories
> so that 
> > they can NEVER navigate out of them. I also need to allow them to run
> just a 
> > single application such as StarOffice, but still not let them navigate
> out of 
> > their HOME directories even through the application.
> > 
> > Could someone please help to tell me how I might be able to set up
> some 
> > policies like this?
> > 
> > Any help would be greatly appreciated,
> > Thanks,
> > Lonnie
> > 
> > --
> > You have received this message because you are subscribed to the
> selinux list.
> > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> > 
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
