Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4G13arE028858
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 21:03:36 -0400
Received: from countercultured.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p4G13a2G000715
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 01:03:36 GMT
Message-ID: <4DD077E6.5030309@davequigley.com>
Date: Sun, 15 May 2011 21:03:34 -0400
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: FUSE and SELinux labeling
References: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
In-Reply-To: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/15/2011 10:40 AM, Sam Gandhi wrote:
> Hi
>
>
> Is there a FAQ or some description on what one needs to do to enable
> labeling on files created under a fuse filesystem?
>
> When I mount my fuse file system I see message like
>
> SELinux: initialized (dev fuse, type fuse), not configured for labeling
>
> Now if I use statement such as shown below in my SELinux policy before
> loading it I don't see those messages
>
> fs_use_xattr fuse system_u:object_r:fs_t;
>
> But then when I try to mount fuse file system using simple fuse hello
> program as hello /tmp/foo, I see message:
>
> SELinux: (dev fuse, type fuse) getxattr errno 4 on console and my system hangs!
>
>
> ( Has anybody been successful in adding the SELinux labels to file
> created  by fuse? I have search both fuse and SElinux mailing list,
> also done bit of google search and nothing comes up , either this is
> way too simple thing to do and I am missing obvious thing)
>
> Would appreciate any help.
>
> ( I had sent message earlier to fuse-devel, but didn't cross-post it
> to SELinux )
> -Sam
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

So the short answer to this is No you can't use xattr style labeling on 
fuse. Eric Paris in the past tried to do this but it was unsucessful. If 
I remember correctly there were some weird conditions in fuse which 
would cause deadlocks. Attempts were made to fix this problem but it 
seemed that it was an ideological issue just as much as a technical one. 
Someone had posted a similar question back around December or September 
I believe and it should have a more complete view of the problem. The 
list of things that would need to be done would be allow FUSE to pass 
the name of the fusefs to the security server so it can decide what to 
do with the particular fusefs. The second thing would be to fix the 
deadlock issue in fuse but I don't think you're going to make progress 
on that. Dominick in another thread said that fuse doesn't support 
xattrs. If that is the case then you would need to implement fuse xattr 
handlers as well and the fuse interface for them. This list probably 
isn't complete as I don't remember the full details of the conversation 
from back then.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
