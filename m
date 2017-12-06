Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB6ENcvJ009385
 for <selinux@tycho.nsa.gov>; Wed, 6 Dec 2017 09:23:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 3ysLMy2xKrzJnFV
 for <selinux@tycho.nsa.gov>; Wed,  6 Dec 2017 14:19:26 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 3ysLMx0h1RzJnF5
 for <selinux@tycho.nsa.gov>; Wed,  6 Dec 2017 14:19:25 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id f20so4409017lfe.3
 for <selinux@tycho.nsa.gov>; Wed, 06 Dec 2017 06:16:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206124638.GD3328@localhost.localdomain>
References: <20171206101736.3217-1-richard_c_haines@btinternet.com>
 <20171206124638.GD3328@localhost.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Dec 2017 09:15:06 -0500
Message-ID: <CAHC9VhTXRzkVR2V809chUCSHtV6a3Po9ay6cVDeGVcohDz0DGw@mail.gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V2] selinux: Add SCTP support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 6, 2017 at 7:46 AM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Wed, Dec 06, 2017 at 10:17:36AM +0000, Richard Haines wrote:
>> The SELinux SCTP implementation is explained in:
>> Documentation/security/SELinux-sctp.rst
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>> V2 Changes
>> Remove lock from selinux_sctp_assoc_request()
>> Fix selinux_sctp_sk_clone() kbuild test robot catch [1]
>>
>> [1] https://marc.info/?l=selinux&m=151198281817779&w=2
>>
>
> Is this patchset going in via netdev tree or selinux one?
> I see Dave is tracking the v1
> (http://patchwork.ozlabs.org/patch/841842/) so I'm thinking netdev but
> for netdev it would require a repost of the entire patchset, even if
> the first ones weren't changed.

This should go in via the SELinux tree, although I would like to see
ACKs from Dave and/or other netdev folks for the core stack bits.

-- 
paul moore
www.paul-moore.com
