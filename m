Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0D1cWWF015675
 for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2015 20:38:32 -0500
From: John Brooks <john.brooks@jolla.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] Use a better hash function for libsepol's avtab
Date: Tue, 13 Jan 2015 01:38:30 +0000
Message-ID: <336D0B16-7046-4AA3-B002-B13877CBF3BC@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-3-git-send-email-john.brooks@jolla.com>
 <54B404CC.90908@tycho.nsa.gov>
In-Reply-To: <54B404CC.90908@tycho.nsa.gov>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Jan 12, 2015, at 10:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> On 01/07/2015 05:03 PM, John Brooks wrote:
>> This function, based on murmurhash3, has much better distribution than
>> the original. Using the current default of 4096 buckets, there are many
>> fewer collisions:
> 
> Thanks, this looks like a significant improvement for neverallow
> checking.  I'm trying to make sure I understand what if any implications
> it has for other uses of the avtab, since the neverallow checker is
> unusual in that it fully expands all entries.
> 
> On Fedora 20 policy, checkpolicy -Mb
> /etc/selinux/targeted/policy/policy.29 before and after this patch (with
> avtabh_hash_eval called) shows:
> 
> before.txt:rules:  101401 entries and 8169/8192 buckets used, longest
> chain length 84
> betterhash.txt:rules:  101401 entries and 8192/8192 buckets used,
> longest chain length 27
> 
> So that's a definite improvement.
> 
> Could you amend your code to define constants for the various magic
> values used above?  Thanks.

The magic values are nothing but magic from the original murmurhash3. They don’t have any useful names. I did remove ‘c1’ and ‘c2’ in favor of using their values inline, since each is only used once. Is that enough?

(Also, sorry for my last mail to this list; it was butchered by my mail client. Hopefully this one works.)
