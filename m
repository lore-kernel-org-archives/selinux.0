Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25868
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 09:52:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA14241
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:51:21 GMT
Received: from web40204.mail.yahoo.com (web40204.mail.yahoo.com [66.218.78.65])
        by jazzband.ncsc.mil  with SMTP id NAA14237 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:51:21 GMT
Message-ID: <20020627135246.74377.qmail@web40204.mail.yahoo.com>
Date: Thu, 27 Jun 2002 06:52:46 -0700 (PDT)
From: Michael Nyika <nyix@yahoo.com>
Subject: Re: Type Attribute Declarations
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0206270915550.1331-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Related to this, i am also trying to resolve the
identifiers given to types. 

Your document "Security Policy Configuration for the
Security-Enhanced Linux" outlines some on page 5, such
as "privuser", "privrole" and others. (I understand
"domain" as an important attribute in defining a
domain ). Where are "privuser" and the rest in the
document defined? 

Also, looking at policy/types/network.te , i come
across "socket_type", "port_type" and others. They
must have been defined somewhere, right? OR is that
just a way of GROUPING types with one's own identifers
(and leaving it at that) so that that particular SET
of type-attributes must exist/not-exist for certain
permissions to be granted?...........????

--- Stephen Smalley <sds@tislabs.com> wrote:
> 
> On Thu, 27 Jun 2002, Michael Nyika wrote:
> 
> > Good day: I have a question and it is about Object
> > Security Classes. How does one know before hand
> what
> > identifiers they can take? For example, i have
> come
> > across "file", "capability", "process". In what
> file
> > have they been predefined (if at all)?
> 
> As explained in the Configuring the SELinux Policy
> report, the security
> classes are defined in a configuration file that is
> shared between the
> SELinux kernel module and the example policy
> configuration.  The file is
> named security_classes and is located under
> lsm-2.4/security/selinux/flask
> in the source tree.  The upstream distribution
> installs it into
> /usr/local/selinux/flask, while the Debian selinux
> package install it into
> /usr/lib/selinux (I think).  There are a set of
> macros defined for common
> sets of classes in the
> selinux/policy/macros/global_macros.te file, as
> also discussed in the report.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
