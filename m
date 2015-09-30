Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UF08jL028284
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 11:00:09 -0400
Received: by laclj5 with SMTP id lj5so49633105lac.3
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 08:00:06 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/5] selinux: use sprintf return value
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-6-git-send-email-linux@rasmusvillemoes.dk>
 <560AD5AF.4070400@tycho.nsa.gov>
Date: Wed, 30 Sep 2015 17:00:04 +0200
In-Reply-To: <560AD5AF.4070400@tycho.nsa.gov> (Stephen Smalley's message of
 "Tue, 29 Sep 2015 14:17:19 -0400")
Message-ID: <87zj04j6kr.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 29 2015, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
>> sprintf returns the number of characters printed (excluding '\0'), so
>> we can use that and avoid duplicating the length computation.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Thanks. I also like Joe's add-on suggestion (except I'd declare user,
role, type as const char*).

Rasmus
