Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2HDKKDo014614
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 08:20:20 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2HDE9te019397
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 13:14:09 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j2HDFcVp027404
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 08:15:38 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j2HDFcuq027403
	for selinux@tycho.nsa.gov; Thu, 17 Mar 2005 08:15:38 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2HDBcDo014553
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 08:11:43 -0500 (EST)
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2HD5Ote018727
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 13:05:26 GMT
Message-ID: <423980AC.60409@ak.jp.nec.com>
Date: Thu, 17 Mar 2005 22:05:48 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <200503162131.j2GLVU8R025568@gotham.columbia.tresys.com>
In-Reply-To: <200503162131.j2GLVU8R025568@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

 > I'm not certain that you understand my objection. I'm not suggesting that your
 > patch conflicts with this idea, I think that we should not make this type of
 > language change unless it address a broad set of issues, which to me includes
 > this group of types usage scenario. The EXTENDS syntax seems, to me, to have a
 > fairly narrow usage similar to clone rules. The clone rules were ultimately
 > dropped so I don't think that we should go down that path again without major
 > additional advantages. In other words, I saying that I think handling the group
 > of types usage scenario is a requirement to this type of language extension.

There are some difference between the EXTENDS syntax and CLONE.
First, CLONE can't emulate multiple-parents inheritance. This is useful and
interresting character. Second, CLONE doesn't have a selective permission
grant syntax. I'm willing to implement selective permission grant syntax
such as '@' prefix.
What CLONE was dropped is not appropriate for the reason of this issue.

I feel this discussion fall into "discussion for discussion", so it's not
productive. You should make your target image clear, and express your modeling.
I can't compare practical functionality with vague images.

 > As I stated above, my example requires the attributes to be applied to
 > user/staff_ssh_t. This to me does not seem to be a major drawback - in fact it
 > gives more control to the policy author.

Needless to say, the EXTENDS syntax does not prevent to apply any attributes.
In addition, your approach may be harmless, but opportunity benefit
as union-filetype will be lost if EXTENDS syntax is denied.

BTW, If we can control the access permission between 'group of type' and
union-filetype, it may be so flexible.
i.e. "Right man in the right place"

Thanks,
--
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
