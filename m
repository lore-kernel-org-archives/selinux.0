Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBUIppBN002484
	for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2011 13:51:55 -0500
Received: from mail.copilotco.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBUIpnF9024650
	for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2011 18:51:50 GMT
Received: from tracyreed.org (mail.copilotco.com [10.0.2.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.copilotco.com (Postfix) with ESMTP id 94E0964C3E
	for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2011 10:51:48 -0800 (PST)
Date: Fri, 30 Dec 2011 10:51:47 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: transition from crond
Message-ID: <20111230185146.GY10436@tracyreed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to write policy to constrain a perl program called
email2feedback.pl which runs from cron on CentOS 5.7. It persists in running in
scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 despite the following policy.
I suspect I have incorrectly configured the transition in email2feedback.if.
Any tips?

# ls -laZ /automated_tasks/email2feedback.pl
-rwxrwxr-x  root treed system_u:object_r:email2feedback_exec_t:s0 /automated_tasks/email2feedback.pl



email2feedback.fc:

/automated_tasks/email2feedback.pl              --      gen_context(system_u:object_r:email2feedback_exec_t,s0)




email2feedback.te:

policy_module(email2feedback, 1.0.0)
type email2feedback_t;
type email2feedback_exec_t;

require {
        type automated_tasks_db_t;
}

domain_type(email2feedback_t)
domain_entry_file(email2feedback_t, email2feedback_exec_t)

allow email2feedback_t automated_tasks_db_t:file { read getattr ioctl };




email2feedback.if:

interface(`email2feedback_domtrans',`
        gen_require(`
                        type email2feedback_t, email2feedback_exec_t;
                                ')

                domain_auto_trans($1,email2feedback_exec_t,email2feedback_t)

                        allow $1 email2feedback_t:fd use;
                                allow email2feedback_t $1:fd use;
                                ')

# Let it switch from crond_t to email2feedback_t
ifdef(`crond.te', `
    system_crond_entry(email2feedback_exec_t, email2feedback_t)
    ')


-- 
Tracy Reed

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
