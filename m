Date: Mon, 17 Dec 2001 07:53:56 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: two different domains from on program
In-Reply-To: <3C1D909C.6070805@pcez.com>
Message-ID: <Pine.GSO.4.33.0112170746320.10438-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 16 Dec 2001, Shaun Savage wrote:

> I have a question.
>
> courier has one program the has two different usage. I would like one
> program to transistion into two different domains depending on the
> starting domain.
>
> domain_auto_trans(domain1, exec_file_t, domain2)
> domain_auto_trans(domain3, exec_file_t, domain4)
>
> where the context of the executable file is exec_file_t

So, what's the question?  Notice that there are examples of this behavior
in the example policy.  For example, initrc_t transitions to sendmail_t
when running sendmail_exec_t for the daemon process, user_t transitions to
user_mail_t when running sendmail_exec_t for sending mail, and sysadm_t
transitions to sysadm_mail_t when running sendmail_exec_t for sending
mail.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
