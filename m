Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34FFQDo000515
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 11:15:27 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j34FAhis019617
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 15:10:43 GMT
Message-ID: <42515894.8030203@redhat.com>
Date: Mon, 04 Apr 2005 11:09:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: selinux@tycho.nsa.gov
Subject: Re: /dev/pts/x use denials
References: <1112569241.21383.37.camel@cobra.ivg2.net> <1112570031.23944.1.camel@cobra.ivg2.net>
In-Reply-To: <1112570031.23944.1.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>On Sun, 2005-04-03 at 19:00 -0400, Ivan Gyurdiev wrote: 
>  
>
>>Strange denials:
>>
>>/dev/pts/2 has context: sysadm_tmp_t.
>>Those happen intermittently, but I can't figure out when exactly.
>>I am logged in as a regular user, but su-ed to root. Usually accompanied
>>by a dac_override.
>>    
>>
>
>It's sometimes followed by a dac_override - not all the time.
>Here's something reproducible:
>
>If I su to root, launch tvtime/mplayer/whatever, then make load
>the selinux policy, I get use denial on /dev/pts. Then if I launch
>the same program - no use denial. Then I make load the policy again,
>launch program, and I get a use denial.
>
>  
>
If you are running in permissive mode, you only get the denial once.  
When you
reload the policy it clears the flag.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
