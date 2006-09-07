Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87HxMXU021691
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 13:59:22 -0400
Received: from bay0-omc2-s12.bay0.hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87HwwDY016266
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:58:59 GMT
Message-ID: <BAY114-F17D2660BD6C3262245D6CEAF360@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: Problems with the MLS policy
Date: Thu, 07 Sep 2006 19:59:16 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have Fedora Core 6 Test 1 (it's the VMware image found 
here:http://www.thoughtpolice.co.uk/vmware/), I installed the package 
selinux-policy-mls-2.3.9-3. So, I now can switch to the "mls", in theory. 
The problem is that there's no binary policy file in 
/etc/selinux/mls/policy; so, I tough "I must compile it by myself", but in 
/usr/devel/selinux/mls there aren't source files (there are only sources for 
the targeted policy), only a lot of .pp files...
Where can I find those sources, or the rpm with them? And, where can I find 
more information to the classification system used (I didn't understand what 
those "SystemLow-SystemHigh" stand for)?
Thanks a lot

_________________________________________________________________
Scarica gratuitamente MSN Toolbar! http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
