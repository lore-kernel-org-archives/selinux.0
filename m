Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92M5Zcx025907
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 18:05:35 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k92M4P7a024335
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 22:04:26 GMT
Message-ID: <45217AF2.60701@redhat.com>
Date: Mon, 02 Oct 2006 16:47:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Default Mikefile in /usr/share/selinux/devel not nice
References: <451D8C2F.9040901@us.ibm.com>	 <1159590751.12161.10.camel@gorn.pebenito.net> <45212E39.9080105@us.ibm.com> <1159803204.14831.34.camel@sgc>
In-Reply-To: <1159803204.14831.34.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------020309010404070702060708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020309010404070702060708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Mon, 2006-10-02 at 10:20 -0500, Michael C Thompson wrote:
>   
>> Chris PeBenito wrote:
>>     
>>> On Fri, 2006-09-29 at 16:12 -0500, Michael C Thompson wrote:
>>>       
>>>> I just discovered a nasty surprise waiting for me in the default 
>>>> Makefile provided by selinux-policy-devel.
>>>>
>>>> Basically, the Makefile produces, on an MLS system, a TYPE value of 
>>>> mls-msc (this is due to the SELINUXTYPE=mls line in 
>>>> /etc/selinux/config). This will not 'enable_mls' for the M4FLAGS, 
>>>> because the Makefile in /usr/share/selinux/devel/include/ does a 
>>>> findstring for '-mls'.
>>>>
>>>> Dan Walsh has suggested a fix for the default Makefile, but I'm 
>>>> wondering why we can't just change 
>>>> /usr/share/selinux/devel/include/Makefile to do a $(findstring 
>>>> mls,$TYPE)) instead, since its not unreasonable to think that TYPE=mls 
>>>> makes sense.
>>>>         
>>> There is some confusion here, the SELINUXTYPE is not the same as TYPE in
>>> refpolicy, it is NAME in refpolicy.  The TYPE of the Redhat MLS policy
>>> is strict-mls.  TYPE=mls does not make sense, since it does not specify
>>> if the policy is strict or targeted.
>>>       
>> Are there flags (like 'enable_mls') in the policy which require this 
>> delineation?
>>     
>
> Yes, strict_policy and targeted_policy.
>
>   

The latest Makefile in 2.3.17-2 should work properly.



--------------020309010404070702060708
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

# installation paths
SHAREDIR := /usr/share/selinux

AWK ?= gawk
NAME ?= $(strip $(shell $(AWK) -F= '/^SELINUXTYPE/{ print $$2 }' /etc/selinux/config))

MLSENABLED := $(shell cat /selinux/mls)
ifeq ($(MLSENABLED),)
	MLSENABLED := 1
endif

ifeq ($(MLSENABLED),1)
	MCSFLAG=-mcs
endif

ifeq ($(NAME), mls)
	NAME = strict
	MCSFLAG = -mls
endif

TYPE ?= $(NAME)${MCSFLAG}
HEADERDIR := $(SHAREDIR)/devel/include
include $(HEADERDIR)/Makefile


--------------020309010404070702060708--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
