Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7R0mhKS022285
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 20:48:43 -0400
Received: from arlo.cse.psu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7R0mgXp020487
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 00:48:43 GMT
Received: from c-71-58-96-116.hsd1.pa.comcast.net ([71.58.96.116] helo=[192.168.11.5])
	by arlo.cse.psu.edu with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <tjaeger@cse.psu.edu>)
	id 1KY9DG-0001Fv-8k
	for selinux@tycho.nsa.gov; Tue, 26 Aug 2008 20:48:42 -0400
Mime-Version: 1.0 (Apple Message framework v753.1)
Message-Id: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: selinux@tycho.nsa.gov
From: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Socket and inode label consistency
Date: Tue, 26 Aug 2008 20:50:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I see on the Kernel Development To Do list at http:// 
selinuxproject.org/page/Kernel_Development that the following task is  
identified:

"Full APIs for getting and setting security contexts of sockets and  
IPC objects. Ensure that socket context is kept consistent on socket  
inode and sock structures when changed."

We are being bitten by this now, so I am wondering if anyone is  
working on it or wishes to discuss how to proceed.  We would be  
interested in addressing this issue.

Regards,
Trent.
----------------------------------------------
Trent Jaeger, Associate Professor
Pennsylvania State University, CSE Dept
346A IST Bldg, University Park, PA 16802
Email: tjaeger@cse.psu.edu
Ph: (814) 865-1042, Fax: (814) 865-3176




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
