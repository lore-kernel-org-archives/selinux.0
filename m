Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IBX2Rb000474
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 07:33:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IBUMB2003959
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:30:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4IBULwi003953
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:30:21 GMT
Subject: Re: suggestion to help transition to selinux: dynamic loading of
	libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, selinux@tycho.nsa.gov
In-Reply-To: <200405180510.40047.russell@coker.com.au>
References: <20040515232606.GA9378@lkcl.net>
	 <200405180510.40047.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1084879917.28966.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 07:31:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-17 at 15:10, Russell Coker wrote:
> The first candidate for such changes would be init.  We would have to 
> hard-code a check for selinux=0 in the init source to avoid having init just 
> not enable SE Linux if file system corruption causes libselinux.so to 
> disappear.
> 
> I think that init is the program that needs such changes most, the current 
> situation makes libselinux one of the most important packages in the system 
> (can't boot without it).

I'm surprised that /sbin/init isn't statically linked in Fedora. 
Rationale?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
