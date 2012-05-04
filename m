Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44Dmdqv029135
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 09:48:39 -0400
Received: by lbbgk8 with SMTP id gk8so2218901lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 04 May 2012 06:48:39 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 4 May 2012 15:48:39 +0200
Message-ID: <CADyhKSVyfCxx9dAziaR0bcbPvXW4C6FnV4J-Jux7gaMrT+-L+g@mail.gmail.com>
Subject: regression test of security policy
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

Does anyone have a tool to run regression test when we construct a patch?
(Or, is it available to construct using existing tools?)

Right now, I have to replace a working policy by the modified one whenever
I prepare to submit a patch towards reference policy. However, the default
security policy of Fedora is optimized to Fedora environment, thus, it often
mismatch with the latest upstream policy.
For example, "allow_execmem" is not defined at Fedora, so, I could not
load the staff.pp being constructed based on the upstream policy

So, the solution I'm looking for is a tool that loads a monolithic policy and
checks its access control decision towards a certain pair of subject context
and target context according to catalog files, then it prints the result of
diff commands between the computed one and expected one.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
