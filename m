Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4OLLb7d024827
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 17:21:37 -0400
Received: from fep07-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4OLLaX7012171
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 21:21:36 GMT
Subject: Re: Is it possible to assign different labels to symbolic links and
 actual files?
From: Guido Trentalancia <guido@trentalancia.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 24 May 2011 23:21:31 +0200
In-Reply-To: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1306272093.2575.6.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-05-24 at 13:46 -0700, Sam Gandhi wrote:
> Hello,
> 
> I am working on a embedded platform and we have busybox on this device.
> 
> What we would like to do do is assign diffrent labels to various
> busybox links. What we have seen when running things on JFFS2 when I
> label a symbolic link, the actual file gets the label, but the link
> itself doesn't (according to ls -lZ output).  We have seen similar
> behaviour with files on tmpfs as well.
> 
> ls -lZ
> -rw-r--r--        1         0 Jan  1 00:12 system_u:object_r:myfile_t X
> lrwxrwxrwx    1         1 Jan  1 00:13 user_u:object_r:tmpfs_t          Y -> X
> 
> Is there no way to assign different label to symlink and actual files?

chcon -h
semanage -f -l
-l in policy file contexts

> Is this file-system specific issue? Are there any file-system that
> support assigning seperate labels to symlink and actual file?

It depends on the userspace code and/or the policy as explained above.

> -Sam

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
