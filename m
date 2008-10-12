Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9CNIxSl012882
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 19:18:59 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9CNIxZf026040
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 23:18:59 GMT
Message-ID: <48F285B2.90008@manicmethod.com>
Date: Sun, 12 Oct 2008 19:18:10 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Capabilities audit field
References: <200810120907.07511.sgrubb@redhat.com>
In-Reply-To: <200810120907.07511.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> Hi,
>
> I recenetly found out that the kernel now allows more than 32 capabilities. 
> This means I need to update the audit code that inteprets this value given 
> from SE Linux. When I looked over the 2.6.27 kernel code, I found that SE 
> Linux has not updated the capabilities code. Its still being kept as a simple 
> integer in avc.h, but everywhere else I look in the kernel has moved to 
> kernel_cap_t, which is an array. Are patches for moving to kernel_cap_t 
> scheduled for 2.6.28? Are there security implications for not being able to 
> access or control capabilities > 32?
>   

SELinux added an additional object class (capability2) so as to not 
extend the access vector.

The current object class looks like this:
class capability2
{
        mac_override    # unused by SELinux
        mac_admin       # unused by SELinux
}

We can control them but they should never be hit on an SELinux system 
anyway (IIUC)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
