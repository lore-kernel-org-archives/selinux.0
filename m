Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12LAO53025918
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 16:10:24 -0500 (EST)
Received: from mx-5.zoominternet.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j12L8FVZ017370
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 21:08:16 GMT
Received: from mua-1.zoominternet.net (mua-1.zoominternet.net [24.154.1.44])
	by mx-5.zoominternet.net (8.12.11/8.12.11) with ESMTP id j12LAPRs013482
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 16:10:26 -0500
Received: from 192.168.0.188 (acs-24-144-211-60.zoominternet.net [24.144.211.60])
	by mua-1.zoominternet.net (Postfix) with ESMTP id 226C17F408
	for <selinux@tycho.nsa.gov>; Wed,  2 Feb 2005 16:10:26 -0500 (EST)
Subject: FC3, Apache and CGI web app
From: Scott Cain <cain@cshl.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 02 Feb 2005 16:07:41 -0500
Message-Id: <1107378461.3351.62.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am one of the authors of a web application that is widely used in my
community, GBrowse ( http://www.gmod.org/ggb/ ).  We've started
receiving bug reports from users who are trying to install and run it on
Fedora Core 3 systems with SELinux installed and enabled with the
default values from the distribution.  

To do some testing, I've installed FC3 and GBrowse and run into the same
problems.  The only way I've been able to get GBrowse to run is to
disable SELinux.  There are a few reasons I'd rather not tell my users
to do that, so I am looking for a way to leave SELinux enabled and still
run GBrowse.  The first thing I tried was to set httpd_disable_trans=1
(which the GUI calls "Disable SELinux protection for httpd daemon"), but
that doesn't help.  Are there any parameters that I can add
to /etc/selinux/targeted/booleans to allow GBrowse to work?

As far as I can tell, the reason SELinux doesn't like GBrowse is that it
is a cgi that tries to read a directory and files in the apache conf
directory.

Thanks,
Scott

-- 
------------------------------------------------------------------------
Scott Cain, Ph. D.                                         cain@cshl.org
GMOD Coordinator (http://www.gmod.org/)                     216-392-3087
Cold Spring Harbor Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
