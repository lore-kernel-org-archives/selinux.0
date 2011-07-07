Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p67EJshG029391
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 10:19:54 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p67EJrt0024140
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 14:19:53 GMT
Message-ID: <4E15C088.4030903@tresys.com>
Date: Thu, 7 Jul 2011 10:19:52 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
CC: Dominick Grift <domg472@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Best base policy to use
References: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>	<1309932598.2498.28.camel@localhost.localdomain>	<CAJstirRb7dTEpk0eq+xP_HNBwfEcZ4BF6ftXBrtDLT50JQktHg@mail.gmail.com>	<1309961490.2323.8.camel@localhost.localdomain> <CAJstirTP4BvfX_2Gn-=ykYkgLdBW=gJhpf6n=qH-mJpMABGqrw@mail.gmail.com>
In-Reply-To: <CAJstirTP4BvfX_2Gn-=ykYkgLdBW=gJhpf6n=qH-mJpMABGqrw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/07/11 09:46, Jeremiah Jahn wrote:
> On Wed, Jul 6, 2011 at 9:11 AM, Dominick Grift <domg472@gmail.com
> <mailto:domg472@gmail.com>> wrote:
[...]
>     On Wed, 2011-07-06 at 08:59 -0500, Jeremiah Jahn wrote:
>     > for example lets say I didn't want rpm_script_t to be able to
>     > transition into initrc_t, no matter what role it started as. Or, I
>     > don't want the sysadm_t to be able to do both run_init_t and rpm_t. Or
>     > am I completely in left field and not understanding the proper use of
>     > roles?
> 
>     No, you can achieve that by editing the policy i believe.
> 
>     I would probably fork selinux policy. El6 policy does not get much
>     significant updates so merging changes into your fork should not be too
>     much work (as opposed to Fedora)
> 
> 
> Thanks for the help, that's what I had to do with the old ref policy, I
> guess I was just hoping I wouldn't have to do that again, because there
> was some newfangled way.  :) Oh well, but thanks again for the help.

Thats one thing on my wish list for SELinux policy writing tools.  A
role-o-matic where you start out with a base role, and have a bunch of
check boxes for options as to what it can do.  I try to keep the useful
data in the Refpolicy's XML, but the tool itself is nonexistent.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
