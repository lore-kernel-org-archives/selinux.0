Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98DUCrT021427
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 09:30:12 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98DT3Bk027297
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 13:29:03 GMT
Subject: Re: .fonts-cache being created as user_home_dir_t
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041008100458.GC5089@lkcl.net>
References: <20041005091026.GB25251@lkcl.net>
	 <200410071250.14304.russell@coker.com.au>  <20041008100458.GC5089@lkcl.net>
Content-Type: text/plain
Date: Fri, 08 Oct 2004 09:31:45 -0400
Message-Id: <1097242305.6064.10.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-08 at 11:04 +0100, Luke Kenneth Casson Leighton wrote:
> On Thu, Oct 07, 2004 at 12:50:14PM +1000, Russell Coker wrote:
> > On Tue, 5 Oct 2004 19:10, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > it looks like a file_auto_trans() is missing somewhere: i find
> > > that ~/.fonts.cache-1 is set to type user_home_dir_t.
> > 
> > Is that being created by kdm?  
> 
>  i couldn't entirely say: let me see if i can find out...
>  a search through all kdebase *.cpp,h only shows up
>  something in kcontrol kio handler.  so that didn't work.

The file is created by the fontconfig libraries.  Since Qt uses
fontconfig, any process that uses Qt could potentially create that file.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
