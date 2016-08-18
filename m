Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7ICu2NF023158
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 08:56:05 -0400
Received: by mail-oi0-f52.google.com with SMTP id l203so20884442oib.1
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 05:56:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160818055627.GH1304@madcap2.tricolour.ca>
References: <1469544870-11574-1-git-send-email-jeffv@google.com>
 <CAHC9VhS=odoi8NFFGP36VAMcL_Gbbin+0pyTj-MNcsPZKit0GQ@mail.gmail.com>
 <20160818055627.GH1304@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Aug 2016 08:55:59 -0400
Message-ID: <CAHC9VhS9i3ezg=buaB5FCeJDnDtE2qUBx4tr1yfdBPXOuODMjQ@mail.gmail.com>
Subject: Re: [PATCH] security: lsm_audit: print pid and tid
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, sgrubb@redhat.com,
 linux-audit@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 18, 2016 at 1:56 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2016-08-17 16:58, Paul Moore wrote:
>> However, as far as I can see, the biggest problem with this patch is
>> that it adds a field in the middle of a record which will likely cause
>> the audit userspace tools to explode (or so I've been warned in the
>> past).  Steve, what say you about the userspace?
>
> Adding fields in the middle isn't necessarily a problem if it doesn't
> confuse the existing scanner, which can skip over fields about which it
> does not care.  I've carefully added fields in the middle in the past,
> trying my best to group it logically with the rest of the information as
> has been requested, I think: subject, action, object, result.

I've ranted about this before so I won't do it again here, but
ultimately the problem is that the guidance for userspace
applications/libraries has been that you can expect certain fields in
specific locations.

-- 
paul moore
www.paul-moore.com
