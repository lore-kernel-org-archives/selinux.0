Subject: Re: [PATCH 2/2] libselinux: procattr: return einval for <= 0 pid args.
To: Nick Kralevich <nnk@google.com>, Daniel Cashman <dcashman@android.com>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
 <1456259040-13721-3-git-send-email-dcashman@android.com>
 <56CCC13F.3060709@android.com>
 <CAFJ0LnH=zQuJ6mSBSQu4XBjQ-jHnOpKveh7TwE55WLxfj5KGXQ@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Jeffrey Vander Stoep <jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56D481FC.9010009@tycho.nsa.gov>
Date: Mon, 29 Feb 2016 12:38:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnH=zQuJ6mSBSQu4XBjQ-jHnOpKveh7TwE55WLxfj5KGXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/23/2016 04:22 PM, Nick Kralevich wrote:
> Thanks for proposing this patch Dan.
>
> As you said, the current API feels error prone, as it has two entirely
> different behaviors depending on whether the pid is zero or non-zero.
> Your patch corrects this error prone API and clearly separates out a
> query by PID vs a query of the process itself.
>
> This patch helps provide robustness against bugs similar to:
>
>    https://code.google.com/p/google-security-research/issues/detail?id=727
>    https://code.google.com/p/android/issues/detail?id=200617
>
> (note that the Android code in question was reviewed by Stephen,
> myself, and others within Google, and we all missed this particular
> bug)
>
> I would recommend the upstream SELinux community accept the patch,
> even at the potential expense of breaking compatibility with other
> apps.

As I haven't heard or seen of anything that would break with this 
change, I've merged this patch.  You'll need to apply it separately to 
Android libselinux since that is still a fork.
