Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4OMrrWh029328
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 18:53:55 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4OMrr11006244
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 22:53:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Sam Gandhi <samgandhi9@gmail.com>
Subject: Re: Is it possible to assign different labels to symbolic links and actual files?
Date: Wed, 25 May 2011 08:53:49 +1000
Cc: selinux@tycho.nsa.gov
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
In-Reply-To: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201105250853.49540.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 May 2011, Sam Gandhi <samgandhi9@gmail.com> wrote:
> I am working on a embedded platform and we have busybox on this device.
> 
> What we would like to do do is assign diffrent labels to various
> busybox links. What we have seen when running things on JFFS2 when I
> label a symbolic link, the actual file gets the label, but the link
> itself doesn't (according to ls -lZ output).  We have seen similar
> behaviour with files on tmpfs as well.

SE Linux supports assigning a different label to the sym-link, but that only 
matters when access checks are performed for reading/following the sym-link.  
When it comes to actually running the program the link label means little.

If you want to use labels to determine domain transitions then you can't use 
the sym-link label.  You need to either have a wrapper program that is labeled 
to give the domain transition which then executes busybox, or to have several 
copies of busybox which aggregate only programs which deserve the same domain.

http://doc.coker.com.au/papers/porting-se-linux-hand-held-devices/

You could probably benefit from some of the suggestions I made in the above 
paper.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
