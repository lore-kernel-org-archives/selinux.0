Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1331Z53027499
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 22:01:36 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1331cL6018104
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 03:01:38 GMT
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by monk.area614.net (Postfix) with ESMTP id 1EF52410845
	for <selinux@tycho.nsa.gov>; Wed,  2 Feb 2005 22:00:40 -0500 (EST)
Message-ID: <42019412.9010708@verbum.org>
Date: Wed, 02 Feb 2005 22:01:38 -0500
From: Colin Walters <walters@verbum.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: FC3, Apache and CGI web app
References: <1107378461.3351.62.camel@localhost.localdomain>
In-Reply-To: <1107378461.3351.62.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Scott Cain wrote:
> Hello,
> 
> I am one of the authors of a web application that is widely used in my
> community, GBrowse ( http://www.gmod.org/ggb/ ).  We've started
> receiving bug reports from users who are trying to install and run it on
> Fedora Core 3 systems with SELinux installed and enabled with the
> default values from the distribution.  
> 
> To do some testing, I've installed FC3 and GBrowse and run into the same
> problems.  The only way I've been able to get GBrowse to run is to
> disable SELinux.  There are a few reasons I'd rather not tell my users
> to do that, so I am looking for a way to leave SELinux enabled and still
> run GBrowse.  The first thing I tried was to set httpd_disable_trans=1
> (which the GUI calls "Disable SELinux protection for httpd daemon"), but
> that doesn't help.  Are there any parameters that I can add
> to /etc/selinux/targeted/booleans to allow GBrowse to work?

And did you restart Apache with "service httpd restart"?

> As far as I can tell, the reason SELinux doesn't like GBrowse is that it
> is a cgi that tries to read a directory and files in the apache conf
> directory.

Yeah, the policy doesn't allow that by default.  The httpd_sys_script_t 
domain just tries to capture a "typical" class of scripts; but in 
general it's going to either be too strong or too weak for particular 
CGI programs.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
