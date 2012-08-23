Message-ID: <1345737324.10773.8.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Problems getting source using repo sync
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 23 Aug 2012 11:55:24 -0400
In-Reply-To: <CAN93RkKUP7ukTWmKX6bbntoP8M5rsEuCL1m2HHe3-rs681cNPw@mail.gmail.com>
References: 
	<CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
	 <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil>
	 <CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
	 <CAFftDdqYRhn4n4r66Jhdazk77hNbY40-g0+0zgVKzS4k6mxsrQ@mail.gmail.com>
	 <CAN93RkKE7Nuy3HLQZU6B7rX+omDG5L174qEKia-mA0sRKVuaYg@mail.gmail.com>
	 <CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com>
	 <CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
	 <CAN93RkKztvm9tq-Bf=_SiuG1GpqLThLFA2Ly5qafRe=56aJ0Tw@mail.gmail.com>
	 <1345722246.10773.3.camel@moss-pluto.epoch.ncsc.mil>
	 <CAN93RkKUP7ukTWmKX6bbntoP8M5rsEuCL1m2HHe3-rs681cNPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 10:24 -0400, Cesar Maiorino wrote:
> > You might want to try the ssh-based access instead.  Requires
> setting up
> > an account on bitbucket.org and uploading a ssh public key.  Then
> you
> > can do the following:
> > cd manifests
> > git checkout origin/seandroid-4.0.4-ssh
> 
> > and use the local_manifest.xml file that you'll find in that branch.
> 
> I'll try this next. Thanks.
> 
> BTW, I am using 4.0.4 because that is what is currently supplied by
> the OEM I am dealing with, and
> I want to change as little as possible until I get things working.
> 
> On that note, I have another question. I'll want to extract patches to
> apply to my code base. I see
> an example on selinuxproject.org:
> cd seandroid-4.0.4/frameworks/base
> git format-patch android-4.0.4_r2.1
> 
> I assume I need to do this for each of the git projects that contain
> seandroid changes. Is there an easy
> way to figure out which projects those are?

Yes, they are listed the local_manifest.xml file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
