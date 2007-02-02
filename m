Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l12H1dsa030389
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 12:01:40 -0500
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l12H2hJx024346
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 17:02:44 GMT
From: Paul Moore <paul.moore@hp.com>
To: Catalin DIMA <dima@univ-paris12.fr>
Subject: Re: DWARF2 [was : Problems installing refpolicy with FC6]
Date: Fri, 2 Feb 2007 12:02:24 -0500
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
References: <45BE44FC.8080303@univ-paris12.fr> <45BF5BB1.1010603@mentalrootkit.com> <45C363A6.8000703@univ-paris12.fr>
In-Reply-To: <45C363A6.8000703@univ-paris12.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702021202.24412.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, February 2 2007 11:15 am, Catalin DIMA wrote:
> Having a little more time to try to solve the problem, I checked again
> several solutions, especially the following :
> - relabeled file system
> - rebooted without X in refpolicy, _permissive_ mode
> and got a pretty looking DWARF2 unwinding... >:-(
> As I never encountered such debugging problems, can someone tell me how
> could I "catch it" in some logfile, at least to post it  ? there's no
> trace of the debugging information in either dmesg or messages.

Hi Catalin,

Just to be certain, you are still doing a "targeted-mcs" policy build yes?  
The only reason I ask is that there is a known problem (my fault :( )with the 
standard FC6 kernels with SELinux policies that do not use MCS or MLS.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
