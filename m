Date: Mon, 16 Feb 2004 12:19:44 -0500
From: Robert Connolly <cendres@videotron.ca>
Subject: Re: StrongArm port
In-reply-to: <200402170346.15946.russell@coker.com.au>
To: Douglas Williams <douglaswilliams@sympatico.ca>,
   SELinux <SELinux@tycho.nsa.gov>
Message-id: <200402161219.44430.cendres@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <005701c3f441$e13d7a20$6401a8c0@williams>
 <200402161000.31454.cendres@videotron.ca>
 <200402170346.15946.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On February 16, 2004 11:46 am, Russell Coker wrote:
> On Tue, 17 Feb 2004 02:00, Robert Connolly <cendres@videotron.ca> wrote:
> > On February 15, 2004 11:03 pm, Douglas Williams wrote:
> > > Does anyone know where I can get a good linux kernel for an IPAQ 3850.
> > > My next robot must have a secure OS especially since it will use an RF
> > > data link with relatively weak encryption.
> >
> > I have just recently started working on Ipaq development. I can't give
> > you an expected date for a working release; but I intened to first get
> > the Ipaq (3600) Linux built with 'gcc -pie', and without text relocation.
> > First with glibc since that should already work, then with uclibc.
> > Eventually leading to kernel 2.6, with selinux, Pax, and ssp. I haven't
> > considered the issue with xattr, I'll deal with that when I get to it. I
> > feel the biggest challenge will come in porting the graphical software to
> > pie/pax.
>
> Why do you think that graphical software and PIE will be difficult?
> People are already working on this, and it shouldn't be THAT difficult.

Because thats where much of the work for x86 needs to be done, but the ipaq 
has fewer developers.

> However adding XATTR support to a file system is going to be difficult. 
> You will need to deal with compatability issues (what happens when you
> mount the XATTR file system with an old XATTR-less kernel?) among other
> things.

This wouldn't bother me specificly. But I see the problem here.

> If you write the XATTR support then I would expect that someone else would
> solve the PIE issues before you get XATTR finished.

I'll check into it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
