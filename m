Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28GrpDt011334
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 11:53:51 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28Grn5G008826
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 16:53:50 GMT
Received: by nf-out-0910.google.com with SMTP id n15so695208nfc
        for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2007 08:53:49 -0800 (PST)
Message-ID: <9d1b82480703080853v137069a7h338108de5dc1e480@mail.gmail.com>
Date: Thu, 8 Mar 2007 22:23:43 +0530
From: Pravin <shindepravin@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: CKRM and SELinux
In-Reply-To: <1172611097.19041.428.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9d1b82480702262223o37921e5cubc8506efaa225e2d@mail.gmail.com>
	 <9d1b82480702262236r6cab8167qcf73a68f0fcd7c1@mail.gmail.com>
	 <1172581266.19041.312.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480702271307q45bfc167mff78dc03a6c9b482@mail.gmail.com>
	 <1172611097.19041.428.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I think you misunderstand my intent - I'm not talking about control over
> resource management decisions; I'm talking about ensuring that the
> interface used to configure CKRM (e.g. the pseudo filesystem interface)
> can be properly access controlled via SELinux.  At more than just a
> global "can I configure CKRM or not?" granularity, ideally.

Please correct me if I am wrong here.
One of the way to configure CKRM is to use pseudo filesystem called "configfs".
I am not very sure but I think that in order to have access control on
this "configfs", we already have security context assosicated
"configfs" filesystem,
If we write policies on these security contexts, we can have quite
fine grained access control over CKRM configuration, just like any
other file-system.

Another way in which processes are grouped into classes for CKRM is
when they are getting created.
Here, they inherit the class of their parent.
I was considering the possibility of using security-context of process
and some policies ( these policies can be similar to selinux policies
which can use role, type, user of security-context ) which will decide
the class of new process.

There is Rule Based Classification Engine which already automiatically
classifies processes into classes depending on task parameters ( pid,
gid, uid, executable ).
I am considering the possibility of having similar classification
Engine which will be using security-context's and policies based on
these context to do the classification.

Thank you
-- 
 Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
