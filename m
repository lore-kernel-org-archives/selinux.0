Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k45GRQ3k021126
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 12:27:26 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k45GRQe6021971
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 16:27:26 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id D433036499
	for <selinux@tycho.nsa.gov>; Fri,  5 May 2006 12:27:25 -0400 (EDT)
Received: from [16.116.96.193] (flek.zko.hp.com [16.116.96.193])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 2904A152C3
	for <selinux@tycho.nsa.gov>; Fri,  5 May 2006 16:27:25 +0000 (UTC)
Message-ID: <445B7CEC.1020106@hp.com>
Date: Fri, 05 May 2006 12:27:24 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Network access controls (resolving xfrm, secmark, and NetLabel)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Over on the RedHat LSPP list I have been posting my NetLabel patches (if 
you don't know what they are keep reading) and in the latest round of 
patches it became clear that it is probably worthwhile to have a 
discussion about how to best resolve all of the different network access 
controls.  Stephen suggested this list would be a good place to start so 
here I go.

 From what I gather no one seems to be a big fan of the current network 
access checks in the SELinux code.  They are not very expressive and the 
  recent work to include packet labeling through other methods such as 
IPsec and now NetLabel (CIPSO/RIPSO/etc.) means the SELinux network 
access checks are going to get more and more confusing as more checks 
are added.  I think everybody would like to see the network access 
checks reduced to a single function call.  The question is how.

The IPsec/xfrm controls do all the access control checks at the IP/xfrm 
layer (please correct me if I'm wrong) so checking for access at the 
socket layer where the current LSM hooks are is almost trivial, all you 
have to do is look at a field in the packet to see if the xfrm code 
authorized the packet.

The secmark approach proposed by James a few weeks ago on the netdev 
list labels the packets with a SELinux SID in the IP/netfilter layer and 
checks the SID in the socket layer using the existing LSM hooks.  While 
this is still very much a work in progress the ultimate goal is to 
remove the individual netif/host/port checks in the SELinux code and 
replace them with a single socket/secmark SID access check.  James' 
secmark announcement can be found here:

  * http://marc.theaimsgroup.com/?l=linux-netdev&m=114516429530333&w=2

The NetLabel approach is similar to the secmark approach in that 
NetLabel only attaches/retrieves labels from the network packets and 
lets SELinux perform the access checks.  The immediate goal for NetLabel 
is to provide support for explicit packet labeling protocols such as 
CIPSO/RIPSO.  Also, just recently there has been some interest in using 
NetLabel in a non-SELinux LSM.  The NetLabel patches can be found here:

  * http://free.linux.hp.com/~pmoore/projects/linux_cipso

These are the three approaches (am I missing any?) I think we need to 
resolve.  I also think it would be a good idea if we arrived at a 
solution which abstracts out the actual packet labeling as much as 
possible; this would allow us to add/subtract labeling mechanisms much 
more easily than we can do now.  Further, adding a layer of abstraction, 
if done correctly, would allow other LSMs to utilize the same mechanism 
(I know this may not be very popular here, but I think it would be A 
Good Thing).  Looking at the three approaches above I'm not sure the 
IPsec/xfrm approach is generic enough to support the different types of 
labeling.  This leaves me with either the secmark or the NetLabel approach.

The two approaches, secmark and NetLabel, are very similar and I believe 
quite complimentary.  Further I think it would be rather easy to 
implement either secmark inside of NetLabel or NetLabel inside of 
secmark.  However, of the two I think NetLabel is best suited to 
accommodate both the secmark and IPsec/xfrm access controls.  The 
secmark approach requires the labeling mechanism to live inside the 
netfilter code (correct James?) while the NetLabel approach allows the 
labeling mechanism to happen anywhere it can, in the xfrm transforms, 
netfilter, you name it.  NetLabel also has provisions for labeling 
outgoing packets where I'm not sure secmark does (I didn't think you 
could increase a packet's size in netfilter, can you?).  However, I'll 
be honest in that I'm probably not 100% objective here; I'm just trying 
to start a discussion.

So, anybody else have an opinion?  Come on, I know you do ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
