Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8BJE4mX019096
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 15:14:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8BJE3ba009202
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 19:14:03 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8BJD3LF018912
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 15:13:03 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8BJD272023759
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 15:13:02 -0400
Received: from [10.11.14.83] (vpn-14-83.rdu.redhat.com [10.11.14.83])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8BJD2k1001757
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 15:13:02 -0400
Subject: concept of a permissive domain
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 11 Sep 2007 15:13:01 -0400
Message-Id: <1189537981.3407.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So there was a brief conversation between dan, karl, and myself today
about implementing a permissive subject domain.  Basically there would
be some new language construct possibly "permissive httpd_t true;" which
would then set a flag.  If this flag was set, all denials would be
logged but the operation would be permitted.  This would make it
possible to create a type_exec_t and type_t for your new domain, mark it
as permissive/unconfined and run it as long as you like.  Once you get
all your new allow rules you just remove the permissive bit.  You didn't
have to setenforce the whole system.

First thought from Karl was to use the 'char primary' field of the
struct type_datum.  Seems reasonable enough, after we have that
information in kernel it shouldn't take me too much playing around in
avc_has_perm_noaudit to check if this flag is set on a denial.  I don't
think slowing down the denial path a little by having to call back in to
see if this flag was set for a given source sid is that big of deal.
Maybe I could keep it just about as fast by adding more flags
audit_allow_once (can't really reuse audit_allow) to the avd or
something like that, but it seems like a large waste of space to carry
another set of audit flags that won't be used much.

Thoughts?  Other ways to implement this?  Problems with the basic premis
of an unconfined domain?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
