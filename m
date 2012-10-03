Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q93JESuk013265
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2012 15:14:28 -0400
Received: by vchn11 with SMTP id n11so10167764vch.12
        for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2012 12:14:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPzO=NydFKroZ5_+_3NK1QYcn37QqAaDeSMW+7NGjc==iFKZQQ@mail.gmail.com>
References: <CAPzO=NydFKroZ5_+_3NK1QYcn37QqAaDeSMW+7NGjc==iFKZQQ@mail.gmail.com>
Date: Wed, 3 Oct 2012 21:14:21 +0200
Message-ID: <CAPzO=NzdpGtzBA9o7r20sPohwG2rQe78umLp3C1n2yBh6T7HAw@mail.gmail.com>
Subject: Re: run_init change in latest policycoreutils
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 30, 2012 at 7:48 PM, Sven Vermeulen
<sven.vermeulen@siphos.be> wrote:
> The "Authenticating root." is normal. The execvp error isn't. I get
> the following denial, but I don't think this is the cause of the error
> (mainly because it worked previously):
>
> Sep 30 19:44:02 testsys kernel: [20516.783063] type=1400
> audit(1349027042.720:264): avc:  denied  { entrypoint } for  pid=20672
> comm="run_init" path="/sbin/rc-service" dev="vda1" ino=2373161
> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:bin_t
> tclass=file
[...]

OK so allowing the following fixes the behavior, yet I'm still not
aware why and if this additional rule is really a good idea. Of
course, without any transition permission, having an entrypoint has no
real threats with it, does it?

"""
allow initrc_t bin_t:file entrypoint;
"""

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
