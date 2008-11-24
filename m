Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAOIb0Z1028857
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 13:37:00 -0500
Received: from mho-01-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAOIb0bP029035
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 18:37:00 GMT
Cc: SE-Linux <selinux@tycho.nsa.gov>
Message-Id: <0D8D31CA-7C10-42B3-B880-5A7684C018FF@nall.com>
From: Joe Nall <joe@nall.com>
To: Andy Warner <warner@rubix.com>
In-Reply-To: <492ADD56.1050403@rubix.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: externally usable interfaces from 3rd party policy modules
Date: Mon, 24 Nov 2008 12:36:55 -0600
References: <492ADD56.1050403@rubix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Nov 24, 2008, at 10:59 AM, Andy Warner wrote:

> Is it possible to create a policy module, install it, and have its  
> interfaces usable by other policy modules? In creating DBMS policy I  
> would like to provide a high level interface to the DBMS user/ 
> developer that will allow them to create their site-specific DBMS  
> policy in a modular fashion. At the same time I do not want to  
> encourage them to directly edit the "base policy" for the DBMS.
>
> In my attempt I simply created my "DBMS base policy" and installed  
> it. I then created a "DBMS local policy" that uses interfaces from  
> the DBMS base policy. The DBMS local policy fails to compile,  
> failing at the first reference to an external interface. If I place  
> all of the policy code in the DBMS base policy, everything works.  
> Therefore, I am guessing that either there is no way to make the  
> DBMS base policy interfaces externally usable or I need to perform  
> an extra step that I am no aware of.
>
> I realize I could modify the base fedora 9 policy and add my module,  
> but this has been ruled out as an option.

You need to install the .if file for your base DBMS policy in /usr/ 
share/selinux/devel/include/MYPROJECT/

joe

>
>
> As a side question, is it possible to generate the HTML "policy  
> help" for my modules interfaces?
>
> Thanks,
>
> Andy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
