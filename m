Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88JSnnS031336
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:28:49 -0400
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88JS2eD010966
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 19:28:02 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k88JSm3s001913
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 15:28:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k88JSmcc234882
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:28:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k88JSlm5007674
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:28:48 -0600
Message-ID: <4501C466.7060309@us.ibm.com>
Date: Fri, 08 Sep 2006 14:28:38 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: lspp-list <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Re: MLS Policy (rawhide)
References: <4500906A.3000502@us.ibm.com> <4501B1B1.4020103@redhat.com>
In-Reply-To: <4501B1B1.4020103@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Michael C Thompson wrote:
>> Hey all,
>>
>> It seems that ssh is unable to add entries to known_hosts for the root 
>> user as sysadm_t. Is this a known issue? And if so, who can add 
>> entries to /root/.ssh/known_hosts ?
>>
>> Thanks,
>> Mike
>>
> This works for me.  How is the file labeled?

# ls -alZ /root/.ssh
drwx------  root root root:object_r:user_home_ssh_t:SystemLow .
drwxr-x---  root root 
root:object_r:sysadm_home_dir_t:SystemLow-SystemHigh ..
-rw-------  root root root:object_r:bin_t:SystemLow    id_rsa
-rw-r--r--  root root root:object_r:bin_t:SystemLow    id_rsa.pub
-rw-r--r--  root root root:object_r:user_home_ssh_t:SystemLow known_hosts


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
