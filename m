Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4UDkHp5020534
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 09:46:17 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4UDkFv3016711
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 13:46:16 GMT
Subject: Re: Use of type_change and type_transition declarations
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <447b3031.200d0097.6f44.118c@mx.gmail.com>
References: <447b3031.200d0097.6f44.118c@mx.gmail.com>
Content-Type: text/plain; charset=iso-8859-7
Date: Tue, 30 May 2006 09:47:03 -0400
Message-Id: <1148996823.14262.105.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-29 at 19:32 +0200, Mario Fanelli wrote:
> I don¢t understand what means type_change declaration. 
> 
> Anyone can give me an explanation? What are the difference between
> type_change and type_transition declarations? 
> 
> If I declare a type_transition like type_transition dom1_t
> dom2_exec_t:process dom2_t, why I have to use an allow rule?

type_change is information that userland programs use for relabeling
(retrieved by security_compute_relabel()), it does not do anything by
itself.  The current use of type_change is to tell login programs what
label the user's terminal should be relabeled to.

type_transition changes the default type when a new object is created,
it does not allow access.  The default type is the type of the
container; for example, a file's default type is the type of the
directory it is being created in.  When used on processes like your
example above, dom1_t will exec() dom2_exec_t and the new process will
be in dom2_t, assuming the transition is allowed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
