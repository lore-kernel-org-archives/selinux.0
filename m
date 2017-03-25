Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2PFcDwG029888
 for <selinux@tycho.nsa.gov>; Sat, 25 Mar 2017 11:38:14 -0400
Received: by mail-vk0-f45.google.com with SMTP id s68so15707992vke.3
 for <selinux@tycho.nsa.gov>; Sat, 25 Mar 2017 08:38:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eb71602a-3bb8-a643-5926-9d23aa2798ba@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <7fdcfc8f-affa-fcf8-adaf-dc8fd9e1b472@users.sourceforge.net>
 <CAHC9VhSfvsoWCD1DHFPYhnmWx_cmmapo6vjboS8e=6OZ8ca9gA@mail.gmail.com>
 <eb71602a-3bb8-a643-5926-9d23aa2798ba@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 25 Mar 2017 11:38:11 -0400
Message-ID: <CAHC9VhSCq=Qqwh7z5mAhMNA6ELUa8nvNoX2cuXtuSJGCf1gThA@mail.gmail.com>
Subject: Re: selinux: Move some assignments for the variable "rc" in
 policydb_read()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
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

On Fri, Mar 24, 2017 at 6:09 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> One local variable was set to an error code in some cases before
>>> a concrete error situation was detected. Thus move the corresponding
>>> assignments into if branches to indicate a software failure there.
>>>
>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>> ---
>>>  security/selinux/ss/policydb.c | 59 +++++++++++++++++++++++++-----------------
>>>  1 file changed, 35 insertions(+), 24 deletions(-)
>>
>> More code churn with no real advantage.
>
> There are different opinions about the mentioned implementation details.
>
>> I agree with the style you are using,
>
> Thanks for such feedback.
>
>> and would support changing it if you are in the function fixing bugs
>> or doing other substantial changes in that code,
>
> Is this expectation a contradiction for a desired patch granularity?
>
>> but I can't justify it as a standalone change, sorry.
>
> This update suggestion seems to be not attractive enough for you at the moment
> as another change step of my patch series.
> Would you like to check if there are other effects worthwhile besides the proposed
> coding style adjustment here?

To be honest, I would just leave it alone for now.  If you want to
contribute, focus on meaningful improvements such as bug fixing and/or
new features; changing only the code style isn't very interesting or
appealing, even if I happen to agree with your changes.

-- 
paul moore
www.paul-moore.com
