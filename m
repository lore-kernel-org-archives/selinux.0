Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4PCFD20001385
	for <selinux@tycho.nsa.gov>; Wed, 25 May 2011 08:15:13 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4PCFAfH014509
	for <selinux@tycho.nsa.gov>; Wed, 25 May 2011 12:15:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Sam Gandhi <samgandhi9@gmail.com>
Subject: Re: Is it possible to assign different labels to symbolic links and actual files?
Date: Wed, 25 May 2011 22:15:05 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com> <4DDC1E11.2020200@redhat.com> <BANLkTi=eLtqov9i0pXpXJkwNK74cc4mUAw@mail.gmail.com>
In-Reply-To: <BANLkTi=eLtqov9i0pXpXJkwNK74cc4mUAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201105252215.06258.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 May 2011, Sam Gandhi <samgandhi9@gmail.com> wrote:
> cd tmp
> touch X
> ln -s X Y
> setfilecon system_u:object_r:myfile_t Y
> 
> And I see ls -lZ output as I shown above which shows /tmp/X has the
> myfile_t label and not Y

Don't use setfilecon, use chcon which has a -h option to label symlinks.

> I can't really use tools like semanage 'cause I can't install python
> on this system. I will try to "reverse" engineer what semanage does
> and how it handles symlink v/s regular files.

I think that most people who do embedded stuff prepare their image on a 
workstation or server and label it there.  The setfiles program has the -r 
option which is good for this.

If you are going to label it on the device then you might consider modifying 
setfiles to output a shell script that runs chcon on all the files.  That 
shouldn't be too hard to do.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
