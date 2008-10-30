Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9U4PQDa003883
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 00:25:26 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9U4NqhG002090
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 04:23:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Murray McAllister <mmcallis@redhat.com>
Subject: Re: user guide draft: "Examples: Booleans for NFS"
Date: Thu, 30 Oct 2008 15:25:16 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <4905320C.4090807@redhat.com> <49085722.7010901@redhat.com> <4908F1AA.9060006@redhat.com>
In-Reply-To: <4908F1AA.9060006@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810301525.19737.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 30 October 2008 10:28, Murray McAllister <mmcallis@redhat.com> 
wrote:
> These Booleans exist in SELinux policy as shipped with Fedora 10. They
> may not exist in policy shipped with other versions of Fedora or other
> operating systems.
>
> I'll keep these things in mind when the guide is forked for Red Hat
> Enterprise Linux.

Given that M4 knowledge is required for anyone who does anything serious with 
SE Linux, maybe you should write your documentation in M4.

Some years ago I wrote my CV in M4 and had it produce about 10 different 
versions (I also had a Makefile).  Then it a recruiting agent wanted a 
version of my CV that emphasised my C coding experience I could just send the 
relevant file.

The same technique could be used for any other document.  It would be good if 
you could type "make" and produce documents for several versions of Fedora 
and a couple of versions of RHEL at the same time.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
