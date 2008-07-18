Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IILXeq007730
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:21:33 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IILW29016788
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 18:21:32 GMT
Message-ID: <4880DFD6.90501@kutulu.org>
Date: Fri, 18 Jul 2008 14:24:22 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: refpolicy patch: samba enhancements
References: <487BB78D.6080500@kutulu.org> <4880D5FC.5030400@redhat.com>
In-Reply-To: <4880D5FC.5030400@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

> Could you do this with pam_oddjob_mkhomedir without having to add the
> privs.  I think this is a better solution.

Is this a Redhat-specific thing?  I'm running Gentoo, and while I have a 
"pam_mkhomedir" module, I don't have anything called oddjob anywhere.

I'm using the pam_mkhomedir module, but it's running under the nmbd 
context, so that's where I had to put the rules.  There isn't a way to 
get the PAM module to use a different context than the process it's 
loaded into, is there?

--Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
