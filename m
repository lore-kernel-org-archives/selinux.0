Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JJH6rT013371
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 15:17:06 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JJG82w028240
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 19:16:08 GMT
Date: Sun, 19 Sep 2004 20:28:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Robert Kot <robkot6@wp.pl>
Cc: SELinux mailing list <selinux@tycho.nsa.gov>
Subject: Re: Basic problems with roles and domains
Message-ID: <20040919192814.GE23901@lkcl.net>
References: <20040913225410.GB14736@wintermute.xmldesign.de> <200409192014.58452.russell@coker.com.au> <1095603929.3709.79.camel@skorpion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095603929.3709.79.camel@skorpion>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 19, 2004 at 04:25:29PM +0200, Robert Kot wrote:

> OS: stock Fedora Core 2
> 
> $ uname -a
> Linux skorpion 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 i686 i386
> GNU/Linux
> 
> Hi,
> 
>  I'm trying to learn SELinux using FC2.
> This is probably stupid problem, but it's difficult for
> a beginner.
> First, I've added my user robert to 'users' file:
> 
> user robert roles { user_r };
 
 okay: what this says is that when you do a make relabel,
 the program genhomedircon will go through looking for
 "ROLE" and automatically substitute and generate
 robert:object_r_user_home_t etc. on your behalf.

> In new file domains/program/robert.te, I added:
> 
> type myfile_txt_t, file_type;
> type myfile_t, domain;
> role robert_r types myfile_t;
 
 okay.  creating new roles is a bit like doing new unix "groups".
 sort-of.


 what i recommend here is that you examine russell's tutorial
 on selinux (which if you can't find it you should be able to
 reference via the ukuug.org web site because stephen tweedie
 did a 1day tutorial on selinux using russell's material, two
 months ago in leeds)

 in the tutorial, they go through the creation of a role
 "professors_r".

 and also take you through the necessary policy modification steps.

 under normal circumstances, however, you really shouldn't need
 to create new roles: sysadm_r, staff_r and user_r are pretty much
 all that you'll ever need.

 of course, for experimentation and as an aid to understanding,
 forget the above sentence :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
