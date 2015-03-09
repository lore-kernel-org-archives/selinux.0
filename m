Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t29JYsZx003159
 for <selinux@tycho.nsa.gov>; Mon, 9 Mar 2015 15:34:56 -0400
Received: by oiav1 with SMTP id v1so31385750oia.9
 for <selinux@tycho.nsa.gov>; Mon, 09 Mar 2015 12:34:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRwTvimSHLToG9mkk5jiM7N3CJCR6pR2Sa_mJsHcDwtog@mail.gmail.com>
References: <1424987742-15120-1-git-send-email-jeffv@google.com>
 <54F06DF1.8070605@tycho.nsa.gov>
 <CAHC9VhRwTvimSHLToG9mkk5jiM7N3CJCR6pR2Sa_mJsHcDwtog@mail.gmail.com>
Date: Mon, 9 Mar 2015 15:34:52 -0400
Message-ID: <CAHC9VhSUvWr-e-mzQkn_=YrwS_OMwHMSAfzO4bi_DZNGGTv4Sg@mail.gmail.com>
Subject: Re: [PATCH] avc: remove unnecessary pointer reassignment
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: jvanderstoep@gmail.com, James Morris <james.l.morris@oracle.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 4, 2015 at 1:07 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 27, 2015 at 8:15 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 02/26/2015 04:54 PM, Jeff Vander Stoep wrote:
>>> Commit f01e1af445fa ("selinux: don't pass in NULL avd to avc_has_perm_noaudit")
>>> made this pointer reassignment unnecessary. Avd should continue to reference
>>> the stack-based copy.
>>>
>>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>>
>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
> Thanks everyone for the patch and the review.  I'll merge this next
> week into selinux#next.

I apologize for the delay, but I just merged this into selinux#next;
it should be in the next linux-next kernel.

-- 
paul moore
www.paul-moore.com
