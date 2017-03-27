Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2RINngm028761
 for <selinux@tycho.nsa.gov>; Mon, 27 Mar 2017 14:23:51 -0400
Received: by mail-vk0-f52.google.com with SMTP id z204so62139926vkd.1
 for <selinux@tycho.nsa.gov>; Mon, 27 Mar 2017 11:23:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <36ca17b3-8afe-cb9c-05bb-d406d37361e6@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
 <CAHC9VhTf6LdUNJHV9G+YA=P1rj78v5WKG8v+QNoFGZ6DA+mDmQ@mail.gmail.com>
 <ecce7c5c-cbeb-5896-ec12-26c97619c102@users.sourceforge.net>
 <CAHC9VhTOnQ5uJtb16CuNtsvOOg3C4k1H6fm8ytWJRKc45K=eNw@mail.gmail.com>
 <36ca17b3-8afe-cb9c-05bb-d406d37361e6@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Mar 2017 14:23:47 -0400
Message-ID: <CAHC9VhS81-9mFw8Eft8wf6C9MyDVGe8eB3Xvu8884-==5+H4mw@mail.gmail.com>
Subject: Re: selinux: Delete an error message for a failed memory allocation
 in policydb_read()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 27, 2017 at 1:56 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> …, but I like the error message.
>
> How do you think about to pass the flag “__GFP_NOWARN” if you like
> this information more than the default error reporting of the function “kmalloc”?

Possibly, although I would encourage you to just leave it as-is for
the moment.  Reviewing and merging patches carries a cost, and I would
very much prefer to allocate my time/resources on changes that have a
more significant impact.  I don't want to discourage your from
contributing to SELinux development, but I do want to strongly
encourage you to contribute more meaningful patches.

-- 
paul moore
www.paul-moore.com
