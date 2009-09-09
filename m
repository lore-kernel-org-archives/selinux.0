Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89FWhZB004380
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 11:32:43 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n89FT3Vo017743
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 15:31:58 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n89FQYq6010225
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 11:26:34 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n89FQY1H010223
	for selinux@tycho.nsa.gov; Wed, 9 Sep 2009 11:26:34 -0400
Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8906qn9026768
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 20:06:52 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8906DXV008909
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 00:06:13 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8906obs013111
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 20:06:50 -0400
Received: from localhost.localdomain (vpn-12-44.rdu.redhat.com [10.11.12.44])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8906lEr025899
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 20:06:50 -0400
Message-ID: <4AA6F197.5050506@redhat.com>
Date: Tue, 08 Sep 2009 20:06:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles leaks file descriptors
References: <4AA6E4E2.1000303@redhat.com>
In-Reply-To: <4AA6E4E2.1000303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/08/2009 07:12 PM, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=521682
> 
> Patch to fix is included.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Never mind old version.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
