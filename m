Message-ID: <1345723737.10773.6.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Problems getting source using repo sync
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 23 Aug 2012 08:08:57 -0400
In-Reply-To: <1345722246.10773.3.camel@moss-pluto.epoch.ncsc.mil>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 07:44 -0400, Stephen Smalley wrote:
> On Wed, 2012-08-22 at 18:51 -0400, Cesar Maiorino wrote:
> > I started clean and  used this sequence of commands (as per
> > selinuxproject.org/page/SEAndroid)
> > 
> > git clone -b seandroid-4.0.4 https://bitbucket.org/seandroid/manifests.git
> > mkdir seandroid-4.0.4
> > cd seandroid-4.0.4
> > repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.4_r2.1
> > repo sync
> > cp ../manifests/local_manifest.xml .repo/
> > repo sync -j1
> > 
> > local_manifest.xml is configured for bitbucket.
> 
> You might want to try the ssh-based access instead.  Requires setting up
> an account on bitbucket.org and uploading a ssh public key.  Then you
> can do the following:
> cd manifests
> git checkout origin/seandroid-4.0.4-ssh
> 
> and use the local_manifest.xml file that you'll find in that branch.

BTW, are you sure you want to use 4.0.4?  4.1.1 is available.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
