Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA17349
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 11:35:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA25148
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 15:33:36 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id PAA25144
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 15:33:36 GMT
Date: Tue, 9 Oct 2001 11:34:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Additions to file_contexts
In-Reply-To: <1002571333.3666.57.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0110091131050.3214-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 8 Oct 2001, Justin R. Smith wrote:

> I run Java servlets (using the Jakarta Tomcat engine) from my web site,
> so I added the following lines to the setfiles/file_context file, since
> servlets are LIKE scripts (sort of):
>
> /var/www/tomcat(|/.*)           system_u:object_r:httpd_user_script_rw_t
> /var/www/classes(|/.*)          system_u:object_r:httpd_user_script_rw_t
>
> Note: /var/www/classes is a directory containing classes used by all
> servlets and is in the Java CLASSPATH. /var/www/tomcat contains tomcat
> and all deployed web applications.

Shouldn't you be using the httpd_user_script_t type (or the
httpd_sys_script_t type)?  The httpd_user_script_rw_t type is a type for
files that are readable and writeable by user CGI scripts.  Is that what
you want?

> I also had to make my html content writable because my cgi scripts and
> servlets frequently write to it.
>
> In addition, Tomcat likes to compile jsp into servlets and, therefore,
> must be able to write to its work directory.

Hopefully you can separate the content that should be writeable from the
content that is static, and use different types in order to still protect
some of your content against corruption.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
