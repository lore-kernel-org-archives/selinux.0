Date: Mon, 16 Feb 2004 10:00:31 -0500
From: Robert Connolly <cendres@videotron.ca>
Subject: Re: StrongArm port
In-reply-to: <005701c3f441$e13d7a20$6401a8c0@williams>
To: Douglas Williams <douglaswilliams@sympatico.ca>,
   SELinux <SELinux@tycho.nsa.gov>
Message-id: <200402161000.31454.cendres@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <005701c3f441$e13d7a20$6401a8c0@williams>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On February 15, 2004 11:03 pm, Douglas Williams wrote:
> Does anyone know where I can get a good linux kernel for an IPAQ 3850. My
> next robot must have a secure OS especially since it will use an RF data
> link with relatively weak encryption.

I have just recently started working on Ipaq development. I can't give you an 
expected date for a working release; but I intened to first get the Ipaq 
(3600) Linux built with 'gcc -pie', and without text relocation. First with 
glibc since that should already work, then with uclibc. Eventually leading to 
kernel 2.6, with selinux, Pax, and ssp. I haven't considered the issue with 
xattr, I'll deal with that when I get to it. I feel the biggest challenge 
will come in porting the graphical software to pie/pax.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
