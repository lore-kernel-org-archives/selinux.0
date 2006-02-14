Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1EKrIXf001453
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2006 15:53:18 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1EKpu3j028337
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2006 20:51:56 GMT
Subject: Re: seref: patch: postfix and roles
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060211000106.GA32469@sergelap.austin.ibm.com>
References: <20060211000106.GA32469@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 15:55:13 -0500
Message-Id: <1139950513.13925.142.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 18:01 -0600, Serge E. Hallyn wrote:
> Been trying to send mail as a local user, but user_r was not permitted
> to associate with postfix_postdrop_t.
> 
> Additionally I needed the TODO section uncommented on my system...

Merged.  I changed the implementation to use userdom interfaces rather
than $1_tmp_t since the mta module doesn't know that the user's tmp type
can be derived by doing $1_tmp_t.  Same thing for roles ($1_r) but the
role is passed in as a parameter ($3); however, in this case, postfix
has its own per userdomain template, so I moved the role part there.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
