Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GKBVMY003649
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:11:31 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5GKBUIg019463
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 20:11:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5GKBUxo012078
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:11:30 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5GKBTgc025506
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 16:11:29 -0400
Message-ID: <44931075.5070208@redhat.com>
Date: Fri, 16 Jun 2006 16:11:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: redhat-lspp@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [redhat-lspp] Got up at 5 AM, and thought I would try to write
 a new role
References: <44930D28.2010103@redhat.com> <200606161601.38912.sgrubb@redhat.com>
In-Reply-To: <200606161601.38912.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Friday 16 June 2006 15:57, Daniel J Walsh wrote:
>   
>> I wanted to try to create an auditadm_r.
>>     
>
> Didn't you mean httpdadm_r  :)
>
> I think we should bust up the systemadm role a little more and make it 
> composed of some other roles. RBAC says we are supposed to support 
> composition, so we can use it here.
>
> Some other roles might be backup admin, db admin. mail admin.
>
> -Steve
>   
backupadm might be pretty tough, since I don't believe we run type 
enforcement on any backup tools
so you would need to be able to read/write every file on the system, and 
I see little benefit in this.

dbadmin would have to be better defined.  IE MySQL/Postgresql/Oracle ...

ditto for mail admin. 

Now doing a namedadm_r would be fairly easy.
Maybe even a dhcpd admin, but I am not sure if there would be demand for 
those.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
