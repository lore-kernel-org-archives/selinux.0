Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m83Cgr05003573
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 08:42:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m83Cgrkh011548
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 12:42:53 GMT
Subject: Re: [refpolicy] checkpolicy: error(s) encountered while parsing
	configuration
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30809020802y3183a670n972e7e75eb09caa@mail.gmail.com>
References: <dd18b0c30808311634k683b139fm9f17810a66a81074@mail.gmail.com>
	 <1220359558.28287.0.camel@gorn>
	 <dd18b0c30809020802y3183a670n972e7e75eb09caa@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 08:41:44 -0400
Message-Id: <1220445704.28287.16.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-09-02 at 11:02 -0400, Justin Mattock wrote:
> On Tue, Sep 2, 2008 at 8:45 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
> > On Sun, 2008-08-31 at 19:34 -0400, Justin Mattock wrote:
> >> when loading the latest refpolicy I'm seing a
> >> policy/modules/kernel/kernel.te":237:ERROR 'syntax error' at token 'corenet_raw_
> >> corenet_raw_send_multicast_node(kernel_t)
> >>
> >> not sure if this is checkpolicy or refpolicy
> >
> > I can't reproduce this.  Can you send a modules.conf along with build
> > settings?
> >
> > --
> > Chris PeBenito
> > Tresys Technology, LLC
> > (410) 290-1411 x150
> >
> >
> 
> O.K.
> Attached is build.conf of the refpolicy
> that worked. The policy that was giving me this message
> was from svn.
> here is a list of the packages I was using:
> checkpolicy 2.0.16-2 then downgraded to 2.0.16-1
> libselinux1 2.0.65-4
> libselinux1-dev 2.0.65-4
> libsemanage1 2.0.25-1
> libsemanage1-dev 2.0.25-1
> libsepol1-dev 2.0.30-2
> lsb-base  3.2-20
> lsb-release 3.2-20
> polgen 1.3-5
> policycoreutils 2.0.49-5 was also using this package from feisty
> but upgraded to the package with the -U deny option.
> python-selinux 2.0.65-4
> python-semanage 2.0.25-1
> python-sepolgen 1.0.11-4
> 
> From what I remember I was using the debian SID repository
> for some of the packages, and then moving to feisty
> for some of the other packages as well. I'll try
> and load the svn policy again to see if this happens. my guess
> is either policycorutils, or checkpolicy was outdated
> at the time of building(but could be wrong);
> Also attached is the kernel config that I am using for this machine.

I need the modules.conf for the policy, not the kernel config.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
