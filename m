Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2REMH2B020653
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 10:22:17 -0400
Received: by qadc11 with SMTP id c11so164933qad.12
        for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 07:22:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120326201255.41befb27@fornost.bigon.be>
References: <20120326173317.25d0ed1c@eldamar.bigon.be>
	<CACLa4ps73sqV-O+aLKkFEoDtbp05heymjoz=LRrHWbq4YKD-5g@mail.gmail.com>
	<20120326201255.41befb27@fornost.bigon.be>
Date: Tue, 27 Mar 2012 10:22:16 -0400
Message-ID: <CACLa4ptwQwpmywe4qrvjjcYBi9A4Br9NcMvcNqqRPGj=bWFZbw@mail.gmail.com>
Subject: Re: [PATCH 2/4] policycoreutils -- Only run setfiles if we found
 read-write filesystems to run it on
From: Eric Paris <eparis@parisplace.org>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 26, 2012 at 2:12 PM, Laurent Bigonville <bigon@debian.org> wrote:
> Le Mon, 26 Mar 2012 13:55:56 -0400,
> Eric Paris <eparis@parisplace.org> a écrit :
>
>> This patch doesn't apply.  I don't see a "SYSLOGFLAG" in the upstream
>> tree.  Is that something debian specific?
>
> This is weird, it applies fine here on git master HEAD
>
> [git: master]$ git grep SYSLOGFLAG
> scripts/fixfiles:SYSLOGFLAG="-l"
> scripts/fixfiles:${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE

You are absolutely right.  It is a Fedora-ism that removes SYSLOGFLAG.
 My fault.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
