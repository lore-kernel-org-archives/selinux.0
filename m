Message-ID: <53500ECB.8090702@tycho.nsa.gov>
Date: Thu, 17 Apr 2014 13:26:35 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: Regarding call security_compute_av()
References: <5350090C.6020503@tycho.nsa.gov>
In-Reply-To: <5350090C.6020503@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2014 12:50 AM, Kernel Geek wrote:
> You are correct, I almost forgot about AVC part where access is first
> checked in cache  before checking in policy database. Lets take a
> hypothetical scenario. If i modify avc_has_perm() and just set rc=0 and
> return it every-time, will access be allowed every-time? I just want to
> test some things, one of which includes allowing all access. 
> Secondly, I am still not clear how SELinux policy database works, how it
> works in conjunction with SELinux. I cannot find any good papers or
> anything which target it. Do you know some? Please let me know. Thank
> you once again stephen.

You don't even need to modify avc_has_perm(), just keep your system in
permissive mode and you'll be doing exactly that.  See
security/selinux/avc.c:avc_denied() in the current kernel for the logic
that handles permissive mode differently and turns all such "denials"
into grantings.

Not sure exactly what you are looking for, but the original technical
report is likely the best walkthrough of the entire code path even
though it is obviously out of date,
http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml

Or you can just walk through the current code.

Adam Langley of Google did a nice job of walking through the code at one
point, see
https://www.imperialviolet.org/2009/07/14/selinux.html
