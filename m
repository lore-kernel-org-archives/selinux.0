Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12NkH53026716
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 18:46:17 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j12Ni8VZ026537
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 23:44:08 GMT
Message-ID: <42016640.3050807@redhat.com>
Date: Wed, 02 Feb 2005 18:46:08 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Scott Cain <cain@cshl.org>
CC: selinux@tycho.nsa.gov
Subject: Re: FC3, Apache and CGI web app
References: <1107378461.3351.62.camel@localhost.localdomain>
In-Reply-To: <1107378461.3351.62.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Scott Cain wrote:

>Hello,
>
>I am one of the authors of a web application that is widely used in my
>community, GBrowse ( http://www.gmod.org/ggb/ ).  We've started
>receiving bug reports from users who are trying to install and run it on
>Fedora Core 3 systems with SELinux installed and enabled with the
>default values from the distribution.  
>
>To do some testing, I've installed FC3 and GBrowse and run into the same
>problems.  The only way I've been able to get GBrowse to run is to
>disable SELinux.  There are a few reasons I'd rather not tell my users
>to do that, so I am looking for a way to leave SELinux enabled and still
>run GBrowse.  The first thing I tried was to set httpd_disable_trans=1
>(which the GUI calls "Disable SELinux protection for httpd daemon"), but
>that doesn't help.  Are there any parameters that I can add
>to /etc/selinux/targeted/booleans to allow GBrowse to work?
>
>As far as I can tell, the reason SELinux doesn't like GBrowse is that it
>is a cgi that tries to read a directory and files in the apache conf
>directory.
>
>Thanks,
>Scott
>
>  
>
First make sure you have the latest policy, via yum

yum update selinux-policy-targeted

Next make sure httpd_unified is set

setsebool -P httpd_unified 1

Now try it.

Look for AVC messages in /var/log/messages which will tell you what is 
being denied.
http://fedora.redhat.com/docs/selinux-apache-fc3/
has a lot of information on settingup apache and SElinux.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
