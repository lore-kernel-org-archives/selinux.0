Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q93JPMqb013780
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2012 15:25:22 -0400
Received: by vchn11 with SMTP id n11so10184029vch.12
        for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2012 12:25:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPzO=NzdpGtzBA9o7r20sPohwG2rQe78umLp3C1n2yBh6T7HAw@mail.gmail.com>
References: <CAPzO=NydFKroZ5_+_3NK1QYcn37QqAaDeSMW+7NGjc==iFKZQQ@mail.gmail.com>
	<CAPzO=NzdpGtzBA9o7r20sPohwG2rQe78umLp3C1n2yBh6T7HAw@mail.gmail.com>
Date: Wed, 3 Oct 2012 21:25:21 +0200
Message-ID: <CAPzO=Nz=uXOR6Lp_O1aQMd0SbvNW+kX4mSb+AtOijq3zahYp7g@mail.gmail.com>
Subject: Re: run_init change in latest policycoreutils
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 3, 2012 at 9:14 PM, Sven Vermeulen <sven.vermeulen@siphos.be> wrote:
> On Sun, Sep 30, 2012 at 7:48 PM, Sven Vermeulen
> <sven.vermeulen@siphos.be> wrote:
>> The "Authenticating root." is normal. The execvp error isn't. I get
>> the following denial, but I don't think this is the cause of the error
>> (mainly because it worked previously):
>>
>> Sep 30 19:44:02 testsys kernel: [20516.783063] type=1400
>> audit(1349027042.720:264): avc:  denied  { entrypoint } for  pid=20672
>> comm="run_init" path="/sbin/rc-service" dev="vda1" ino=2373161
>> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:bin_t
>> tclass=file
> [...]
>
> OK so allowing the following fixes the behavior, yet I'm still not
> aware why and if this additional rule is really a good idea. Of
> course, without any transition permission, having an entrypoint has no
> real threats with it, does it?
>
> """
> allow initrc_t bin_t:file entrypoint;
> """

Hmm, sorry for replying to my own stuff here (I should wait with
hitting send until I've slept a good while). There are already quite a
few transitions possible towards initrc_t, and marking bin_t as an
entrypoint doesn't make much sense...

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
