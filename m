Subject: Re: Overlay Filesystem and SELinux
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Dale Amon <amon@vnl.com>, Erich Schubert <erich@debian.org>,
   Stephen Smalley <sds@epoch.ncsc.mil>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <20041227102704.GB6750@lkcl.net>
References: <1098274225.12118.20.camel@jsingh.india.ensim.com>
	 <20041020151031.GB21185@lkcl.net> <20041020174938.GL21185@lkcl.net>
	 <1098887565.1620.15.camel@jsingh.india.ensim.com>
	 <1104022405.29054.7.camel@wintermute.xmldesign.de>
	 <1104050461.14672.6.camel@jsingh> <20041226125404.GA2459@vnl.com>
	 <1104086350.19031.13.camel@jsingh>  <20041227102704.GB6750@lkcl.net>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 16:29:33 +0530
Message-Id: <1104145173.20250.2.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Luke,

On Mon, 2004-12-27 at 10:27 +0000, Luke Kenneth Casson Leighton wrote:
> are the knoppix team aware of it?
> 
well no ... I am in touch with Tomas Matejicek of www.linux-live.org I
think i would mail and check response. Anyone in touch with them ???

I am studying selinux implementation in 2.6 kernels .. anyone with
revelent docs .. the one on nsa website is stale.

Thanx,
Jaspreet

> On Mon, Dec 27, 2004 at 12:09:10AM +0530, Jaspreet Singh wrote:
> 
> > Hi,
> > 
> > On Sun, 2004-12-26 at 12:54 +0000, Dale Amon wrote:
> > > > That project is now .. not maintained .. and now I am involved in a much
> > > > more sophisticated implementation called - "unionfs" . Check this link -
> > > > www.fsl.cs.sunysb.edu/project-unionfs.html
> > > > 
> > > > Unionfs was initially only for 2.4 kernel, but i recently ported it to
> > > > 2.6. The port is not official yet. But, its working.
> > > 
> > > Brilliant. I have been waiting for this quite literally
> > > for years. What are the chances it will go into the
> > > main kernel tree?
> > 
> > Thanx :) , Yes the official maintainers can answer that question better.
> > For all i know unionfs is been publicized at lkml and there are talks
> > for the same.
> > 
> > Till recently, it just seemed to be an academic project. But now it has
> > gained momentum. I have used and extended 3 overlay file-systems .. and
> > this one seemed to be most promising and stable.
> > 
> > It has some very good features like - adding/removing branches (i.e
> > directories ) from a union.
> > 
> > But, i am just a fresh grad .. probably people out there and judge this
> > file-system better.
> > 
> > Currently my port works on 2.6.0 -to- 2.6.9 kernels .. but maintainers
> > are reviewing it .. would work on it.
> > 
> > Thanx,
> > Jaspreet
> > 
> > -- 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> 
-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
