Message-ID: <50BE5764.40604@draigBrady.com>
Date: Tue, 04 Dec 2012 20:04:52 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: SE-Linux <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] doc: context_new(3): fix the return value description
References: <1354588382-19083-1-git-send-email-P@draigBrady.com> <CACLa4puED9wO0jyq1iGUxbBsQx3maLeKu8=1ae37GSjW2dmKeA@mail.gmail.com>
In-Reply-To: <CACLa4puED9wO0jyq1iGUxbBsQx3maLeKu8=1ae37GSjW2dmKeA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/04/2012 07:05 PM, Eric Paris wrote:
> On Mon, Dec 3, 2012 at 9:33 PM, Pádraig Brady<P@draigbrady.com>  wrote:
>
> I applied (and gave you credit for) the following patch.  Does it look
> ok to you?
>
>
> tmp.patch
>
>
> diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/context_new.3

> -On success, zero is returned. On failure, \-1 is returned and
> +On failure
> +.BR context_*_set ()
> +functions return non-zero and 0 on success.
> +
> +The other functions return NULL on failure and non-NULL on success.
> +
> +On failure
>   .I errno
>   is set appropriately.
>   .


thanks,
Pádraig.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
