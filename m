Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w17JudFW002187
 for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2018 14:56:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zcBsx5K8Lz19Yv6
 for <selinux@tycho.nsa.gov>; Wed,  7 Feb 2018 19:56:37 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zcBsx4XSSz19Yts
 for <selinux@tycho.nsa.gov>; Wed,  7 Feb 2018 19:56:37 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id t79so3100065lfe.3
 for <selinux@tycho.nsa.gov>; Wed, 07 Feb 2018 11:56:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518025709.16883.48.camel@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-2-sds@tycho.nsa.gov>
 <CAHC9VhTGF6_zP46tP3JdWna2_7BJ+oD0eKccmAhy3xXdfeRZ_w@mail.gmail.com>
 <1518025709.16883.48.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2018 14:56:34 -0500
Message-ID: <CAHC9VhTt1GZeDuhacdMbF9J9q3xndqVO=k4UqQT6v_n_Cq3vrA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC 01/10] selinux: introduce a selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 7, 2018 at 12:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2018-02-06 at 17:18 -0500, Paul Moore wrote:

...

>> While I don't think we need to tackle this as part of the
>> encapsulation work, this is another reminder that we should look into
>> breaking the separation between the security server and the
>> Linux/hooks code.  I understand there were historical reasons for
>> this
>> split, but I think all of those reasons are now gone, and further I
>> think enough Linux'isms have crept into the security server that the
>> separation is no longer as meaningful as it may have been in the
>> past.
>
> I think we want to retain some degree of encapsulation of the policy
> logic and data structures, which is what the security server is
> supposed to provide.  That allows us to evolve that logic and
> structures without impacting the object label management and permission
> enforcement code.  Separation of policy from mechanism.  I don't mind
> nativizing the security server for Linux, and where appropriate,
> allowing some optimization of the interfaces between it and the rest of
> the SELinux code, but I wouldn't want to e.g. directly expose the
> policydb to the rest of the code.  There has been some leakage of
> policy awareness outside the security server in the past but I view
> that as a mistake that ought to be corrected over time.

I agree that a level of abstraction between the policydb code and the
enforcement code is a good thing, but I think there are some
boundaries between the hook code and the security server that we could
do without.  Once again, not really part of this work, just popped up
in my head again while looking at these patches.

-- 
paul moore
www.paul-moore.com
