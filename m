Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P5u4j5030809
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 01:56:04 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P5u4rn008532
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 05:56:04 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6P5u4qi019186
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 01:56:04 -0400
Received: from pobox.bne.redhat.com (pobox.bne.redhat.com [10.64.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6P5u2Iq007609
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 01:56:03 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by pobox.bne.redhat.com (8.13.1/8.13.1) with ESMTP id m6P5u1HJ014900
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 15:56:01 +1000
Message-ID: <48896AEC.1060107@redhat.com>
Date: Fri, 25 Jul 2008 15:55:56 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: user_identify for httpd (warning: newbie question)
References: <488967D8.1020203@redhat.com>
In-Reply-To: <488967D8.1020203@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The subject should be "user_identity", and sorry for top posting.

Murray McAllister wrote:
> Hi,
> 
> On Red Hat Enterprise Linux 5 (policy-targeted), I run my main user 
> account as "user_u:system_r:unconfined_t". When I do a "sudo service 
> httpd start", httpd runs as "user_u:system_r:httpd_t".
> 
> On Fedora 9 (policy-targeted), I run my main user account as 
> "unconfined_u:unconfined_r:unconfined_t". When I do a "sudo service 
> httpd start", httpd runs as "unconfined_u:system_r:httpd_t".
> 
> "httpd.conf" is configured on each system to run as the user and group 
> "apache".
> 
> With regards to Fedora 9, am I doing something wrong? Is it okay for the 
> SELinux user to be "unconfined_u" for services?
> 
> Thanks for any advice,
> 
> Murray.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
