Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4MFUuGe013997
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 11:30:56 -0400
Received: from purple.iano.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4MFUlxb007055
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 15:30:48 GMT
Received: from purple.iano.org (localhost [127.0.0.1])
	by purple.iano.org (8.13.2/8.13.2) with ESMTP id k4MEkgIk005395
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 10:46:42 -0400 (EDT)
Received: (from iano@localhost)
	by purple.iano.org (8.13.2/8.13.2/Submit) id k4MEkgnR005394
	for selinux@tycho.nsa.gov; Mon, 22 May 2006 10:46:42 -0400 (EDT)
Date: Mon, 22 May 2006 10:46:42 -0400
From: Maria Iano <maria@iano.org>
To: selinux@tycho.nsa.gov
Subject: Re: correct way to set context in perl?
Message-ID: <20060522104642.O26098@iano.org>
References: <20060518160656.V26098@iano.org> <200605192357.39325.russell@coker.com.au> <20060519103127.A26098@iano.org> <200605202213.56675.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200605202213.56675.russell@coker.com.au>; from russell@coker.com.au on Sat, May 20, 2006 at 10:13:52PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you all for your time and help with this. Using restorecon works well and I only need to store the correct context information in one place so that's the way to go. I am very impressed at how easy it was to write a couple of .te and .fc files and adapt my scripts. SELinus has been extremely well designed and implemented - thank you!

Maria


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
