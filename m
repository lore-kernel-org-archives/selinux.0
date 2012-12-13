Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBDNUH5i028024
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 18:30:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 13 Dec 2012 18:29:49 -0500
From: David Quigley <selinux@davequigley.com>
To: "Kevin W. Wall" <kevin.w.wall@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: semanage cleanup
In-Reply-To: <CAOPE6PhyAxDeA5RjtvMO+f+7UR3rQ1tsyEMn3MERcfCSgN3u5w@mail.gmail.com>
References: <21751d382c2cacb70f450cd1483cecdd@countercultured.net>
 <50C9EE3D.70902@tycho.nsa.gov> <50C9F53E.4000009@davequigley.com>
 <CAOPE6PhyAxDeA5RjtvMO+f+7UR3rQ1tsyEMn3MERcfCSgN3u5w@mail.gmail.com>
Message-ID: <6fc5cfacf7425eac08f1d9fa01e78ba5@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/2012 11:16, Kevin W. Wall wrote:
> On Dec 13, 2012 10:38 AM, "Dave Quigley" <dpquigl@davequigley.com> 
> wrote:
>  > Yea I dont think separating out the commands will really gain us
> much. I wonder though if separating the man pages might though. Git
> man pages are still given to you as git-clone or git-commit etc. 
> There
> could be an semanage manpage which has the man pages for the specific
> commands as semanage-fcontext etc. Not sure we have enough 
> information
> to make it worth it. It would be possible to have a more indepth
> discussion in the man pages about examples and usage if they werent
> all crammed into one.
>
> FWIW, I think that model (one command, separate subcommand man pages)
> has worked well for openssl.
>
> -kevin


I Haven't typed in all of the help info yet but the link is to a 
pastbin with the usage information for the semanage login subcommand. I 
just need to get it do react that way when there are 0 arguments passed 
in as well. Right now it will print this when you type semanage login -h 
or --help. I want it to print this on semanage login with no arguments 
as well.

http://pastebin.com/KTtNk0rC

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
