Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2723jW9017437
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 21:03:45 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2722CJj009800
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 02:02:12 GMT
Message-ID: <440CE9FF.2090201@cornell.edu>
Date: Mon, 06 Mar 2006 21:03:43 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage/src/semanage_store.c:semanage_split_fc
References: <20060306221519.GA25033@sergelap.austin.ibm.com>
In-Reply-To: <20060306221519.GA25033@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> In semanage_split_fc(), linex 887 and 893, the file_con fd is not closed
> on error.  Trivial patch follows.
>
>   
There's already a cleanup: goto target, I think that should be used instead
(after initializing the file descriptors, and making the close 
statements conditional).

It'd be nice if close(-1) and fclose(NULL) were no-ops.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
