Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LDTHdW017405
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 08:29:17 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LDRA3J027289
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:27:11 GMT
Message-ID: <4219E14F.1070802@redhat.com>
Date: Mon, 21 Feb 2005 08:25:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: selinux@tycho.nsa.gov
Subject: Re: Mozilla vs ORBit tmp files
References: <1108910937.3610.22.camel@cobra.ivg2.net>
In-Reply-To: <1108910937.3610.22.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>Hi,
>
>Mozilla was recently changed in the Fedora policy
>to prevent writing to user_tmp_t. However that introduced
>the following regression:
>
>audit(1108909606.145:0): avc:  denied  { write } for  pid=3830
>exe=/usr/lib/firefox-1.0/firefox-bin name=linc-fd0-0-5891c0341b10d
>dev=dm-0 ino=827446 scontext=user_u:user_r:user_mozilla_t
>tcontext=user_u:object_r:user_tmp_t tclass=sock_file
>
>Should it be changed back? 
>
>The original suggestion was to transition mozilla to user_mozilla_tmp_t,
>but file_auto_trans() only works for creating new files, while here
>mozilla is using existing sockets in /tmp/orbit-username.  
>
>  
>
I will add the following back in.
allow user_mozilla_t user_tmp_t:sock_file rw_file_perms;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
