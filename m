Subject: Re: writing rules to disallow a domain to read particular files
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <20041017141433.GF19398@lkcl.net>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
	 <1098017660.2740.33.camel@jsingh.india.ensim.com>
	 <20041017141433.GF19398@lkcl.net>
Content-Type: text/plain
Message-Id: <1098023488.3182.8.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Date: Sun, 17 Oct 2004 20:01:28 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,


>  okay, one way to achieve that is to use the
>  macro apache_domain(virtual_$1) say by adding it to
>  macros/base_macros.te at the same point where apache_domain($1)
>  is used.
> 

Could you elaborate on this more ... I am not able to understand 

>  plus adding 
> 
> > and now based on the access writes of users of a particular site I want
> > them to access services like apache. so that apache cant access
> > /home/virtual/siteNum/home/users/public_html/files.html
>  
>   uh?  _can't_ access ..../files.html??  why?
> 

Let me give you the idea of virtualization ... i guess i made a mistake
last time ..

sites and have any numbers of users, and the users can only see the site
file system (chroot env). Now the site avails certain services like
apache , sshd , telnet and things like that ...

based upon what they have availed .. they are given services. So only
when the site avails for say .. apache service i want to allow the
apache to read the user files. I know this can be  don't through
httpd.conf .. but apache is just one example .. i want a generic MAC
based solutions.

One way to do this in DAC is ... all the files in site file system like
/home/virtual/siteNum/etc/http.conf and all is owned by the the group -
"apache" and users users are added to this group when the site avails
for apache service.

Now who does this shifting is a secondary thing .... and difficult to
explain here .....

is there any way to do this in MAC ??? something using roles may be ??

Thanx
Jaspreet
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
