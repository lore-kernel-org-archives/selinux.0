Message-ID: <1343135089.2383.28.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via
 socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Tue, 24 Jul 2012 09:04:49 -0400
In-Reply-To: <CAO-4OdG2zH+9dDQYboh2itGN6a5cUMPc23TJO3vJZ6DDaR9TwA@mail.gmail.com>
References: <1342739276-1686-4-git-send-email-hqjiang1988@gmail.com>
	 <1343050007.23118.28.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdG2zH+9dDQYboh2itGN6a5cUMPc23TJO3vJZ6DDaR9TwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-23 at 15:05 -0700, Haiqing Jiang wrote:
> If in that case, I don't think it's a good idea to allow permission to
> mediaserver over rild. Thanks for your comments. 

It may be legitimate, but I want to understand why and how it happens
before allowing it.

> 
> On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>         On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
>         > ---
>         >  mediaserver.te |    3 +++
>         >  1 files changed, 3 insertions(+), 0 deletions(-)
>         >
>         > diff --git a/mediaserver.te b/mediaserver.te
>         > index d3f0334..6dd4d4a 100644
>         > --- a/mediaserver.te
>         > +++ b/mediaserver.te
>         > @@ -40,3 +40,6 @@ allow mediaserver
>         camera_calibration_file:file r_file_perms;
>         >  # Read/[write] to /proc/net/xt_qtaguid/ctrl
>         and /dev/xt_qtaguid
>         >  allow mediaserver qtaguid_proc:file rw_file_perms;
>         >  allow mediaserver qtaguid_device:chr_file r_file_perms;
>         > +
>         > +# Talk to rild via socket
>         > +unix_socket_connect(mediaserver, rild, rild)
>         
>         
>         Hmm...it used to be that only radio could connect to rild.
>         socket perms are 660 root radio, and mediaserver runs as
>         media.
>         Doesn't seem like this is possible even under DAC.
>          Clarification
>         requested?
>         
>         --
>         Stephen Smalley
>         National Security Agency
>         
> 
> 
> 
> 
> -- 
> -----------------------------------
> Haiqing Jiang, PH.D student
> 
> 
> Computer Science Department, North Carolina State University
> 
> 
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
