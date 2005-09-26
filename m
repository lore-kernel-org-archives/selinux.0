Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8QKMXNs017501
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 16:22:33 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8QKHGbH008081
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 20:17:16 GMT
Message-ID: <4338580C.4010804@redhat.com>
Date: Mon, 26 Sep 2005 16:20:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: reserved_port_type attribute
References: <1127757038.32172.22.camel@sgc.columbia.tresys.com>
In-Reply-To: <1127757038.32172.22.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>According to attrib.te, reserved_port_type is supposed to be for ports
>that are less than 1024.  Why is reserved_port_t not included?  Also,
>http_cache_port_t, ptal_port_t, clamd_port_t, pyzor_port_t, and
>dbskkd_port_t aren't labeling any ports below 1024 (dbskkd_port_t
>doesn't even have a portcon), so why have they been given this
>attribute?
>
>  
>
They should not be.  Probably cut and paste errors.


portcon tcp 1-1023 system_u:object_r:reserved_port_t
Since a  portmap and friends are allowed to connect to any port that is 
not a  reserved_port_type, the above rule would
not allow portmap to use any ports less then 1023 I believe. 

It probably would not be a bad idea to prevent portmapper and freinds 
from connecting to any port that is defined.





-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
