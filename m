Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8MKDa9C031720
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 16:13:38 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8MKDb1f003035
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 20:13:37 GMT
Message-ID: <1316722410.2259.59.camel@vortex>
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 22 Sep 2011 22:13:30 +0200
In-Reply-To: <4E7B9233.6080609@redhat.com>
References: <4E7B9233.6080609@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-22 at 15:53 -0400, Daniel J Walsh wrote:
> Currently if I create a directory labeled
> 
> etc_t:s0:c1
> 
> And with a process running as unconfined_t:s0-s0:c0.c1023 create a
> file within the directory, the file gets created with the label
> etc_t:s0.   I would like to change the behavior to creating the file
> as etc_t:s0:c1.
> 
> That way an administrator could modify files within a sandbox and have
> the files be labeled correctly.
> 
> I believe this behavior differs from MLS but believe this would be
> what the admin expects.
> 
> Is changing this a kernel or policy issue?

Should be a kernel issue. Sounds interesting.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
