Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBVAYiGH001888
	for <selinux@tycho.nsa.gov>; Sat, 31 Dec 2011 05:34:45 -0500
Received: from mail-ee0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBVAYhbQ008349
	for <selinux@tycho.nsa.gov>; Sat, 31 Dec 2011 10:34:43 GMT
Received: by eekd41 with SMTP id d41so14148879eek.12
        for <selinux@tycho.nsa.gov>; Sat, 31 Dec 2011 02:34:42 -0800 (PST)
Date: Sat, 31 Dec 2011 11:34:15 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: transition from crond
Message-ID: <20111231103415.GA3510@siphos.be>
References: <20111230185146.GY10436@tracyreed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111230185146.GY10436@tracyreed.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 30, 2011 at 10:51:47AM -0800, Tracy Reed wrote:
> email2feedback.te:
> 
> policy_module(email2feedback, 1.0.0)
> type email2feedback_t;
> type email2feedback_exec_t;
> 
> require {
>         type automated_tasks_db_t;
> }
> 
> domain_type(email2feedback_t)
> domain_entry_file(email2feedback_t, email2feedback_exec_t)
> 
> allow email2feedback_t automated_tasks_db_t:file { read getattr ioctl };
[...]
> # Let it switch from crond_t to email2feedback_t
> ifdef(`crond.te', `
>     system_crond_entry(email2feedback_exec_t, email2feedback_t)
>     ')

This seems wrong. There's no need for an "ifdef" here. 

You probably want something like the following in your .te file:

optional_policy(`
	cron_system_entry(email2feedback_t, email2feedback_exec_t)
')

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
