Subject: Re: conditional. policy does not take effect.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <164692.56209.qm@web86903.mail.ukl.yahoo.com>
References: <164692.56209.qm@web86903.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 08:26:59 -0400
Message-Id: <1175862419.17676.22.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-06 at 09:34 +0000, JanuGerman wrote:
> Hi every one,
> 
>   My cond. policies are not taking effect. Following are the contents of my lodable policy module.
> 
> policy_module(myapp,1.0)  
> require {
>         type unconfined_t;
>         type fs_t;
> }
> type x_t;
> bool test true;
> auditallow x_t fs_t:filesystem associate;
> if (test) {
>     auditallow unconfined_t x_t:dir *;
>     auditallow unconfined_t x_t:file *;
> } else {
>       auditallow unconfined_t x_t:dir { getattr read search };
>       auditallow unconfined_t x_t:file {getattr };
> }

auditallow does not allow anything.  It makes audit messages when
something is allowed.  You need an allow message too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
