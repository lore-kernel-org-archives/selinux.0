Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14KWLRb014500
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:32:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i14KUqVK003595
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 20:30:52 GMT
Received: from s3cin.xetron.com (fw.xetron.com [216.68.89.2])
	by jazzswing.ncsc.mil  with ESMTP id i14KUolx003591
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 20:30:50 GMT
Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A96@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'sds@epoch.ncsc.mil'" <sds@epoch.ncsc.mil>
Cc: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
Subject: glibc  AT_SECURE auxv
Date: Wed, 4 Feb 2004 15:32:09 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From what I've read, this glbc change is important for a production system
and has been upstreamed into Fedora.
So what is a Red Hat 9 2.4 kernel user to do if he wants the AT_SECURE auxv
glibc change for a production system?  Must I upgrade from Red Hat 9 to the
Fedora core to get this change, which is really out of the question at this
point?  Please clarify.
>From: Stephen Smalley <sds_at_epoch.ncsc.mil> 
>Date: Wed 1 Oct 2003 - 10:16:24 EDT
>The support for the AT_SECURE auxv entry was upstreamed into the mainline
glibc CVS tree back in June after the corresponding kernel change was
accepted by Linus into the mainline 2.5 (now 2.6) kernel. 
>-- 
>Stephen Smalley <sds@epoch.ncsc.mil>
>National Security Agency

On Tue, 2003-09-30 at 21:04, Diyab wrote: 
> So is this new glibc version available as the mainstream glibc package 
> or will non redhat users still have to apply the patch. And if is or 
> will be soon available as mainstream glibc do you know what version?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
