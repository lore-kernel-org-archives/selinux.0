Subject: Re: writing rules to disallow a domain to read particular files
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Colin Walters <walters@verbum.org>, lkcl@lkcl.net, sds@epoch.ncsc.mil
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1097948413.3872.3.camel@x-infinity.verbum.private>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
Content-Type: text/plain
Message-Id: <1098017660.2740.33.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Date: Sun, 17 Oct 2004 18:24:20 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 

Thanx for the mails ...

> 
> Look at the label on /home/jaspreet.  It should be user_home_dir_t.  The
> labels on contained files are user_home_t.  If you allow httpd_t access
> to user_home_dir_t, but not user_home_t, that should achieve your goal.
> 

I have already followed this approach to achieve the target (i.e not
giving the access to a particular file/dir type to the domain )

What I want is something more generic and sophisticated. 

> What is your higher level goal though?

The higher goal is to support (site) virtualization e.g.

apart from /home/users I want to have /home/virtual/siteNum/home/users

and now based on the access writes of users of a particular site I want
them to access services like apache. so that apache cant access
/home/virtual/siteNum/home/users/public_html/files.html

One approach is definitely to simply tag the files as
"siteNum_virtual_home_t" and the allow/disallow apache to read them for
that matter simply tag them with unlabled_t to deny access by any
service.

But, this would be computationally more complex to something like a role
based approach. For example this could be achieved in DAC manipulating
group permissions i.e all the site users availing a particular service
become part of the "service group" and then this group has group rwxd
permissions for the service specific files.

I don't want to tamper the file permissions coz something like sendmail
would never like it :-(

> 
> It's not really relevant to your previous problem.  Do you have a
> specific question about newrole?
> 

Now, I know only login method can assign roles , so what about the
non-login sessions ???

and one more thing which came to my mind was (may be irrelevent to the
context) ... What if I "mount  --bind" contents of a directory to
multiple places and give different file tags to the different mount
points .. will the selinux system work properly in this scenario ( coz
it wont in case of LIDS which rely upon ACLs)

Sorry for any confusions .. created by this mail ;-)
Jaspreet Singh

-- 
:: don't walk as if you own the world 
	 walk as if you dont damn who owns it ::

Jaspreet Singh,
Software Engineer,
Ensim India.

Ph # +91 9890712226



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
