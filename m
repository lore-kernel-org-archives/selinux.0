Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HEoYrT016668
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 10:50:36 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HEoX8B029992
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 14:50:33 GMT
Date: Sun, 17 Oct 2004 16:01:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: nsa <SELinux@tycho.nsa.gov>
Subject: Re: writing rules to disallow a domain to read particular files
Message-ID: <20041017150125.GG19398@lkcl.net>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com> <1097948413.3872.3.camel@x-infinity.verbum.private> <1098017660.2740.33.camel@jsingh.india.ensim.com> <20041017141433.GF19398@lkcl.net> <1098023488.3182.8.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098023488.3182.8.camel@jsingh.india.ensim.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 17, 2004 at 08:01:28PM +0530, Jaspreet Singh wrote:
> Hi,
> 
> 
> >  okay, one way to achieve that is to use the
> >  macro apache_domain(virtual_$1) say by adding it to
> >  macros/base_macros.te at the same point where apache_domain($1)
> >  is used.
> > 
> 
> Could you elaborate on this more ... I am not able to understand 
 
 you need to read my previous email in which i describe a walk-through
 of going over the apache macros.


> >  plus adding 
> > 
> > > and now based on the access writes of users of a particular site I want
> > > them to access services like apache. so that apache cant access
> > > /home/virtual/siteNum/home/users/public_html/files.html
> >  
> >   uh?  _can't_ access ..../files.html??  why?
> > 
> 
> Let me give you the idea of virtualization ... 

 good idea :)

> i guess i made a mistake
> last time ..

 no, just missing information.

 but let's clarify: cant is not an english word: above, do
 you mean "can" or do you mean "can not"?


> sites and have any numbers of users, and the users can only see the site
> file system (chroot env). 

 okay, so first you should look at file_contexts/program/apache.fc
 and change the second line

	HOME_DIR/((www)|(web)|(public_html))(/.+)?
	system_u:object_r:httpd_ROLE_content_t

 to:
 
 	/home/virtual/siteNum/HOME_DIR/((www)|....

 and see what happens.

 you _may_ have to look at genhomedircon to ensure that it can
 substitute HOME_DIR when it is used like i suggest.



> Now the site avails certain services like
> apache , sshd , telnet and things like that ...
> 
> based upon what they have availed .. they are given services. So only
> when the site avails for say .. apache service i want to allow the
> apache to read the user files. I know this can be  don't through

 surely you mean done not don't (don't is short for "do not")

> httpd.conf .. but apache is just one example .. i want a generic MAC
> based solutions.
> 
> One way to do this in DAC is ... all the files in site file system like
> /home/virtual/siteNum/etc/http.conf and all is owned by the the group -
> "apache" and users users are added to this group when the site avails
> for apache service.
 
 so not only do you want the user to be able to access the site files
 but also you want the user to be able to manage the ADMINISTRATIVE
 file httpd.conf (for their Virtual site) is that right?

 [doesn't sound right but i'm just checking].

 

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
