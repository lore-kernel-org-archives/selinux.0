Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5E4ep5u024026
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 00:40:51 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5E4e0J3026852
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 04:40:01 GMT
Message-ID: <4C15B285.9050409@ak.jp.nec.com>
Date: Mon, 14 Jun 2010 13:39:33 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Frost <sfrost@snowman.net>
CC: Xavier Toth <txtoth@gmail.com>, Greg Smith <greg@2ndquadrant.com>,
        SELinux <selinux@tycho.nsa.gov>, Robert Haas <robertmhaas@gmail.com>
Subject: Re: Report of PGcon2010
References: <4C11CE43.7000509@ak.jp.nec.com> <4C125496.1060107@2ndquadrant.com> <20100611154117.GS21875@tamriel.snowman.net> <AANLkTimUrgvWLr0A8dorFZ1TTrT4YZDj6M7pNHNs1L_A@mail.gmail.com> <20100611161255.GT21875@tamriel.snowman.net>
In-Reply-To: <20100611161255.GT21875@tamriel.snowman.net>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/06/12 1:12), Stephen Frost wrote:
> * Xavier Toth (txtoth@gmail.com) wrote:
>> Is there any hope for some sort of Common Criteria
>> testing/certification of SELinux PostgreSQL?
> 
> I think it would need someone to sponsor it/the work involved..  I'm not
> sure what changes, if any, would be needed to the system to support
> that.  I definitely think it'd be great if it happened.
> 

>From perspective of the functionalities, eventually, it shall provide
label based data flow control features, such as Oracle Label Security,
but the development cycle is going to be incremental.
So, it is impossible to release complete features at once.

>From perspective of the sponsorship, it shall become a next theme to
the development of functionalities. Of course, I have an intention to
encourage our company to fund the certification.
However, it is the least prerequisite that SELinux module will perform
on the upstreamed PostgreSQL.

Hence, it is a long term theme for us, but it will be hopeful.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
