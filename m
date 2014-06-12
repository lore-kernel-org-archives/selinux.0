MIME-Version: 1.0
In-Reply-To: <5399FD14.60101@tycho.nsa.gov>
References: <5399FD14.60101@tycho.nsa.gov>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 12 Jun 2014 12:28:12 -0700
Message-ID: <CALCETrVbD3NxxhJsjiAGcEE-5yjH34+BijTHrOFiefwotu6krA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Permit transitions under NO_NEW_PRIVS or NOSUID
 under certain, circumstances.
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 12, 2014 at 12:18 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>

One more minor nit:

"If the caller SID is bounded by the callee SID"

Is that backwards?  I think the code is correct, but I'm less
convinced by the changelog.


-- 
Andy Lutomirski
AMA Capital Management, LLC
