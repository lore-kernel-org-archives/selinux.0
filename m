Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i989rprT020343
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 05:53:51 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i989qgBk017622
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 09:52:42 GMT
Date: Fri, 8 Oct 2004 11:04:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: .fonts-cache being created as user_home_dir_t
Message-ID: <20041008100458.GC5089@lkcl.net>
References: <20041005091026.GB25251@lkcl.net> <200410071250.14304.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200410071250.14304.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 07, 2004 at 12:50:14PM +1000, Russell Coker wrote:
> On Tue, 5 Oct 2004 19:10, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > it looks like a file_auto_trans() is missing somewhere: i find
> > that ~/.fonts.cache-1 is set to type user_home_dir_t.
> 
> Is that being created by kdm?  

 i couldn't entirely say: let me see if i can find out...
 a search through all kdebase *.cpp,h only shows up
 something in kcontrol kio handler.  so that didn't work.

> Is the machine in permissive mode at the time 
> the file is created?

 no.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
