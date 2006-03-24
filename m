Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2OJ138j021747
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 14:01:03 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2OIxHV1026869
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 18:59:20 GMT
Subject: Re: interfaces added...
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1143218108.2462.208.camel@faith.austin.ibm.com>
References: <1143218108.2462.208.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 14:00:46 -0500
Message-Id: <1143226846.3962.64.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-24 at 10:35 -0600, Joy Latten wrote:
> Chris,
>         
>         A week or so ago, on irc we discussed about adding several
>         interfaces that would allow third party modules, such as the
>         selinux test policy, to have types/domains that can be entered
>         via the sysadm domain. 
>         Below is a patch containing several new interfaces that allow
>         this.
>         Please let me know if these are ok or if I need to change
>         something
>         as I have added them to the test policy. miscfiles.te already
>         defined a test_file_t, so I expanded on that.

Merged, with a few minor tweaks, in particular I changed the userdomain
interface names.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
