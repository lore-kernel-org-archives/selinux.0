Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14669
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 08:35:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA17469
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 12:35:22 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id MAA17465
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 12:35:20 GMT
Message-ID: <3D2D7BA1.2010304@evoworks.evoserve.com>
Date: Thu, 11 Jul 2002 20:35:45 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: automatic type transitions for pts in devfs
References: <Pine.GSO.4.33.0207110817300.822-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 11 Jul 2002, Debian User wrote:
>
>  
>
>>my patch works with russell's devfsd-se.so disabled. just remove any selinux*
>>file in /etc/devfs/conf.d. i will see if removing only the pts entry in the selinux
>>conf.d file will work.
>>    
>>
>
>This makes sense.  As long as devfsd does not intercept the registration
>of pts nodes and perform a lookup at that time, your patch should work for
>labeling pts nodes with transition SIDs.
>
>This is good, as it removes the immediate need to patch devfsd.  However,
>it will still be necessary to patch the kernel devfs code to preserve SIDs
>on devfs entries when they are evicted from the dcache.
>
The system im building from scratch is working perfectly booting in 
enforcing mode without devfsd. I am fine tuning the policy now.

Im having a problem with my X Window devpts entries.  The task sid when 
X Window creates a pty is xdm_t. What should the proper type be? Ssh 
works perfectly now in enforcing mode. X stops when I switch to 
enforcing mode. What are the type transitions when gdm starts X window?

>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>  
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
