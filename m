Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6LHkbnc009250
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 13:46:37 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6LHkFQq004150
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 17:46:15 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n6LHjiIY021674
	for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2009 13:45:44 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n6LHjiGE021672
	for selinux@tycho.nsa.gov; Tue, 21 Jul 2009 13:45:44 -0400
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on
 sysfs files, directories, and symlinks.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org
Cc: sds@tycho.nsa.gov, Greg KH <greg@kroah.com>, casey@schaufler-ca.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <1248194067.10726.22.camel@localhost>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1248194067.10726.22.camel@localhost>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 13:01:40 -0400
Message-Id: <1248195700.10726.28.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-21 at 12:34 -0400, David P. Quigley wrote:
> I've found a problem with the patch that I want to fix. So I will be
> posting another version of it soon.
> 
> Dave
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Looking more closely at the problem I was mistaken. I was concerned with
the dereferenceing of the dentry in the first line of the getxattr
function but it seems that a precondition for us getting that far is
that we will always have a valid dentry at that point. I'd appreciate it
if the people whose code the patch touches can review the patch again
and either NAK with more comments or sign off on it.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
