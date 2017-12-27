Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBRKZp3A006186
 for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2017 15:35:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3z6PkY3qrDz1pJTr
 for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2017 20:35:49 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3z6PkY394Fz1pJQv
 for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2017 20:35:49 +0000 (UTC)
Received: by mail-lf0-f49.google.com with SMTP id m20so30269250lfi.6
 for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2017 12:35:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514391741.2780.4.camel@btinternet.com>
References: <cover.1513940757.git.marcelo.leitner@gmail.com>
 <80e6a4fb06ec6b8f81577abd11827d75dd6689ce.1513940757.git.marcelo.leitner@gmail.com>
 <50a04eaf-6130-74d0-43e4-b09bd4de2180@schaufler-ca.com>
 <20171222174510.GB6123@localhost.localdomain>
 <1514391741.2780.4.camel@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Dec 2017 15:35:46 -0500
Message-ID: <CAHC9VhRbc7e+r_5NSaw0JCOnHbzvz0YHFbTFNgomY3=AebnSnw@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3 1/4] security: Add support for SCTP security
 hooks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 27, 2017 at 11:22 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2017-12-22 at 15:45 -0200, Marcelo Ricardo Leitner wrote:
>> On Fri, Dec 22, 2017 at 09:20:45AM -0800, Casey Schaufler wrote:
>> > On 12/22/2017 5:05 AM, Marcelo Ricardo Leitner wrote:
>> > > From: Richard Haines <richard_c_haines@btinternet.com>
>> > >
>> > > The SCTP security hooks are explained in:
>> > > Documentation/security/LSM-sctp.rst
>>
>> Thanks Casey for your comments. However, I'm not that acquainted with
>> these area of codes and I cannot work on them. I'll just wait for
>> Richard then.
>
> I'm back online and will post a V4 set of patches within a week. These
> will address Paul's comments as per [1] and Casey's regarding the
> documentation.
> Sorry for the delay

No worries, thanks.

-- 
paul moore
www.paul-moore.com
