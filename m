Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01717
	for <selinux@tycho.nsa.gov>; Sat, 17 Aug 2002 09:36:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA08071
	for <selinux@tycho.nsa.gov>; Sat, 17 Aug 2002 13:34:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA08052 for <selinux@tycho.nsa.gov>; Sat, 17 Aug 2002 13:34:46 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: entrypoint permission
Date: Sat, 17 Aug 2002 15:36:11 +0200
References: <20020817125827.67159.qmail@web40017.mail.yahoo.com>
In-Reply-To: <20020817125827.67159.qmail@web40017.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020817133611.E84CD14B0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 17 Aug 2002 14:58, Brad Chapman wrote:
>       What does the 'entrypoint' permission do? It seems to be related to
> domains transfer and program execution, but not in an intuitive way.

>From macros/global_macros.te:
# domain_trans(parent_domain, program_type, child_domain)
#
# Permissions for transitioning to a new domain.
#

define(`domain_trans',`
[...]
# Allow the new domain to be entered via the program.
#
allow $3 $2:file entrypoint;
')

It allows a new domain (specified by $3 in this instance) to be entered by 
executing a file of type $2.

EG:
allow user_t shell_exec_t:file entrypoint;

The domain user_t can be entered by executing a file of type shell_exec_t (no 
great limitation).  However some other domains are more restrictive, eg:
allow ntpd_t ntpd_exec_t:file entrypoint;
ntpd_t can only be entered by executing the ntpd_exec_t files.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
