Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6KJU8M9013922
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 15:30:08 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6KJUvhp001154
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 19:30:57 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6KJU7Hx012610
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 15:30:07 -0400
Message-ID: <4A64C5B8.8000602@redhat.com>
Date: Mon, 20 Jul 2009 15:30:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Christopher Pardy <cpardy@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: adding human understandable, and translatable description support
 to selinux
References: <4A648075.3090402@redhat.com> <1248110839.23783.721.camel@gorn>	 <4A64ADA3.6020105@redhat.com> <1248114027.23783.725.camel@gorn> <4A64B6D4.6070205@redhat.com>
In-Reply-To: <4A64B6D4.6070205@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently we need to be able to define and update user descriptions via modules or semanage

# semanage user -a -R unconfined_r -D'All powerfull user' dwalsh


Similarly we need to be able to define new booleans in policy modules and have the description show up.  We also want the massive policy update that ships the policy.xml not to hammer over the custom updates made by the user or any third party policies he installed.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
