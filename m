Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NM5a6p007460
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 18:05:36 -0400
Received: by mail-vk0-f66.google.com with SMTP id d188so21808481vka.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 15:05:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55f62ee9-9e98-f5e0-67eb-fc7aa5cbe8f8@schaufler-ca.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <dbd8e89d-45a1-5785-f2dd-673389ac01a3@users.sourceforge.net>
 <a9983d7d-e1f7-8f85-f696-107cf32160ef@schaufler-ca.com>
 <60ed4f02-4ff8-2ef2-bcc3-ae62bc61cda9@users.sourceforge.net>
 <55f62ee9-9e98-f5e0-67eb-fc7aa5cbe8f8@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 18:05:29 -0400
Message-ID: <CAHC9VhTtxZsUyWDga4tZC0hEUO3L8s0jFqy9L=TWqZiHts5=eQ@mail.gmail.com>
Subject: Re: [PATCH 15/46] selinux: One check and function call less in
 genfs_read() after error detection
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 17, 2017 at 12:53 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 1/17/2017 8:37 AM, SF Markus Elfring wrote:
>>>> @@ -2015,7 +2015,7 @@ static int genfs_read(struct policydb *p, void *fp)
>>>>             newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
>>>>             if (!newgenfs) {
>>>>                     rc = -ENOMEM;
>>>> -                   goto out;
>>>> +                   goto exit;
>>>>             }
>>>>
>>>>             rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
>>>> @@ -2101,7 +2101,7 @@ static int genfs_read(struct policydb *p, void *fp)
>>>>             kfree(newgenfs);
>>>>     }
>>>>     ocontext_destroy(newc, OCON_FSUSE);
>>>> -
>>>> +exit:
>>>>     return rc;
>>> Why not replace the "goto out" with "return rc" rather
>>> than add a target?
>> Would you accept to use the statement "return -ENOMEM;" there instead?
>
> That would be even better.

I *hate* code that does a jump to a label only to then do a
return/exit.  That said, see my earlier comments about not worrying
too much about performance of the error path and in this case I like
the "feel good" nature of the code where ever failure in the loop goes
to "out".

-- 
paul moore
www.paul-moore.com
