Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4BMsoQY023429
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 18:54:50 -0400
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4BMslwZ017487
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 22:54:48 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4BMpKLY030198
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 18:51:20 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4BMslJr185700
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 16:54:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4BMsliH017153
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 16:54:47 -0600
Date: Fri, 11 May 2007 17:54:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: [ANN] SELinux kernel project page
Message-ID: <20070511225447.GA10087@sergelap.austin.ibm.com>
References: <Line.LNX.4.64.0705111811230.25709@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Line.LNX.4.64.0705111811230.25709@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris (jmorris@namei.org):
> FYI,
> 
> If you're involved in any kind of SELinux kernel development, you may be 
> interested in the recently created wiki page:
> 
> http://selinuxproject.org/page/Kernel_Development

one item is

    * Support for kernel namespaces 

Did anyone have some idea of what we might want to add?  My thought was
that the policy server work would pretty much cover the desired extensions -
so I create a type called 'vserver1', and give vserver1.admin the rights
to create subtypes of vserver1 and administer it's policy, subject to
vserver1's rights.

Maybe someone wanted to add object types for each namespace type, with
'unshare', 'view', and perhaps (though unlikely) 'enter' permissions?

Finally checkpointing seems safely covered by ptrace, and kill by, well,
kill...

-serge

> This is where we'll be keeping track of todo items and various kernel 
> related issues.
> 
> Please feel free to edit the page yourself (wiki accounts may be obtained 
> by emailing Karl MacMillan <kmacmill@redhat.com>).
> 
> At some point, we may migrate this to a Trac system, although that may be 
> something to consider more widely for the SELinux project in general.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@namei.org>
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
