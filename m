Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HE3arT016474
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 10:03:36 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HE2Mxh002652
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 14:02:23 GMT
Date: Sun, 17 Oct 2004 15:14:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: Colin Walters <walters@verbum.org>, sds@epoch.ncsc.mil,
   nsa <SELinux@tycho.nsa.gov>
Subject: Re: writing rules to disallow a domain to read particular files
Message-ID: <20041017141433.GF19398@lkcl.net>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com> <1097948413.3872.3.camel@x-infinity.verbum.private> <1098017660.2740.33.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098017660.2740.33.camel@jsingh.india.ensim.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 17, 2004 at 06:24:20PM +0530, Jaspreet Singh wrote:
> Hi, 
> 
> Thanx for the mails ...
> 
> > 
> > Look at the label on /home/jaspreet.  It should be user_home_dir_t.  The
> > labels on contained files are user_home_t.  If you allow httpd_t access
> > to user_home_dir_t, but not user_home_t, that should achieve your goal.
> > 
> 
> I have already followed this approach to achieve the target (i.e not
> giving the access to a particular file/dir type to the domain )
> 
> What I want is something more generic and sophisticated. 
> 
> > What is your higher level goal though?
> 
> The higher goal is to support (site) virtualization e.g.
> 
> apart from /home/users I want to have /home/virtual/siteNum/home/users
 
 okay, one way to achieve that is to use the
 macro apache_domain(virtual_$1) say by adding it to
 macros/base_macros.te at the same point where apache_domain($1)
 is used.

 plus adding 

> and now based on the access writes of users of a particular site I want
> them to access services like apache. so that apache cant access
> /home/virtual/siteNum/home/users/public_html/files.html
 
  uh?  _can't_ access ..../files.html??  why?


> One approach is definitely to simply tag the files as
> "siteNum_virtual_home_t" and the allow/disallow apache to read them for
> that matter simply tag them with unlabled_t to deny access by any
> service.

 okay.

 whom do you want to allow access to what?

 do you want the user to be able to ftp or scp files up to the
 /home/virtual/siteNum directory?

 you really need to lay out exactly who manages and how the
 files are to be managed.

 what i mean is that you can use apache_domain as above but then you
 need to grant someone the right to upload files into the new file
 contexts.

 so.

 is a user given the right to manage a group of sites, or is there going
 to be one user per site (like my brother does: he has one username per
 VirtualHost), are there going to be several users per group of sites?

 how are the site files to be managed?

 etc.



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
