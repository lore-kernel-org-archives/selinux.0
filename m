Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l12HUQQ0031635
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 12:30:26 -0500
Received: from ultra1.univ-paris12.fr (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l12HVUJx000684
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 17:31:30 GMT
Message-ID: <45C37513.2030401@univ-paris12.fr>
Date: Fri, 02 Feb 2007 18:29:55 +0100
From: Catalin DIMA <dima@univ-paris12.fr>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: DWARF2 [was : Problems installing refpolicy with FC6]
References: <45BE44FC.8080303@univ-paris12.fr> <45BF5BB1.1010603@mentalrootkit.com> <45C363A6.8000703@univ-paris12.fr> <200702021202.24412.paul.moore@hp.com>
In-Reply-To: <200702021202.24412.paul.moore@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I actually forgot to remove the MLS_SENS declaration when configuring 
the policy : it used to declare 16 sensitivity levels with an MCS 
policy... :'(

Paul Moore wrote:

> Hi Catalin,
>
>Just to be certain, you are still doing a "targeted-mcs" policy build yes?  
>The only reason I ask is that there is a known problem (my fault :( )with the 
>standard FC6 kernels with SELinux policies that do not use MCS or MLS.
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
