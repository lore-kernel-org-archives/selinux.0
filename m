Date: Sat, 29 May 2004 11:18:42 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SELinux <SELinux@tycho.nsa.gov>, tng-technical@lists.samba-tng.org,
   samba-technical@samba.org
Subject: Re: se-samba
Message-ID: <20040529111842.GA18370@lkcl.net>
References: <40ACFC0C.9020101@snu.edu> <20040529095153.GB16927@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040529095153.GB16927@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, May 29, 2004 at 09:51:53AM +0000, Luke Kenneth Casson Leighton wrote:

> > Basically the idea is that samba runs in it's own domain (ofcourse), but 
> > this domain has to be able to access/read/write files in other domains, 
> > particularly user domains. However we want the same enforcements over 
> > samba that a user would get on the local system, so the idea is to make 

> > [...]

> 1) doing user-space avc library calls is fine IF you can guarantee
> that the file system to which you are providing access is NOT
> accessible by any means other than through se-samba [or that
> any such access guarantees no race conditions].
> 
> i.e. you must, in effect, write your own userspace file system.

... just to be clear: isolating a filesystem from backdoor access
(i.e. the underlying filesystem, if it's a unix filesysyem, is NOT
accessible via any other means e.g. an NFS export) is not as bad
as it first seems.

you can always use the smbfs (or its newer more unix-centric
cifsfs cousins) linux kernel smb client filesystems to access
such an isolated userspace filesystem, and then re-export that
filesystem via other file servers (e.g. NFS).

i don't expect it to be very fast, it's not very friendly,
but it's minimal coding, minimal administrative setup and
it'll work.  fingers crossed.  :)

l.

p.s. as is done at the moment, you could always just keep on
giving samba unlimited policy access to the directories it
exports, but that's not the point, is it?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
