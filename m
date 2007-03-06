Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26KNX2t016907
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 15:23:33 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26KOxxq001034
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 20:24:59 GMT
Received: by ug-out-1314.google.com with SMTP id y2so361682uge
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2007 12:24:58 -0800 (PST)
Message-ID: <e739902b0703061224r1ec0e9b2kd937e84ba01edd0d@mail.gmail.com>
Date: Tue, 6 Mar 2007 12:24:57 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Question about the process : share permission.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1173198873.15967.142.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0703060815m5bbe83bdsed886eafe6dac00d@mail.gmail.com>
	 <1173198873.15967.142.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ah, that make sense.
Thanks for the explanation!

- Ryan


On 3/6/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2007-03-06 at 08:15 -0800, Ryan Bradetich wrote:
> > Hello all,
> >
> > I am trying to understand what the process : share permission does.
> > In the SELinux by example book, it says the process : share permission
> > allows state sharing with cloned or forked processes.
> >
> > I looked looked through the refpolicy tree and only found one instance
> > of the process : share permission, it is in the kernel_share_state
> > interface.   This interface is only called by the system/init module.
> >
> > At first I thought this permission had to do with shared libraries
> > and/or forking processes, but I see there is also a process : fork
> > permission and there is a libs_use_shared_libs interface function to
> > allow the loading and execution of shared libraries.
> >
> > I am just curious to understand what the process : share permission
> > allows/prevents.
>
> If you call clone() with certain flags (e.g. CLONE_FS, CLONE_FILES) to
> cause sharing of certain portions of the task state and then perform a
> context-changing execve, then the process share permission is checked
> between the old and new contexts.  This is generally unsafe, as it
> allows the caller to influence/control the callee.  It happens naturally
> when the kernel starts init, which is why it is allowed there.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
