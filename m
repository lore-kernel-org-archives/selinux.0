Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9GJSKrT013647
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 15:28:20 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9GJSIlX011488
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 19:28:19 GMT
Date: Sat, 16 Oct 2004 20:39:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: nsa <SELinux@tycho.nsa.gov>
Subject: Re: writing rules to disallow a domain to read particular files
Message-ID: <20041016193919.GC19398@lkcl.net>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1097940101.2569.5.camel@jsingh.india.ensim.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Oct 16, 2004 at 08:51:41PM +0530, Jaspreet Singh wrote:

> Hi,
> 
> can someone help me with writing policy rules such that -
> 
> A domain (say apache_d) cannot access files beyond a directory
> /home/jaspreet/
> 
> any clues ???
 
 hi jaspreet,

 okay your first clue is to look in
 /etc/selinux/src/file_contexts/program/apache.fc

 what you are looking for is to match the known location where web files
 are stored (and you'd expect them to be stored in /var/www, yes?)

 so you look in apache.fc for /var/www and sure enough, /var/www(/.*)?
 matches against httpd_sys_content_t.


 the second clue is to look in
 /etc/selinux/src/domains/program/apache.fc

 and uh, okay, there's an ifdef (`targeted_policy', ... ') around
 http_sys_content_t being aliases to httpd_user_content_t.  okay,
 dunno what that's about.

 okay, so, uh, okay, let's grep httpd_user_content_t and
 httpd_sys_content_t against */* and */*/* okay, and we find
 some macros in macros/program/apache_macros.te... which
 defines a macro apache_domain.


 also, file_contexts/file_contexts contains this:

 # apache
 /home/[^/]+/((www)|(web)|(public_html))(/.+)?  system_u:object_r:httpd_user_content_t

 so, /home/jaspreet/www and /home/jaspreet/web  and
 /home/jaspreet/public_html _all_ are accessible automatically via the
 strict policy.

 already.  as httpd_user_content_t.

 /var/www/* is already accessible (as httpd_sys_content_t)


 there are two uses of the apache_domain macro:

 - the first is in domains/programs/apache.te, with this:

 	apache_domain(sys)

	which will create you the httpd_sys_content_t etc. etc.

 - the second is in macros/user_macros.te with this:

 	apache_domain($1) where the macro gets called with $1 = user
	or $1 = sysadm or staff, whatever.


 anything outside of this (using apache_domain() macro for anything
 else) is a bit beyond one single email for explanation.



> Also if anyone could explain the behavior of "newrole" how can that be
> used here.

 there is no use of the command newrole that i percieve would
 be of any use to you here - that could just be because i've
 never had a reason to use it.

 l.

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
