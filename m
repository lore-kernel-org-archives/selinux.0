MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC562AB00FDB@FMSMSX153.amr.corp.intel.com>
References: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC562AB00FDB@FMSMSX153.amr.corp.intel.com>
From: Nick Kralevich <nnk@google.com>
Date: Fri, 7 Apr 2017 10:57:06 -0700
Message-ID: <CAFJ0LnGx6MgLsS1H2gxBUQT+8ONDX2RNuaa44yFu56VNGw2WOw@mail.gmail.com>
Subject: Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: SELinux <Selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In the interests of avoiding duplicate conversation in multiple
places, let's continue this discussion at
https://android-review.googlesource.com/367695

-- Nick

On Fri, Apr 7, 2017 at 10:43 AM, Roberts, William C
<william.c.roberts@intel.com> wrote:
> Nack… use Booleans
>
> Allow Android to have 1 boolean that init trips, once innit trips it, the
> allow to load policy is removed and also the rule to allow toggling that
> Boolean is removed
>
