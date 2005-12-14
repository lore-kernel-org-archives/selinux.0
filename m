Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBEFZmMA010029
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 10:35:48 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBEFYvW7011760
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 15:34:57 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <439F4626.4000408@redhat.com>
References: <439F4626.4000408@redhat.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 10:35:40 -0500
Message-Id: <1134574541.4936.31.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-13 at 17:07 -0500, Daniel J Walsh wrote:
> Certain applications linked with rpmlibes call the rpm_script_t so 
> unconfined_t needs to transition.
> 
> rpmbuild policy should be dropped.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
