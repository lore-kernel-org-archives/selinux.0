Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8KGI430019440
 for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2017 12:18:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id q132so1624780lfe.4
 for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2017 09:09:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTfvOLw-v8ZbEhCkKn3FR9C5SzPS6kdz3w=fWxEGBAF1w@mail.gmail.com>
References: <1504691419-26972-1-git-send-email-kyeongdon.kim@lge.com>
 <CAHC9VhTfvOLw-v8ZbEhCkKn3FR9C5SzPS6kdz3w=fWxEGBAF1w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Sep 2017 12:09:16 -0400
Message-ID: <CAHC9VhSowi09zxj6bihnr3qLzt4MEsL3fY7y3Dcj50v8VNc0xg@mail.gmail.com>
To: Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 elfring@users.sourceforge.net, danielj@mellanox.com,
 junil0814.lee@lge.com, mka@chromium.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Use kmem_cache for hashtab_node
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 7, 2017 at 7:18 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Sep 6, 2017 at 5:50 AM, Kyeongdon Kim <kyeongdon.kim@lge.com> wrote:
>> During random test as own device to check slub account,
>> we found some slack memory from hashtab_node(kmalloc-64).
>> By using kzalloc(), middle of test result like below:
>> allocated size 240768
>> request size 45144
>> slack size 195624
>> allocation count 3762
>>
>> So, we want to use kmem_cache_zalloc() and that
>> can reduce memory size 52byte(slack size/alloc count) per each struct.
>>
>> Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
>> ---
>>  security/selinux/ss/hashtab.c  | 17 +++++++++++++++--
>>  security/selinux/ss/hashtab.h  |  4 ++++
>>  security/selinux/ss/services.c |  4 ++++
>>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> This seems reasonale, but I'm going to refrain from merging this until
> after the merge window closes.

I just merged this into selinux/next, thanks for your patience.

-- 
paul moore
www.paul-moore.com
